# HMIS Ontology v1.4.0-beta: recommendations

This version cleans up the v1.3.0-beta ontology so it is valid, versioned and easier to maintain. It also proposes the next round of changes. Everything here is generated. The fixes are in the R scripts under `Foundation Layer/Ontology Generator/scripts/` and `Translation Layer/scripts/` and in `Foundation Layer/Ontology Generator/datasource/SkosVocabulary.xlsx`, not in hand-edited Turtle, so they survive the next regeneration.

## What changed in v1.4.0-beta

| Area | v1.3.0-beta | v1.4.0-beta | Why |
| --- | --- | --- | --- |
| Namespace | `http://www.semanticweb.org/ontologies/hmis#` (does not resolve, not HUD's) | `urn:hud:hmis#` | A URN needs no web host and names HUD as the owner. File locations are carried by the version IRI instead. |
| Ontology IRI | `http://www.semanticweb.org/61084/ontologies/2026/2/hmis` (a personal Protégé default) | `urn:hud:hmis` | Matches the namespace. |
| Version metadata | none | `owl:versionIRI`, `owl:priorVersion`, `owl:versionInfo` | Lets tools and readers tell versions apart. Version IRIs use raw.githubusercontent.com URLs, so they resolve to Turtle rather than an HTML page. |
| Disjointness | 144 pairwise `owl:disjointWith` axioms | none | They grew as O(N²) and solved no current problem. Combined with multiple `rdfs:domain` values (below), they made ordinary data logically inconsistent. |
| Annotation properties | `csvList`, `dataElementNumber`, `dataElementFieldNumber`, `dataDictionaryName`, `CSVExportTable`, `linkedVocabulary` used but never declared | declared, with labels and comments | Validators and reasoners need declarations. |
| Code typing | every `skos:notation` typed `xsd:integer`, including VAMC station codes such as `459GE` (13 invalid literals) | integer only when the code is numeric | The file now parses without datatype errors. |
| `csvList` values | language-tagged (`"1.1"@en`) | plain literals | They are identifiers, not English text. |
| Abstract classes | `SubEnrollment`, `SubProject`, `SubCEAssessment`, `SubEnrollAssessment` (not in the Data Dictionary, used only for grouping) | removed | Grouping is now carried by the property hierarchy below, so every class has a real meaning. |
| Part relationships | `hasPart` limited to Enrollment; `hasConfiguration`, `hasMeasurement` and `hasSubpart` unrelated to it | one generic `hasPart` / `partOf` pair. `hasConfiguration`, `hasMeasurement`, `hasSubpart` and every specific part property (`hasService`, `hasInventory`, `hasIncome` and so on) are sub-properties of it | A reasoner infers that a Service, an Inventory record or an Income record is `partOf` its parent without any abstract class. This consolidates the compositional properties into one hierarchy. |
| partOf bug | `hasPart owl:inverseOf partOf` (never declared), while the declared `partof` was a second, different inverse | a single declared `partOf` | |
| Inverse sub-properties | `ceAssessmentOf`, `ceEventOf`, `currentLivingSituationOf`, `enrollAssessmentOf` and `serviceOf` were sub-properties of `hasPart`, so a reasoner would conclude a Service *has* its Enrollment as a part | sub-properties of `partOf` | |
| Household direction | `hasHousehold` ran from Household to Enrollment and `householdOf` from Enrollment to Household | `hasHousehold`: Enrollment to Household; `householdOf`: Household to Enrollment | The names now read correctly. |
| Multiple domains | `PersonalID`, `ProjectID`, `OrganizationID`, `CoCCode`, `HousingAssessment`, `InformationDate` each had 2 to 4 `rdfs:domain` statements and were emitted as duplicate blocks | one block each, with an `owl:unionOf` domain | OWL reads multiple domains as an intersection: anything with a `PersonalID` would have been both a Client and an Enrollment. |
| Undeclared classes | `HealthAndDV` and `EmploymentEducation` used as domains but never declared | declared, with `hasHealthAndDV` / `hasEmploymentEducation` under `hasSubpart` | |
| Labels and comments | `User`, `CEQuestion`, `CEResult`, `Geography`, `CEAssessment`, `CurrentLivingSituation`, `Benefit`, `Disability`, `HealthInsurance`, `Income` had no label; `CEEvent` was labeled "Current Living Situation"; most relationship properties had no label | every class and relationship property has an English label; `CEEvent` and `CurrentLivingSituation` corrected | Needed for documentation tools such as WebVOWL and LODE. |
| Duplicate concept schemes | `list_TargetPopulation` and `list_HOPWAMedAssistedLivingFac` declared twice | declared once | |
| API test scenarios | `hmisDataExchange_ontology` = a full copy of the core plus `de:` scenario classes | no longer published with the ontology | See [recommendation 4](#4-move-api-scenarios-to-openapi-and-json-ld). |

Validation: the generator reproduced v1.3.0-beta byte for byte before these changes. The v1.4.0-beta file parses cleanly with rdflib (6,547 triples, 24 classes, 257 object properties, 106 datatype properties, 668 concepts). Every `hmis:` term it uses is declared, no property has more than one `rdfs:domain`, and every `owl:inverseOf` is declared in both directions.

### Compatibility

The Shiny app (`global.R`) and `Translation Layer/scripts/build_ontology_cache.R` still read the v1.3.0-beta files, so they keep working unchanged. To move them to v1.4.0-beta:

- update the `PREFIX hmis:` and `PREFIX de:` lines in `SPARQL_functions.R` to `urn:hud:hmis#` and `urn:hud:hmis:de#`;
- load the scenarios from `Translation Layer/outputs/DataExchangeOntology_v1.4.0-beta.ttl` alongside the core file, since they are no longer in the published ontology;
- handle the six union domains, which come back from the `?domain` query as blank nodes rather than class IRIs.

## Recommended next changes

### 1. Name object properties as lowerCamelCase predicates

Data-element object properties are named like classes (`hmis:HousingAssessment`, `hmis:Sex`). Relationship properties use lowerCamelCase (`hmis:hasHousehold`). Use one convention, lowerCamelCase predicates such as `hmis:hasHousingAssessment`, and keep the Data Dictionary field name in `hmis:dataDictionaryName`.

### 2. Enforce value lists with SHACL

203 data-element properties have range `skos:Concept`. The link to their list is only an annotation (`hmis:linkedVocabulary`), so a value from any list is accepted. A SHACL file next to the ontology can enforce each one:

```turtle
hmis:ClientShape a sh:NodeShape ;
  sh:targetClass hmis:Client ;
  sh:property [
    sh:path hmis:Sex ;
    sh:class skos:Concept ;
    sh:node [ sh:property [ sh:path skos:inScheme ; sh:hasValue hmis:list_Sex ] ]
  ] .
```

Some values (`Data not collected`, `Client prefers not to answer`, `Yes`, `No`) are shared by up to 39 lists as a single concept. That is fine for SKOS, but it is another reason list membership needs to be validated rather than inferred.

### 3. Close coverage gaps against the FY2026 CSV Specifications

63 of the 368 field names in the FY2026 HMIS CSV Specifications are not in the ontology. Some may be intentional (export metadata), but these look like gaps:

- `DataCollectionStage`, `DisabilityType`, `DisabilityResponse`, `IndefiniteAndImpairs`
- `RecordType`, `TypeProvided`, `DateProvided` (Services)
- `DateCreated`, `DateUpdated`, `DateDeleted`
- record IDs such as `ExitID`, `ServicesID`, `IncomeBenefitsID`, `HealthAndDVID`
- `CustomQuestion`, `CustomAnswer` and the other custom assessment fields
- `PITCount`, `OrganizationCommonName`, `ProjectCommonName`, `SSN4F`

### 4. Move API scenarios to OpenAPI and JSON-LD

API test scenarios describe how a service behaves, not what HMIS data means. Keeping them in the ontology ties every API change to an ontology release, and modeling them as OWL classes leaves nothing a test runner can execute. The proposed structure:

| Concern | Standard | Source in this repo |
| --- | --- | --- |
| Endpoints, request and response schemas, named examples | OpenAPI 3.1 | `Artifacts/CommonScenariosJSON/FY2026` request/response pairs |
| Multi-step scenarios ("search a client, then get enrollments") | Arazzo 1.0 | `DataExchangeScenarioOntology.xlsx` |
| Link from JSON fields to ontology terms | JSON-LD `@context` (`"Sex": "urn:hud:hmis#Sex"`) | generated from the ontology |
| Payload validation against HMIS value lists | SHACL (item 2) | generated from `SkosVocabulary.xlsx` |
| Running the tests | Schemathesis or Postman/Newman in CI | none yet |

The archived `Translation Layer/~ archive/hmis-codegen` already generated an `openapi.yaml` and a `context.jsonld`, so this builds on earlier work.

When the scenarios move, these content issues in `DataExchangeScenarioOntology.xlsx` should be fixed:

- `ClientSearch` (GET) sends income elements (`Earned`, `Unemployment`, `SSDI` and others) as its search request. This looks like a copy error.
- `Earned` appears twice in the `ClientSearch` request.
- The `NewClient` request leaves out `Earned`, but its response includes it.
- `UpdateClient` (PATCH) has no `UpdateClientRequest` column, so it has no request elements. The generator now warns about this.
- Several client scenarios include CE assessment fields.

### 5. Plan for fiscal-year changes

The FY2027 HMIS Data Standards will add, rename and retire elements. Mark retired terms `owl:deprecated true` with `dct:isReplacedBy`, and record the fiscal year each term applies to (for example, with `dct:valid`). FY2027 then becomes a diff rather than a rewrite. The *FY 2026 Data Standards Mapping Instructions* spreadsheet is a natural source for these mappings.

### 6. Align with the HMIS Logic Model

The HUD HMIS Logic Model ([FY2026_HMIS_Logic_Model_RDF.owl](https://github.com/HUD-Data-Lab/HMIS-Logic-Model/blob/main/FY2026_HMIS_Logic_Model_RDF.owl)) uses `urn:hud:hmis:owl#`, models lists as `owl:oneOf` datatypes, and carries cardinality restrictions this ontology lacks. The two should converge on one namespace and one list model. This ontology's SKOS vocabularies are the better list model. The Logic Model's cardinalities should be carried over, preferably as SHACL.

### 7. Declare partOf as functional

Each part record (a Service, an Inventory record, an Income record) belongs to exactly one parent through its parent's ID in the CSV model. Declaring `hmis:partOf` an `owl:FunctionalProperty` would let a reasoner flag data that links a part to two parents. It is left out of v1.4.0-beta so that ICF can confirm no exchange scenario needs a part shared between records.

### 8. Split HousingAssessment

`HousingAssessment` names two different data elements: 2.09.A (a CE participation yes/no) and W5.1 (housing assessment at exit, with its own list). v1.4.0-beta gives the shared name a union domain and both lists as `hmis:linkedVocabulary`. Two properties with distinct names would be clearer.

