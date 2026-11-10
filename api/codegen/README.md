# API code generation

This folder holds the generator configuration and script that build artifacts from the HMIS Data Exchange API description. It replaces the former `hmis-codegen` toolchain and its *hmis-codegen Guide* (PDF), which this page supersedes.

## Overview

The single source of truth is [`../hmis-api.openapi.yaml`](../hmis-api.openapi.yaml), an OpenAPI 3.1 description maintained by hand. Each request and response schema carries an `x-jsonld-context` that maps its JSON fields to terms in the HMIS Logic Model ontology, [`../../FY26_HMIS_Logic_Model.ttl`](../../FY26_HMIS_Logic_Model.ttl) (namespace `urn:hud:hmis:owl#`).

The old `hmis-codegen` read a YAML-LD specification and a JSON-LD ontology and generated `openapi.yaml` and `context.jsonld` from them. That role is gone: the OpenAPI description is now edited directly, and the JSON-LD contexts are taken from it. What is generated here is everything downstream of the description:

- client SDKs for TypeScript and Python, built with [OpenAPI Generator](https://openapi-generator.tech/)
- standalone JSON-LD `@context` files, one per schema plus one merged file
- an HTML API reference, built with [Redocly](https://redocly.com/docs/cli/)

| File | What it is |
| --- | --- |
| [`generate.mjs`](generate.mjs) | The generation script. Plain Node with no shell commands, so it runs the same way on Linux, macOS and Windows. |
| [`openapitools.json`](openapitools.json) | OpenAPI Generator configuration: the generator version and one entry per client SDK. |
| [`package.json`](package.json) | The npm scripts and the pinned tool versions. |
| [`.gitignore`](.gitignore) | Keeps `build/` and `node_modules/` out of git. |

## Where generated code goes

Generated code is normally not committed. CI builds it into a gitignored folder such as build/, dist/ or gen/, then publishes it as a package (npm, PyPI, Maven) or attaches it to a GitHub release.

Here that folder is `api/codegen/build/`.

## Installation

Requirements:

- Node.js 24 or later
- Java 11 or later, because OpenAPI Generator is a Java program
- Python 3 (optional), used only to byte-compile the generated Python client as a check

```bash
cd api/codegen
npm ci
```

`npm ci` installs the pinned tools from `package-lock.json`. The first generation run also downloads the OpenAPI Generator JAR for the version set in `openapitools.json`.

## Basic usage

### 1. Generate everything

```bash
npm run generate
```

This runs these steps in order and stops at the first failure:

1. **Prepare the spec.** Writes `build/openapi.codegen.yaml`, a copy of the description with `x-enum-varnames` added to every enum whose values contain characters outside printable ASCII. Some generators, the Python one among them, turn enum values directly into identifiers, and a character such as an en dash is not legal in an identifier. The added names are ASCII and the values themselves are unchanged. The source description is not modified.
2. **Generate the clients.** Runs OpenAPI Generator once for each entry in `openapitools.json`.
3. **Export JSON-LD.** Writes each schema's `x-jsonld-context` to its own file and merges all of them into one. The step fails if two schemas define the same term differently.
4. **Build the docs.** Runs `redocly build-docs` on the source description.
5. **Verify the clients.** Type-checks the TypeScript client with `tsc --noEmit`, and byte-compiles the Python client if Python is installed.

### 2. Verify existing output

```bash
npm run verify
```

This repeats step 5 without regenerating anything. It fails with "Nothing to verify" if `build/` does not exist yet.

### 3. Remove the output

```bash
npm run clean
```

This deletes `build/`.

## Generated artifacts

```text
build/
├── openapi.codegen.yaml        # the description with x-enum-varnames added
├── clients/
│   ├── typescript/             # typescript-fetch client, npm package @hud-hmis/data-exchange-client
│   └── python/                 # Python client, package hmis_data_exchange_client
├── jsonld/
│   ├── <Schema>.context.jsonld # one per request or response schema (16 at present)
│   └── hmis.context.jsonld     # all of them merged, terms sorted by name
└── docs/
    └── index.html              # HTML API reference
```

Each client folder has its own generated `README.md` that lists its API classes and models.

### JSON-LD contexts (`build/jsonld/`)

These map API field names to ontology terms:

```json
{
  "@context": {
    "@vocab": "urn:hud:hmis:owl#",
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "EntryDate": { "@id": "urn:hud:hmis:owl#EntryDate", "@type": "xsd:date" },
    "PersonalID": { "@id": "urn:hud:hmis:owl#PersonalID" }
  }
}
```

A vendor makes an API payload RDF-compatible by adding the context as `@context`, either inline or as a URL once the file is published:

```json
{
  "@context": "https://example.org/hmis/hmis.context.jsonld",
  "PersonalID": "a1b2c3d4e5f60718293a4b5c6d7e8f90",
  "EntryDate": "2025-10-01"
}
```

The URL above is a placeholder. The contexts are not published anywhere yet.

### Client SDKs (`build/clients/`)

The clients are generated from the operations and schemas in the description. Their settings are in `openapitools.json`:

| Key | Generator | Main settings |
| --- | --- | --- |
| `typescript-client` | `typescript-fetch` | npm name `@hud-hmis/data-exchange-client`, version `0.1.0-proposed`; property and parameter names kept exactly as in the spec |
| `python-client` | `python` | package `hmis_data_exchange_client`, project `hmis-data-exchange-client`, version `0.1.0` |

### API reference (`build/docs/index.html`)

This is a single self-contained HTML page. Open it in a browser.

## Advanced usage

### Add another language

Add an entry under `generator-cli.generators` in `openapitools.json`. `npm run generate` runs every entry. For example:

```json
"java-client": {
  "generatorName": "java",
  "inputSpec": "#{cwd}/build/openapi.codegen.yaml",
  "output": "#{cwd}/build/clients/java",
  "additionalProperties": { "groupId": "gov.hud.hmis", "artifactId": "hmis-data-exchange-client" }
}
```

Keep `inputSpec` pointed at `build/openapi.codegen.yaml` so the new client gets the enum names. The available generators and their options are listed at <https://openapi-generator.tech/docs/generators>. `verify` checks only the TypeScript and Python clients, so add a check to `verify()` in `generate.mjs` if the new client should be checked as well.

### Change the OpenAPI Generator version

Change `generator-cli.version` in `openapitools.json`. The new JAR downloads on the next run.

## Integration example

### Turn a payload into RDF with the generated context

```python
import json
from rdflib import Graph

with open("api/codegen/build/jsonld/hmis.context.jsonld", encoding="utf-8") as f:
    context = json.load(f)["@context"]

payload = {"PersonalID": "a1b2c3d4e5f60718293a4b5c6d7e8f90", "EntryDate": "2025-10-01"}
payload["@context"] = context

g = Graph()
g.parse(data=json.dumps(payload), format="json-ld")

query = """
SELECT ?record ?entry WHERE {
  ?record <urn:hud:hmis:owl#EntryDate> ?entry .
}
"""
for row in g.query(query):
    print(row.record, row.entry)
```

Every field becomes a triple whose predicate is the field's ontology term, such as `urn:hud:hmis:owl#PersonalID`.

## CI/CD integration

[`.github/workflows/api-codegen.yml`](../../.github/workflows/api-codegen.yml) runs on every push and pull request that changes `api/**`. It installs Java 21, Node 24 and Python 3.12, runs `npm ci` and `npm run generate`, and uploads the clients, the JSON-LD files and the docs as one build artifact named `hmis-api-generated`. Nothing generated is committed.

The contract tests are separate. They live in [`../tests/`](../tests/) and run from [`.github/workflows/api-tests.yml`](../../.github/workflows/api-tests.yml).

## Development workflow

1. Edit [`../hmis-api.openapi.yaml`](../hmis-api.openapi.yaml). If you add or rename a field, update the schema's `x-jsonld-context` as well.
2. Run the contract tests: `cd ../tests && npm test`. These lint the description and check its examples against its schemas.
3. Regenerate and check the clients: `cd ../codegen && npm run generate`.
4. Open `build/docs/index.html` to review the reference.

## Troubleshooting

**`java: not found`, or `openapi-generator: typescript-client failed`.** OpenAPI Generator needs Java 11 or later on `PATH`. Install a JDK, for example Temurin, then run `java -version` to confirm.

**`JSON-LD conflict for "<term>" in <Schema>`.** Two schemas map the same field name to different ontology terms or datatypes. Make the two `x-jsonld-context` entries agree.

**`Nothing to verify: run npm run generate first.`** `npm run verify` checks existing output. Run `npm run generate` first.

**`Python not found, skipping the Python client check`.** This is a warning, not a failure. Install Python 3 to include the check.

**A generated client has a broken enum name.** Enum values containing characters outside printable ASCII get ASCII names automatically. For other cases, add `x-enum-varnames` to that enum in the source description.

## Best practices

1. **Edit the description, never the output.** Anything in `build/` is overwritten on the next run.
2. **Keep the JSON-LD contexts in step with the schemas.** Every field should have a context term that maps to a property declared in the ontology.
3. **Version the ontology.** Its version is `owl:versionInfo` in `FY26_HMIS_Logic_Model.ttl`.
4. **Pin tool versions.** The npm tools are pinned in `package.json` and `package-lock.json`, and OpenAPI Generator in `openapitools.json`.

## Not carried over from hmis-codegen

These features of the old toolchain have no equivalent here. The old code survives only in the repository history, which `git log --oneline -- '*hmis-codegen*'` lists.

- **YAML-LD to OpenAPI generation**: the OpenAPI description is now maintained by hand.
- **Generation from a JSON-LD ontology export**: the ontology is now the Turtle file, and the contexts come from the description.
- **Algebraic effect annotations (`x-effects`), effect handler interfaces and mock handlers**: the description has no effect annotations.
- **Mockoon environment**: the contract tests use a [Prism](https://stoplight.io/open-source/prism) mock server generated from the same description instead.
- **FHIR R4 transformer, bundle template and FHIR mappings file**: no FHIR mapping is maintained.
- **Rust/WASM validator**: this was an unfinished prototype.
- **`extract` and `info` commands**: the field-to-term mapping can be read directly from each schema's `x-jsonld-context`, or from `build/jsonld/`.

## Support and contributing

- API description and design notes: [`../README.md`](../README.md)
- Contract tests: [`../tests/`](../tests/)
- Ontology: [`../../FY26_HMIS_Logic_Model.ttl`](../../FY26_HMIS_Logic_Model.ttl)
- Other documentation: [`../../doc/`](../../doc/)

## License

MIT. See [`../../LICENSE`](../../LICENSE).
