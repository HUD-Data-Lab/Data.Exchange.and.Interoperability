# HMIS Data Exchange API

| Path | What it is |
| --- | --- |
| `hmis-api.openapi.yaml` | One OpenAPI 3.1 description of the eight FY2026 baseline scenarios, consolidated from the former `Artifacts/CommonScenariosJSON/FY2026/*.json` files. |
| `workflows/*.arazzo.yaml` | Proposed multi-step scenarios in [Arazzo 1.0](https://spec.openapis.org/arazzo/latest.html), the OpenAPI Initiative's workflow format. |
| `tests/` | Contract tests run with [Newman](https://github.com/postmanlabs/newman), locally or in CI. |
| `codegen/` | Generator config and scripts that build client SDKs (TypeScript, Python), standalone JSON-LD context files and HTML docs from the OpenAPI description. Output goes to the gitignored `codegen/build/`. See [codegen/README.md](codegen/README.md). |
| [`DataExchangeScenarioList.md`](DataExchangeScenarioList.md) | The eight scenarios and the data elements each one uses in its request and response. It was converted from `DataExchangeScenarioList.xlsx`, a copy of the former `Translation Layer/datasource/DataExchangeScenarioOntology.xlsx`. |
| `redocly.yaml` | Lint settings for the OpenAPI and Arazzo files. |

## The OpenAPI description

- **Field schemas** are the ones in the FY2026 scenario files, unchanged except that the non-standard `DataDictionaryName` keyword is now `x-hmis-dataDictionaryName`, matching the files' other `x-hmis-` extensions. Validators reject unknown keywords that lack the `x-` prefix. Each field is defined once under `components/schemas` and shared by every operation that uses it.
- **Paths and methods** follow the baseline scenarios in `doc/HMIS API Reference Guide v1.0.md`. The scenario files define operations but no URLs, so the paths are proposals. Searches use `POST`, so identifying information stays out of URLs and logs.
- **Examples** are illustrative values generated from the schemas, not real client data.
- **Responses** are single objects, as in the source files. List scenarios (4 to 7) will probably need to return arrays.

## JSON-LD: the bridge to the ontology

Every request and response object carries an `x-jsonld-context`. It maps each JSON field to its term in the HMIS Logic Model ontology (`FY26_HMIS_Logic_Model.ttl`, namespace `urn:hud:hmis:owl#`):

```json
{
  "@vocab": "urn:hud:hmis:owl#",
  "PersonalID": { "@id": "urn:hud:hmis:owl#PersonalID" },
  "EntryDate":  { "@id": "urn:hud:hmis:owl#EntryDate", "@type": "xsd:date" }
}
```

A client turns a payload into linked data by sending or adding that object as `@context`. The ontology stays API-free, and the API stays ontology-aware.

The types are linked too, using the keywords of the IETF draft [REST API Linked Data Keywords](https://datatracker.ietf.org/doc/draft-polli-restapi-ld-keywords/):

- **Field schemas.** Each field schema under `components/schemas` (`ADAP`, `EntryDate`, ...) carries its own `x-jsonld-context` term definition: the ontology property as `"@id"` and, where the object contexts give one, the same datatype as `"@type"` (written as a full IRI, since a lone term definition has no `xsd:` prefix in scope). Code-list and plain-string fields have no `"@type"`.
- **Code-list fields.** In the ontology each HMIS code list is a `skos:ConceptScheme` (for example `:list_NoYesReasonsForMissing`, list 1.8) with one `skos:Concept` per value (`:list_NoYesReasonsForMissing_1` is "Yes"). A field that takes a code-list value has `"@type": "@vocab"` and a scoped `"@context"` that maps each label the API sends to its concept, so `"ADAP": "Yes"` becomes a link to `:list_NoYesReasonsForMissing_1` rather than the string "Yes". The contexts that contain such maps declare `"@version": 1.1`. `SubTypeProvided` is the one exception: it is an integer whose list (V2.A, V2.B or V2.C) depends on `TypeProvided`, so it stays a plain value.
- **Object schemas.** Request and response objects that represent an entity carry `x-jsonld-type`, the ontology class they describe: `Client` for the client scenarios (including the composite Client Full HMIS Record response, which is rooted at a client), `Enrollment` for enrollment results, and `Project` for project results. A JSON-LD consumer adds it as `"@type"` when converting a payload. Request objects of search operations are filter criteria, not entities, so they have none.

Every field maps to a property in the FY2026 Logic Model. Three map to a property with a different name: `StartDate` and `EndDate` (Funder.csv 2.06.3 and 2.06.4) to `GrantStartDate` and `GrantEndDate`, and `Event` (Event.csv 4.20.2) to `EventType`. The C4 Translation Assistance Needed fields (`TranslationNeeded`, `PreferredLanguage`, `PreferredLanguageDifferent`), which the FY2026 standards removed, are no longer part of the Client Full HMIS Record response. A schema can still list a field with no ontology property under `x-hmis-unmapped-fields`; none does now.

## Workflows

| File | Steps | Runs against the FY2026 schemas? |
| --- | --- | --- |
| `search-client-then-enrollments.arazzo.yaml` | Scenario 1, then 5 | Not yet. The SearchForClient response has no `PersonalID` to chain on. |
| `find-project-then-enrollments.arazzo.yaml` | Scenario 6, then 4 | Yes |
| `funder-clients-full-record.arazzo.yaml` | Scenario 7, then 5, then 8 | Yes |
| `project-client-update.arazzo.yaml` | Scenario 4, then 3 | Yes. UpdateClient has no request fields yet, so the changes come from the inputs. |

## Running the tests

Node 24 or later on Linux, macOS or Windows:

```bash
cd api/tests
npm ci && npm test                                           # against a local Prism mock
HMIS_API_BASE_URL=https://hmis.example.org/hmis/v1 npm test   # against a real implementation (bash)
```

```powershell
$env:HMIS_API_BASE_URL = "https://hmis.example.org/hmis/v1"; npm test   # against a real implementation (PowerShell)
```

`npm test` runs `run-tests.mjs`, which lints the OpenAPI and Arazzo files and runs `check-ontology.mjs`, then uses Portman to build a Postman collection from the OpenAPI description, with a contract test for each operation: 2xx status, JSON content type, JSON body, and response schema. Newman then runs that collection. JUnit results are written to `build/newman-results.xml`. CI runs the same script on Linux, macOS and Windows from `.github/workflows/api-tests.yml`.

`check-ontology.mjs` (also `npm run check-ontology`) keeps the API and `FY26_HMIS_Logic_Model.ttl` from drifting apart. It fails if a code-list field's label map is missing a label or points at a concept outside its scheme, or with the wrong notation or label, if a field schema's own `x-jsonld-context` is missing or disagrees with the object contexts, if an `x-jsonld-type` is not an ontology class, if a field's JSON-LD term is not a property the ontology declares (unless the field is listed in `x-hmis-unmapped-fields`), if a listed field has since been added to the ontology, if a term's `@type` is not one of the property's `rdfs:range` values, or if the field's `x-hmis-vocabulary` data element number is not among the property's `dcterms:identifier` values. CI also runs the tests when the ontology file changes.

Names the API defines are checked too. Redocly (`redocly.yaml`) requires PascalCase operationIds, schema names and example names. `check-names.mjs` (also `npm run check-names`) catches what PascalCase cannot, run-together words such as `ClientsinaProject`: every word of an operationId must be in its word list, every request/response schema and example name must be derived from its operationId (`XRequest`, `XResponseExample`, ...), and every operationId a workflow calls must exist.

Not yet covered: security schemes and 4xx responses, which the stricter Redocly `recommended` ruleset flags.
