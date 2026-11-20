#!/usr/bin/env node
// Check the names the API itself defines (HUD field names are left to the ontology check).
//
// Redocly (../redocly.yaml) already requires PascalCase for operationIds, schema names and example
// names. PascalCase cannot see run-together words, though: "ClientsinaProject" is valid PascalCase.
// So this check adds:
//   1. Every word of an operationId, split at capital letters (acronyms such as HMIS stay whole),
//      must be in WORDS below. A run-together word such as "Clientsina" is not, so it fails.
//      To introduce a new word, add it to WORDS; the diff then shows the new name to a reviewer.
//   2. Every name derived from an operation follows from its operationId X: request schema
//      XRequest, success response schema XResponse, examples XRequestExample and XResponseExample.
//      Every other schema must be a HUD field schema (x-hmis-dataDictionaryName), and every
//      example must belong to an operation, so no invented name escapes rule 1.
//   3. Every operationId an Arazzo workflow calls ($sourceDescriptions.<name>.<operationId>) exists.
//
// Usage: node check-names.mjs [path/to/openapi.yaml]
import { readFileSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { createRequire } from "node:module";

const here = dirname(fileURLToPath(import.meta.url));
const YAML = createRequire(import.meta.url)("yaml");
const specPath = process.argv[2] ?? join(here, "..", "hmis-api.openapi.yaml");
const workflowsDir = join(here, "..", "workflows");

const WORDS = new Set([
  "A", "By", "Client", "Clients", "Create", "Enrollments", "For", "Full", "Funder", "HMIS", "In",
  "Or", "Project", "Projects", "Record", "Retrieve", "Search", "Type", "Update",
]);

const spec = YAML.parse(readFileSync(specPath, "utf8"));
const schemas = spec.components?.schemas ?? {};
const examples = spec.components?.examples ?? {};
const errors = [];

const refName = (node) => (node?.$ref ? node.$ref.split("/").pop() : undefined);
const words = (name) => name.match(/[A-Z]+(?![a-z])|[A-Z][a-z]*|[a-z]+|[0-9]+/g) ?? [];

const operationIds = new Set();
const derivedSchemas = new Set();
const derivedExamples = new Set();

for (const [path, item] of Object.entries(spec.paths ?? {})) {
  for (const [method, op] of Object.entries(item)) {
    if (!op || typeof op !== "object" || !("responses" in op)) continue;
    const id = op.operationId;
    if (!id) {
      errors.push(`${method.toUpperCase()} ${path}: no operationId`);
      continue;
    }
    operationIds.add(id);
    const unknown = words(id).filter((w) => !WORDS.has(w));
    if (unknown.length) {
      errors.push(`operationId ${id}: ${unknown.map((w) => `"${w}"`).join(", ")} not in the word list ` +
        `(fix run-together words such as "Searchfor" -> "SearchFor", or add a genuinely new word to WORDS)`);
    }

    const json = (container) => container?.content?.["application/json"];
    const check = (media, kind) => {
      const schema = refName(media?.schema);
      if (schema !== undefined) {
        if (schema !== `${id}${kind}`) errors.push(`${id}: ${kind.toLowerCase()} schema is ${schema}, expected ${id}${kind}`);
        derivedSchemas.add(schema);
      }
      for (const example of Object.values(media?.examples ?? {})) {
        const name = refName(example);
        if (name === undefined) continue;
        if (name !== `${id}${kind}Example`) errors.push(`${id}: ${kind.toLowerCase()} example is ${name}, expected ${id}${kind}Example`);
        derivedExamples.add(name);
      }
    };
    check(json(op.requestBody), "Request");
    for (const [status, response] of Object.entries(op.responses ?? {})) {
      if (/^2\d\d$/.test(status)) check(json(response), "Response");
    }
  }
}

for (const [name, schema] of Object.entries(schemas)) {
  if (!("x-hmis-dataDictionaryName" in schema) && !derivedSchemas.has(name)) {
    errors.push(`schema ${name}: neither a HUD field schema nor the request/response schema of an operation`);
  }
}
for (const name of Object.keys(examples)) {
  if (!derivedExamples.has(name)) errors.push(`example ${name}: not used as an operation's request or response example`);
}

for (const file of readdirSync(workflowsDir).filter((f) => f.endsWith(".arazzo.yaml")).sort()) {
  const text = readFileSync(join(workflowsDir, file), "utf8");
  for (const [, id] of text.matchAll(/operationId:\s*\$sourceDescriptions\.[A-Za-z0-9_-]+\.([A-Za-z0-9_-]+)/g)) {
    if (!operationIds.has(id)) errors.push(`${file}: calls operationId ${id}, which the API does not define`);
  }
}

if (errors.length) {
  console.error(`API name check failed: ${errors.length} problem(s)`);
  for (const e of errors) console.error(`  - ${e}`);
  process.exit(1);
}
console.log(`API name check passed: ${operationIds.size} operationIds, ${derivedSchemas.size} request/response schemas ` +
  `and ${derivedExamples.size} examples follow PascalCase word and derivation rules; workflow operationIds resolve.`);
