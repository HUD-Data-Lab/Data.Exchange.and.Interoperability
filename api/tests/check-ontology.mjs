#!/usr/bin/env node
// Check that the API description and the HMIS Logic Model ontology agree, so they cannot drift apart.
//
// For every request/response schema that carries an x-jsonld-context, each field must:
//   1. have exactly one context term, and every term must be a property of the schema;
//   2. map to the same IRI and @type in every schema that uses it;
//   3. map to a property the ontology declares (owl:DatatypeProperty or owl:ObjectProperty),
//      unless the schema lists the field in x-hmis-unmapped-fields. A listed field must not be
//      declared, so the list cannot go stale;
//   4. if the term has an @type, use one of the property's rdfs:range values;
//   5. cite in x-hmis-vocabulary, as a string, a data element number the property has as dcterms:identifier.
//
// Every field schema (a schema with x-hmis-dataDictionaryName) must:
//   6. carry its own x-jsonld-context term definition, with "@id" urn:hud:hmis:owl#<name> (or the
//      property FIELD_PROPERTY_EXCEPTIONS names for that field) and the same "@type" (or none) as the
//      object-level contexts, unless the field is only ever listed in x-hmis-unmapped-fields, in which
//      case it must carry none.
//
// Every x-jsonld-type (the class an object represents) must:
//   7. be an owl:Class declared in the ontology.
//
// Code-list fields (the property is an owl:ObjectProperty whose :linkedVocabulary names SKOS concept
// schemes) must:
//   8. use "@type": "@vocab" with a scoped "@context" that maps exactly the field's enum labels, each
//      to a skos:Concept in one of the property's linked schemes (all in the same scheme), whose
//      skos:notation is the field's x-hmis-values notation and whose skos:prefLabel is the label
//      (ignoring apostrophe style and spacing). The enclosing context must declare "@version": 1.1.
//      Every other field must not use "@vocab" or a scoped context. CODE_LIST_EXCEPTIONS lists the
//      fields that cannot be mapped, with the reason.
//
// Usage: node check-ontology.mjs [path/to/ontology.ttl] [path/to/openapi.yaml]
// Exits 1 and lists every problem if any check fails.
import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { createRequire } from "node:module";

const here = dirname(fileURLToPath(import.meta.url));
const require = createRequire(import.meta.url);
const N3 = require("n3");
const YAML = require("yaml");

const ontologyPath = process.argv[2] ?? join(here, "..", "..", "FY26_HMIS_Logic_Model.ttl");
const specPath = process.argv[3] ?? join(here, "..", "hmis-api.openapi.yaml");

const RDF_TYPE = "http://www.w3.org/1999/02/22-rdf-syntax-ns#type";
const RDFS_RANGE = "http://www.w3.org/2000/01/rdf-schema#range";
const DCT_IDENTIFIER = "http://purl.org/dc/terms/identifier";
const OWL_CLASS = "http://www.w3.org/2002/07/owl#Class";
const XSD = "http://www.w3.org/2001/XMLSchema#";
const HMIS = "urn:hud:hmis:owl#";
const OWL_OBJECT_PROPERTY = "http://www.w3.org/2002/07/owl#ObjectProperty";
const SKOS = "http://www.w3.org/2004/02/skos/core#";
const LINKED_VOCABULARY = `urn:hud:hmis:owl#linkedVocabulary`;
const CODE_LIST_EXCEPTIONS = {
  SubTypeProvided: "an integer whose list (V2.A, V2.B or V2.C) depends on TypeProvided, so no single label map applies",
};
// Fields whose JSON name (the CSV column name) differs from the ontology property's local name.
const FIELD_PROPERTY_EXCEPTIONS = {
  StartDate: "GrantStartDate", // Funder.csv 2.06.3
  EndDate: "GrantEndDate", // Funder.csv 2.06.4
  Event: "EventType", // Event.csv 4.20.2
};
const PROPERTY_TYPES = new Set([
  "http://www.w3.org/2002/07/owl#DatatypeProperty",
  "http://www.w3.org/2002/07/owl#ObjectProperty",
]);

// --- ontology ------------------------------------------------------------------
const properties = new Map(); // iri -> { ranges: Set, identifiers: Set }
const ranges = new Map();
const identifiers = new Map();
const classes = new Set();
const objectProperties = new Set();
const linked = new Map(); // property -> Set of concept schemes
const conceptScheme = new Map(); // concept -> Set of schemes
const conceptNotation = new Map();
const conceptLabel = new Map();
const addTo = (map, key, value) => (map.get(key) ?? map.set(key, new Set()).get(key)).add(value);

for (const quad of new N3.Parser().parse(readFileSync(ontologyPath, "utf8"))) {
  const s = quad.subject.value;
  const p = quad.predicate.value;
  if (p === RDF_TYPE && PROPERTY_TYPES.has(quad.object.value)) properties.set(s, true);
  if (p === RDF_TYPE && quad.object.value === OWL_OBJECT_PROPERTY) objectProperties.add(s);
  if (p === LINKED_VOCABULARY) addTo(linked, s, quad.object.value);
  else if (p === SKOS + "inScheme") addTo(conceptScheme, s, quad.object.value);
  else if (p === SKOS + "notation") conceptNotation.set(s, quad.object.value);
  else if (p === SKOS + "prefLabel") conceptLabel.set(s, quad.object.value);
  else if (p === RDF_TYPE && quad.object.value === OWL_CLASS) classes.add(s);
  else if (p === RDFS_RANGE && quad.object.termType === "NamedNode") addTo(ranges, s, quad.object.value);
  else if (p === DCT_IDENTIFIER) addTo(identifiers, s, quad.object.value);
}

// --- API description -------------------------------------------------------------
const spec = YAML.parse(readFileSync(specPath, "utf8"));
const schemas = spec.components?.schemas ?? {};

function resolve(node) {
  while (node && typeof node === "object" && "$ref" in node) {
    node = node.$ref.slice(2).split("/").reduce((target, part) => target[part], spec);
  }
  return node ?? {};
}

function expand(value, prefixes, vocab) {
  const i = value.indexOf(":");
  if (i >= 0) {
    const prefix = value.slice(0, i);
    return prefix in prefixes ? prefixes[prefix] + value.slice(i + 1) : value;
  }
  return (vocab ?? "") + value;
}

function terms(context) {
  const vocab = context["@vocab"];
  const prefixes = Object.fromEntries(
    Object.entries(context).filter(
      ([key, value]) => !key.startsWith("@") && typeof value === "string" && /[#/]$/.test(value),
    ),
  );
  const result = new Map();
  for (const [key, value] of Object.entries(context)) {
    if (key.startsWith("@") || key in prefixes) continue;
    if (typeof value === "string") result.set(key, { iri: expand(value, prefixes, vocab), type: null });
    else if (value && typeof value === "object") {
      result.set(key, {
        iri: expand(value["@id"] ?? key, prefixes, vocab),
        type: value["@type"] === "@vocab" ? "@vocab" : value["@type"] ? expand(value["@type"], prefixes, vocab) : null,
        scoped: value["@context"] ?? null,
      });
    }
  }
  return result;
}

// --- checks ----------------------------------------------------------------------
const errors = [];
let codeListTerms = 0;
const normLabel = (s) => String(s).replace(/[‘’]/g, "'").replace(/[–—]/g, "-").replace(/\s*,\s*/g, ",").replace(/\s+/g, " ").trim().toLowerCase();

function checkCodeList(where, term, schemes, fieldSchema, version) {
  codeListTerms++;
  if (!objectProperties.has(term.iri)) errors.push(`${where}: ${term.iri} links a concept scheme but is not an owl:ObjectProperty`);
  if (term.type !== "@vocab" || !term.scoped || typeof term.scoped !== "object") {
    errors.push(`${where}: code-list field needs "@type": "@vocab" and a scoped "@context" mapping its labels to concepts of ${[...schemes].join(", ")}`);
    return;
  }
  if (version !== 1.1) errors.push(`${where}: the enclosing x-jsonld-context needs "@version": 1.1 for its scoped contexts`);
  const enumLabels = (fieldSchema.enum ?? []).map(String);
  const notations = new Map((fieldSchema["x-hmis-values"] ?? []).map((v) => [String(v.preflabel), String(v.notation)]));
  const keys = Object.keys(term.scoped);
  const missing = enumLabels.filter((l) => !keys.includes(l));
  const extra = keys.filter((k) => !enumLabels.includes(k));
  if (missing.length) errors.push(`${where}: scoped @context has no concept for ${missing.map((l) => `"${l}"`).join(", ")}`);
  if (extra.length) errors.push(`${where}: scoped @context maps ${extra.map((l) => `"${l}"`).join(", ")}, which is not in the field's enum`);
  const used = new Set();
  for (const [label, concept] of Object.entries(term.scoped)) {
    const inSchemes = conceptScheme.get(concept);
    if (!inSchemes) { errors.push(`${where}: "${label}" maps to ${concept}, which is not a skos:Concept in the ontology`); continue; }
    const scheme = [...inSchemes].find((s) => schemes.has(s));
    if (!scheme) { errors.push(`${where}: "${label}" maps to ${concept}, which is not in ${[...schemes].join(", ")}`); continue; }
    used.add(scheme);
    const expected = notations.get(label);
    if (expected !== undefined && conceptNotation.get(concept) !== expected) {
      errors.push(`${where}: "${label}" maps to ${concept} with notation ${conceptNotation.get(concept)}, but x-hmis-values gives ${expected}`);
    }
    if (normLabel(conceptLabel.get(concept)) !== normLabel(label)) {
      errors.push(`${where}: "${label}" maps to ${concept}, whose skos:prefLabel is "${conceptLabel.get(concept)}"`);
    }
  }
  if (used.size > 1) errors.push(`${where}: labels map into more than one scheme (${[...used].join(", ")})`);
}

const seen = new Map(); // term -> "iri @type" from the first schema that defined it
const mappedTerms = new Map(); // field -> { iri, type } where an object maps it to the ontology
const unmappedFields = new Set();
let schemaCount = 0;
const checkedFields = new Set();

for (const [name, schema] of Object.entries(schemas)) {
  const context = schema["x-jsonld-context"];
  if (!context || "x-hmis-dataDictionaryName" in schema) continue; // field schemas are checked below
  schemaCount++;
  const props = schema.properties ?? {};
  const unmapped = new Set(schema["x-hmis-unmapped-fields"] ?? []);
  const defined = terms(context);

  for (const field of Object.keys(props)) {
    if (!defined.has(field)) errors.push(`${name}.${field}: no x-jsonld-context term`);
  }
  for (const field of unmapped) {
    if (!(field in props)) errors.push(`${name}: x-hmis-unmapped-fields lists ${field}, which is not a property`);
  }

  for (const [field, term] of defined) {
    if (!(field in props)) {
      errors.push(`${name}: x-jsonld-context defines ${field}, which is not a property`);
      continue;
    }
    const signature = `${term.iri} ${term.type ?? "(no @type)"} ${term.scoped ? JSON.stringify(term.scoped) : ""}`;
    const first = seen.get(field);
    if (first && first.signature !== signature) {
      errors.push(`${field}: ${first.schema} maps it to ${first.signature}, ${name} to ${signature}`);
    } else if (!first) {
      seen.set(field, { schema: name, signature });
    }

    if (unmapped.has(field)) {
      unmappedFields.add(field);
      if (properties.has(term.iri)) {
        errors.push(`${name}.${field}: listed in x-hmis-unmapped-fields, but the ontology declares ${term.iri}; remove it from the list`);
      }
      continue;
    }
    if (!properties.has(term.iri)) {
      errors.push(`${name}.${field}: ${term.iri} is not a property in the ontology (add it there, or list the field in x-hmis-unmapped-fields)`);
      continue;
    }
    checkedFields.add(field);
    if (!mappedTerms.has(field)) mappedTerms.set(field, term);

    let fieldSchema = resolve(props[field]);
    if (fieldSchema.type === "array" && fieldSchema.items) fieldSchema = resolve(fieldSchema.items);

    const schemes = linked.get(term.iri);
    if (schemes && !(field in CODE_LIST_EXCEPTIONS)) {
      checkCodeList(`${name}.${field}`, term, schemes, fieldSchema, context["@version"]);
    } else if (term.type === "@vocab" || term.scoped) {
      errors.push(`${name}.${field}: uses "@vocab"/a scoped @context, but ${term.iri} is not a code-list property` +
        (field in CODE_LIST_EXCEPTIONS ? ` (listed in CODE_LIST_EXCEPTIONS: ${CODE_LIST_EXCEPTIONS[field]})` : ""));
    } else {
      const range = ranges.get(term.iri) ?? new Set();
      if (term.type && !range.has(term.type)) {
        const allowed = range.size ? [...range].join(", ") : "none declared";
        errors.push(`${name}.${field}: @type ${term.type} is not an rdfs:range of ${term.iri} (ontology: ${allowed})`);
      }
    }
    const element = fieldSchema["x-hmis-vocabulary"];
    if (element !== undefined && typeof element !== "string") {
      errors.push(`${name}.${field}: x-hmis-vocabulary ${element} must be a string (quote it in the YAML)`);
    } else if (element !== undefined) {
      const ids = identifiers.get(term.iri) ?? new Set();
      if (!ids.has(String(element))) {
        const known = ids.size ? [...ids].join(", ") : "none";
        errors.push(`${name}.${field}: x-hmis-vocabulary ${element} is not a dcterms:identifier of ${term.iri} (ontology: ${known})`);
      }
    }
  }
}

if (schemaCount === 0) errors.push("No schema carries x-jsonld-context, so nothing was checked");

// --- field schemas: their own term definition ----------------------------------
let fieldContexts = 0;
for (const [name, schema] of Object.entries(schemas)) {
  if (!("x-hmis-dataDictionaryName" in schema)) continue;
  const own = schema["x-jsonld-context"];
  const objectTerm = mappedTerms.get(name);
  if (!objectTerm) {
    if (own !== undefined && unmappedFields.has(name)) {
      errors.push(`${name}: listed in x-hmis-unmapped-fields, so its field schema must not carry x-jsonld-context`);
    }
    if (own === undefined || unmappedFields.has(name)) continue;
  }
  if (own === undefined) {
    errors.push(`${name}: field schema has no x-jsonld-context (expected "@id": ${HMIS}${FIELD_PROPERTY_EXCEPTIONS[name] ?? name})`);
    continue;
  }
  if (!own || typeof own !== "object" || Array.isArray(own) || typeof own["@id"] !== "string") {
    errors.push(`${name}: field schema x-jsonld-context must be a term definition with an "@id"`);
    continue;
  }
  fieldContexts++;
  const iri = own["@id"];
  const type = own["@type"] === "@vocab" ? "@vocab" : typeof own["@type"] === "string" ? own["@type"].replace(/^xsd:/, XSD) : null;
  const expected = HMIS + (FIELD_PROPERTY_EXCEPTIONS[name] ?? name);
  if (iri !== expected) errors.push(`${name}: field schema x-jsonld-context "@id" is ${iri}, expected ${expected}`);
  if (!properties.has(iri)) errors.push(`${name}: field schema x-jsonld-context "@id" ${iri} is not a property in the ontology`);
  if (objectTerm && (objectTerm.type ?? null) !== type) {
    errors.push(`${name}: field schema "@type" is ${type ?? "(none)"}, but the object-level contexts use ${objectTerm.type ?? "(none)"}`);
  }
  if (objectTerm && JSON.stringify(objectTerm.scoped ?? null) !== JSON.stringify(own["@context"] ?? null)) {
    errors.push(`${name}: field schema scoped "@context" differs from the object-level contexts`);
  }
  const range = ranges.get(iri) ?? new Set();
  if (type && type !== "@vocab" && !range.has(type)) {
    errors.push(`${name}: field schema "@type" ${type} is not an rdfs:range of ${iri} (ontology: ${range.size ? [...range].join(", ") : "none declared"})`);
  }
}

// --- object types ----------------------------------------------------------------
let objectTypes = 0;
for (const [name, schema] of Object.entries(schemas)) {
  if (!("x-jsonld-type" in schema)) continue;
  objectTypes++;
  const cls = schema["x-jsonld-type"];
  if (typeof cls !== "string" || !classes.has(cls)) {
    errors.push(`${name}: x-jsonld-type ${cls} is not an owl:Class in the ontology`);
  }
}

const unique = [...new Set(errors)];
if (unique.length) {
  console.error(`API/ontology check failed: ${unique.length} problem(s)`);
  for (const e of unique) console.error(`  - ${e}`);
  process.exit(1);
}
console.log(
  `API/ontology check passed: ${schemaCount} schemas, ${checkedFields.size} fields matched to ontology properties ` +
    `(${properties.size} declared), ${codeListTerms} code-list terms mapped to SKOS concepts, ` +
    `${fieldContexts} field-schema contexts and ${objectTypes} x-jsonld-type ` +
    `class links verified; datatypes and data element numbers agree.`,
);
