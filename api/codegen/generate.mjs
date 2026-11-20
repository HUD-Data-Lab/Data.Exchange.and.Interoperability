#!/usr/bin/env node
// Generates everything derived from ../hmis-api.openapi.yaml into build/ (gitignored):
//   build/openapi.codegen.yaml   the spec plus x-enum-varnames where enum values are not plain ASCII
//   build/clients/typescript     typescript-fetch client   (openapitools.json, key "typescript-client")
//   build/clients/python         Python client             (openapitools.json, key "python-client")
//   build/jsonld/                one JSON-LD @context per schema, plus hmis.context.jsonld (all merged)
//   build/docs/index.html        API reference (Redocly)
// Then verifies the clients: TypeScript type-check, Python byte-compile (skipped if Python is missing).
//
// Usage: node generate.mjs [--verify-only] [--clean]
// Needs Node 24+ and Java 11+ (openapi-generator is a Java tool). Plain Node, no shell, so it runs on any OS.

import { spawnSync } from "node:child_process";
import { mkdirSync, readFileSync, rmSync, writeFileSync, existsSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import YAML from "yaml";

const here = dirname(fileURLToPath(import.meta.url));
const require = createRequire(import.meta.url);
const spec = resolve(here, "..", "hmis-api.openapi.yaml");
const build = join(here, "build");
const args = new Set(process.argv.slice(2));

function bin(pkg, rel) {
  return join(dirname(require.resolve(`${pkg}/package.json`)), rel);
}

function run(label, cmd, cmdArgs, opts = {}) {
  console.log(`\n== ${label}`);
  const r = spawnSync(cmd, cmdArgs, { cwd: here, stdio: "inherit", ...opts });
  if (r.error) throw r.error;
  if (r.status !== 0) {
    console.error(`${label} failed (exit ${r.status})`);
    process.exit(r.status ?? 1);
  }
}

function enumVarName(value) {
  const name = String(value).toUpperCase().replace(/[^A-Z0-9]+/g, "_").replace(/^_+|_+$/g, "");
  return name || "EMPTY";
}

// Some generators (Python) turn enum values straight into identifiers, and an en dash
// is not a legal identifier character. x-enum-varnames gives them ASCII names without
// changing the values. Only the codegen copy of the spec gets this; the source spec is untouched.
function prepareSpec() {
  const doc = YAML.parse(readFileSync(spec, "utf8"));
  let count = 0;
  const walk = (node) => {
    if (Array.isArray(node)) return node.forEach(walk);
    if (!node || typeof node !== "object") return;
    if (Array.isArray(node.enum) && !node["x-enum-varnames"] &&
        node.enum.some((v) => typeof v === "string" && /[^\x20-\x7e]/.test(v))) {
      node["x-enum-varnames"] = node.enum.map(enumVarName);
      count++;
    }
    Object.values(node).forEach(walk);
  };
  walk(doc.components?.schemas);
  mkdirSync(build, { recursive: true });
  writeFileSync(join(build, "openapi.codegen.yaml"), YAML.stringify(doc, { lineWidth: 0 }));
  console.log(`== spec: added x-enum-varnames to ${count} enum(s) -> build/openapi.codegen.yaml`);
  return doc;
}

function exportJsonLd(doc) {
  const out = join(build, "jsonld");
  mkdirSync(out, { recursive: true });
  const merged = {};
  let n = 0;
  for (const [name, schema] of Object.entries(doc.components?.schemas ?? {})) {
    const ctx = schema["x-jsonld-context"];
    // Field schemas carry a single term definition, which the object contexts already include.
    if (!ctx || "x-hmis-dataDictionaryName" in schema) continue;
    writeFileSync(join(out, `${name}.context.jsonld`), JSON.stringify({ "@context": ctx }, null, 2) + "\n");
    for (const [k, v] of Object.entries(ctx)) {
      if (k in merged && JSON.stringify(merged[k]) !== JSON.stringify(v)) {
        console.error(`JSON-LD conflict for "${k}" in ${name}`);
        process.exit(1);
      }
      merged[k] = v;
    }
    n++;
  }
  const sorted = Object.fromEntries(Object.entries(merged).sort(([a], [b]) => a.localeCompare(b)));
  writeFileSync(join(out, "hmis.context.jsonld"), JSON.stringify({ "@context": sorted }, null, 2) + "\n");
  console.log(`== jsonld: ${n} context file(s) + hmis.context.jsonld (${Object.keys(sorted).length} terms)`);
}

function generate() {
  const doc = prepareSpec();
  const cli = bin("@openapitools/openapi-generator-cli", "main.js");
  const config = JSON.parse(readFileSync(join(here, "openapitools.json"), "utf8"));
  for (const key of Object.keys(config["generator-cli"].generators)) {
    run(`openapi-generator: ${key}`, process.execPath, [cli, "generate", "--generator-key", key]);
  }
  exportJsonLd(doc);
  run("docs: redocly build-docs", process.execPath, [
    bin("@redocly/cli", "bin/cli.js"), "build-docs", spec, "--output", join(build, "docs", "index.html"),
  ]);
}

function verify() {
  const ts = join(build, "clients", "typescript");
  if (!existsSync(ts)) { console.error("Nothing to verify: run `npm run generate` first."); process.exit(1); }
  run("verify: TypeScript client type-check", process.execPath, [
    bin("typescript", "bin/tsc"), "-p", join(ts, "tsconfig.json"), "--noEmit",
  ]);
  const py = ["python3", "python", "py"].find((c) => spawnSync(c, ["--version"], { stdio: "ignore" }).status === 0);
  if (!py) { console.warn("\n== verify: Python not found, skipping the Python client check"); return; }
  run("verify: Python client byte-compile", py, [
    "-m", "compileall", "-q", join(build, "clients", "python", "hmis_data_exchange_client"),
  ]);
}

if (args.has("--clean")) { rmSync(build, { recursive: true, force: true }); console.log("removed build/"); process.exit(0); }
if (!args.has("--verify-only")) generate();
verify();
console.log("\nDone. Output is in api/codegen/build/ (not committed).");
