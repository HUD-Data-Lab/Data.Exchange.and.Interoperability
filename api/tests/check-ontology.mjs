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
const PROPERTY_TYPES = new Set([
  "http://www.w3.org/2002/07/owl#DatatypeProperty",
  "http://www.w3.org/2002/07/owl#ObjectProperty",
]);

// --- ontology ------------------------------------------------------------------
const properties = new Map(); // iri -> { ranges: Set, identifiers: Set }
const ranges = new Map();
const identifiers = new Map();
const addTo = (map, key, value) => (map.get(key) ?? map.set(key, new Set()).get(key)).add(value);

for (const quad of new N3.Parser().parse(readFileSync(ontologyPath, "utf8"))) {
  const s = quad.subject.value;
  const p = quad.predicate.value;
  if (p === RDF_TYPE && PROPERTY_TYPES.has(quad.object.value)) properties.set(s, true);
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
        type: value["@type"] ? expand(value["@type"], prefixes, vocab) : null,
      });
    }
  }
  return result;
}

// --- checks ----------------------------------------------------------------------
const errors = [];
const seen = new Map(); // term -> "iri @type" from the first schema that defined it
let schemaCount = 0;
const checkedFields = new Set();

for (const [name, schema] of Object.entries(schemas)) {
  const context = schema["x-jsonld-context"];
  if (!context) continue;
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
    const signature = `${term.iri} ${term.type ?? "(no @type)"}`;
    const first = seen.get(field);
    if (first && first.signature !== signature) {
      errors.push(`${field}: ${first.schema} maps it to ${first.signature}, ${name} to ${signature}`);
    } else if (!first) {
      seen.set(field, { schema: name, signature });
    }

    if (unmapped.has(field)) {
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

    const range = ranges.get(term.iri) ?? new Set();
    if (term.type && !range.has(term.type)) {
      const allowed = range.size ? [...range].join(", ") : "none declared";
      errors.push(`${name}.${field}: @type ${term.type} is not an rdfs:range of ${term.iri} (ontology: ${allowed})`);
    }

    let fieldSchema = resolve(props[field]);
    if (fieldSchema.type === "array" && fieldSchema.items) fieldSchema = resolve(fieldSchema.items);
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

const unique = [...new Set(errors)];
if (unique.length) {
  console.error(`API/ontology check failed: ${unique.length} problem(s)`);
  for (const e of unique) console.error(`  - ${e}`);
  process.exit(1);
}
console.log(
  `API/ontology check passed: ${schemaCount} schemas, ${checkedFields.size} fields matched to ontology properties ` +
    `(${properties.size} declared), datatypes and data element numbers agree.`,
);
