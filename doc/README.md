# hmis-codegen

Python toolchain for generating API artifacts from YAML-LD specifications and JSON-LD ontologies, with FHIR R4 interoperability.

## Features

- **Ontology Parsing**: Extract classes and properties from JSON-LD ontology exports
- **YAML-LD Parsing**: Parse OpenAPI specs with semantic web extensions
- **FHIR Integration**: Bidirectional HMIS ↔ FHIR R4 transformation with HUD Technical Standards compliance
- **Effect System**: Algebraic effect handler annotations with privacy/security validation
- **Code Generation**: Generate JSON-LD contexts, Mockoon configs, FHIR transformers, effect handlers
- **Validation**: Ensure semantic URIs reference valid ontology terms

## Installation
```bash
pip install -e .
```

For development:
```bash
pip install -e ".[dev]"
```

## Quick Start

### Basic API Generation
```bash
# Generate all outputs from specification
hmis-codegen generate \
  --ontology ontology.jsonld \
  --spec hmis_api_ld_0.5.yaml \
  --output-dir ./generated
```

### FHIR Integration
```bash
# Generate FHIR integration files
hmis-codegen generate-fhir \
  --spec hmis_api_ld_0.5.yaml \
  --fhir-mappings fhir-mappings.yaml \
  --output-dir ./generated/fhir

# Or include FHIR in main generation
hmis-codegen generate \
  --ontology ontology.jsonld \
  --spec hmis_api_ld_0.5.yaml \
  --fhir-mappings fhir-mappings.yaml \
  --output-dir ./generated
```

## Usage

### Generate Specific Output Types
```bash
# JSON-LD context only
hmis-codegen generate -o ontology.jsonld -s api.yaml -f context

# Effect handlers only
hmis-codegen generate -o ontology.jsonld -s api.yaml -f handlers

# Mockoon configuration only
hmis-codegen generate -o ontology.jsonld -s api.yaml -f mockoon

# FHIR integration only
hmis-codegen generate -o ontology.jsonld -s api.yaml -f fhir --fhir-mappings fhir-mappings.yaml
```

### Validate Specification
```bash
hmis-codegen validate \
  --ontology ontology.jsonld \
  --spec hmis_api_ld_0.5.yaml
```

### Extract Semantic Mappings
```bash
# JSON format
hmis-codegen extract --spec api.yaml --output mappings.json

# YAML format
hmis-codegen extract --spec api.yaml --output mappings.yaml --format yaml

# CSV format (properties only)
hmis-codegen extract --spec api.yaml --output mappings.csv --format csv
```

### Show Specification Info
```bash
hmis-codegen info --spec hmis_api_ld_0.5.yaml
```

## Architecture
```
JSON-LD Ontology → OntologyParser → OntologyModel
                                         ↓
YAML-LD Spec → YAMLLDParser → OpenAPISpec
                                         ↓
FHIR Mappings → FHIRMappingsParser → FHIRMappingsFile
                                         ↓
                                    Generator → Outputs
                                         ↓
                      ├─ JSON-LD Context (context.jsonld)
                      ├─ OpenAPI YAML (openapi.yaml)
                      ├─ Mockoon Config (mockoon-env.json)
                      ├─ Effect Handlers (effect_handlers.py)
                      ├─ Mock Handlers (effect_mocks.py)
                      └─ FHIR Integration
                          ├─ FHIR Transformer (fhir_transformer.py)
                          ├─ FHIR Bundle Template (fhir_bundle_template.json)
                          └─ FHIR Documentation (FHIR_INTEGRATION.md)
```

## FHIR Integration

The toolchain generates bidirectional HMIS ↔ FHIR R4 transformers with built-in HUD Technical Standards compliance.

### FHIR Mappings File

Create a `fhir-mappings.yaml` file defining resource mappings:
```yaml
version: "1.0"
fhir_version: "4.0.1"
hud_technical_standards: "2004"

resource_mappings:
  Client:
    fhir_resource: Patient
    fhir_profile: http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient
    ontology_class: http://hmis.hud.gov/ontology#Client
    
    field_mappings:
      PersonalID:
        fhir_path: Patient.identifier.where(system='http://hmis.hud.gov/identifiers/PersonalID')
        fhir_system: http://hmis.hud.gov/identifiers/PersonalID
        transform: identifier
        hud_data_element: "3.20"
      
      FirstName:
        fhir_path: Patient.name[0].given[0]
        transform: direct
        hud_data_element: "3.01"
      
      # ... more field mappings

effect_handlers:
  validate_collection_consent:
    description: "Validates consent exists before collecting PPI"
    hud_standard: "4.2.1"
    fhir_resources: [Patient, Consent]
  
  validate_roi_active:
    description: "Validates ROI is active before data sharing"
    hud_standard: "4.2.3"
    fhir_resources: [Consent]
```

### Generated FHIR Transformer Usage
```python
from generated.fhir.fhir_transformer import FHIRTransformer

# Initialize transformer with validation enabled
transformer = FHIRTransformer(enable_validation=True)

# HMIS → FHIR transformation
hmis_client = {
    "PersonalID": "12345",
    "FirstName": "Jane",
    "LastName": "Doe",
    "DOB": "1990-01-15",
    "VeteranStatus": 1
}

# Validate consent before transformation (HUD 4.2.1)
transformer.validate_collection_consent(
    patient_id="12345",
    consent_id="consent-001"
)

# Transform to FHIR Patient
fhir_patient = transformer.hmis_to_fhir(hmis_client, "Client")

# FHIR → HMIS transformation
hmis_data = transformer.fhir_to_hmis(fhir_patient)
```

### Effect Handlers for HUD Technical Standards

The FHIR transformer includes built-in effect handlers for HUD 2004 Technical Standards compliance:
```python
# HUD 4.2.1 - Collection Limitation
transformer.validate_collection_consent(
    patient_id="12345",
    consent_id="consent-001"
)
# Raises ConsentError if consent missing or invalid

# HUD 4.2.3 - Purpose Specification and Use Limitation
transformer.validate_purpose_disclosure(
    consent_id="consent-001",
    requested_purpose="TREAT",  # TREAT, HPAYMT, HOPERAT, HRESCH
    requested_fields=["FirstName", "LastName", "DOB"]
)
# Raises ValidationError if purpose not authorized or exceeds minimum necessary

# HUD 4.2.3 - Release of Information (ROI)
transformer.validate_roi_active(
    patient_id="12345",
    recipient_org="medicaid-agency",
    request_date=datetime.now()
)
# Raises ROIError if ROI missing, expired, or recipient not authorized

# HUD 4.2.5 - Individual Access Rights
transformer.validate_access_rights(
    patient_id="12345",
    requester_id="12345",  # Same patient = authorized
    requested_resources=["Patient", "EpisodeOfCare"]
)
# Raises ValidationError if requester not authorized

# HUD 4.2.3, 5.2.1 - Data Retention (7-year rule)
result = transformer.validate_retention_compliance(
    resource_id="enrollment-456",
    resource_type="EpisodeOfCare",
    last_service_date=datetime(2018, 1, 15)
)
# Returns: {'compliant': False, 'action_required': 'DESTROY', ...}
```

### Medicaid Billing Example
```python
# Generate Medicaid eligibility bundle
from generated.fhir.fhir_transformer import FHIRTransformer

transformer = FHIRTransformer()

# Validate ROI for Medicaid disclosure
transformer.validate_roi_active(
    patient_id="12345",
    recipient_org="state-medicaid",
    request_date=datetime.now()
)

# Transform client data
fhir_patient = transformer.hmis_to_fhir(hmis_client, "Client")
fhir_episode = transformer.hmis_to_fhir(hmis_enrollment, "Enrollment")

# Create transaction bundle
bundle = {
    "resourceType": "Bundle",
    "type": "transaction",
    "entry": [
        {
            "resource": fhir_patient,
            "request": {"method": "POST", "url": "Patient"}
        },
        {
            "resource": fhir_episode,
            "request": {"method": "POST", "url": "EpisodeOfCare"}
        }
    ]
}

# Submit to Medicaid FHIR API
response = requests.post(
    "https://medicaid.state.gov/fhir",
    json=bundle,
    headers={"Authorization": f"Bearer {token}"}
)
```

### FHIR Resource Mappings

| HMIS Resource | FHIR Resource | Notes |
|---------------|---------------|-------|
| Client | Patient | US Core Patient profile |
| Organization | Organization | Provider organization |
| Project | HealthcareService | Service offered by organization |
| Enrollment | EpisodeOfCare | Episode of homeless services |
| Exit | EpisodeOfCare | Updates period.end |

### HUD Technical Standards Mapping

| HUD Standard | FHIR Resource | Effect Handler |
|--------------|---------------|----------------|
| 4.2.1 Collection Limitation | Consent | `validate_collection_consent` |
| 4.2.3 Purpose Specification | Consent.provision | `validate_purpose_disclosure` |
| 4.2.3 Use Limitation (ROI) | Consent | `validate_roi_active` |
| 4.2.5 Access and Correction | AuditEvent | `validate_access_rights` |
| 4.2.3, 5.2.1 Data Retention | Provenance | `validate_retention_compliance` |

## Effect System

The toolchain supports algebraic effect handler annotations for documenting computational side effects and compliance requirements:

### Regular Effect Annotations
```yaml
/client:
  post:
    x-effects:
      - effect: ConsentCheck
        handler: hmis:validateConsent
        signature: "clientID: ID, purpose: Purpose → ConsentStatus"
        resumable: true
        required-by: "HUD 2004 Technical Standards 4.2.1"
```

Generated handler interface:
```python
class ConsentCheckHandler(Protocol):
    """
    Validates consent before client data collection
    
    Required by: HUD 2004 Technical Standards 4.2.1
    Signature: clientID: ID, purpose: Purpose → ConsentStatus
    """
    def handle(self, client_id: str, purpose: str) -> ConsentStatus:
        ...
```

### FHIR Effect Handlers

FHIR effect handlers are automatically loaded from `fhir-mappings.yaml`:
```yaml
effect_handlers:
  validate_collection_consent:
    description: "Validates consent exists before collecting PPI"
    hud_standard: "4.2.1"
    fhir_resources: [Patient, Consent]
    validation_rules:
      - rule: "Consent must exist (inferred or explicit)"
        check: "Consent.status == 'active'"
```

These are integrated into the same effect system and generate compatible handler interfaces.

## Output Files

### Standard Outputs

- **`context.jsonld`**: JSON-LD @context mapping OpenAPI field names to ontology properties
- **`openapi.yaml`**: Enhanced OpenAPI specification (with or without semantic annotations)
- **`mockoon-env.json`**: Mockoon server configuration for API sandbox testing
- **`effect_handlers.py`**: Python Protocol interfaces for effect handlers
- **`effect_mocks.py`**: Mock effect handlers for unit testing

### FHIR Outputs (with `--fhir-mappings`)

- **`fhir_transformer.py`**: Bidirectional HMIS ↔ FHIR transformer with effect handlers
- **`fhir_bundle_template.json`**: FHIR transaction bundle template
- **`FHIR_INTEGRATION.md`**: Documentation for FHIR integration

## Project Structure
```
hmis-codegen/
├── src/
│   └── hmis_codegen/
│       ├── __init__.py
│       ├── cli.py              # Command-line interface
│       ├── parser.py            # Ontology and YAML-LD parsers
│       ├── models.py            # Pydantic models
│       ├── generator.py         # Jinja2 template generator
│       ├── effects.py           # Effect system
│       └── utils.py             # Utility functions
├── templates/
│   ├── jsonld_context.j2
│   ├── openapi.yaml.j2
│   ├── mockoon_config.j2
│   ├── effect_handlers.j2
│   ├── effect_mocks.j2
│   ├── fhir_transformer.py.j2   # FHIR transformer template
│   ├── fhir_bundle.json.j2      # FHIR bundle template
│   └── fhir_docs.md.j2          # FHIR documentation template
├── generated/                    # Output directory
│   ├── context.jsonld
│   ├── openapi.yaml
│   ├── effect_handlers.py
│   └── fhir/
│       ├── fhir_transformer.py
│       ├── fhir_bundle_template.json
│       └── FHIR_INTEGRATION.md
├── fhir-mappings.yaml           # FHIR resource mappings (input)
├── pyproject.toml
└── README.md
```

## Development

### Running Tests
```bash
pytest
```

### Testing FHIR Integration
```bash
# Generate FHIR files
hmis-codegen generate-fhir \
  --spec hmis_api_ld_0.5.yaml \
  --fhir-mappings fhir-mappings.yaml \
  --output-dir test_output

# Test the transformer
python -c "
from test_output.fhir.fhir_transformer import FHIRTransformer
transformer = FHIRTransformer()
print('FHIR transformer loaded successfully')
"
```

### Code Quality
```bash
# Format code
black src/

# Type check
mypy src/

# Lint
ruff src/
```

## Contributing

1. Install development dependencies: `pip install -e ".[dev]"`
2. Run tests: `pytest`
3. Format code: `black src/`
4. Type check: `mypy src/`
5. Lint: `ruff src/`

## License

MIT

## References

- **HUD FY2026 HMIS Data Standards Manual**: [HUD Exchange](https://www.hudexchange.info/programs/hmis/hmis-data-and-technical-standards/)
- **HUD 2004 HMIS Technical Standards**: [Federal Register](https://www.govinfo.gov/content/pkg/FR-2004-07-30/pdf/04-17097.pdf)
- **FHIR R4 Specification**: [HL7 FHIR](https://hl7.org/fhir/R4/)
- **US Core Implementation Guide**: [HL7 US Core](https://www.hl7.org/fhir/us/core/)
- **SMART on FHIR**: [SMART Health IT](https://smarthealthit.org/)
