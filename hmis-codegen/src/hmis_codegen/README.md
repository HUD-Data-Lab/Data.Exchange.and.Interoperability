"""
# hmis-codegen

Python toolchain for generating API artifacts from YAML-LD specifications and JSON-LD ontologies.

## Features

- **Ontology Parsing**: Extract classes and properties from JSON-LD ontology exports
- **YAML-LD Parsing**: Parse OpenAPI specs with semantic web extensions
- **Effect System**: Experimental algebraic effect handler annotations (Phase 1)
- **Code Generation**: Generate JSON-LD contexts, Mockoon configs, effect handlers
- **Validation**: Ensure semantic URIs reference valid ontology terms

## Installation

```bash
pip install -e .
```

For development:
```bash
pip install -e ".[dev]"
```

## Usage

### Generate all outputs from specification

```bash
hmis-codegen generate \
  --ontology ontology.jsonld \
  --spec hmis_api_ld_0.4.yaml \
  --output-dir ./generated
```

### Generate specific output type

```bash
# JSON-LD context only
hmis-codegen generate -o ontology.jsonld -s api.yaml -f context

# Effect handlers only
hmis-codegen generate -o ontology.jsonld -s api.yaml -f handlers

# Mockoon configuration only
hmis-codegen generate -o ontology.jsonld -s api.yaml -f mockoon
```

### Validate specification

```bash
hmis-codegen validate \
  --ontology ontology.jsonld \
  --spec hmis_api_ld_0.4.yaml
```

### Extract semantic mappings

```bash
# JSON format
hmis-codegen extract --spec api.yaml --output mappings.json

# YAML format
hmis-codegen extract --spec api.yaml --output mappings.yaml --format yaml

# CSV format (properties only)
hmis-codegen extract --spec api.yaml --output mappings.csv --format csv
```

### Show specification info

```bash
hmis-codegen info --spec hmis_api_ld_0.4.yaml
```

## Architecture

```
JSON-LD Ontology → OntologyParser → OntologyModel
                                         ↓
YAML-LD Spec → YAMLLDParser → OpenAPISpec
                                         ↓
                                    Generator → Outputs
                                         ↓
                      ├─ JSON-LD Context (context.jsonld)
                      ├─ OpenAPI YAML (openapi.yaml)
                      ├─ Mockoon Config (mockoon-env.json)
                      ├─ Effect Handlers (effect_handlers.py)
                      └─ Mock Handlers (effect_mocks.py)
```

## Effect System (Experimental)

The toolchain supports algebraic effect handler annotations for documenting
computational side effects:

```yaml
/client:
  post:
    x-effects:
      - effect: ConsentCheck
        handler: hmis:validateConsent
        signature: "clientID: ID, purpose: Purpose → ConsentStatus"
        resumable: true
```

Generated handler interface:

```python
class ConsentCheckHandler(Protocol):
    def handle(self, client_id: str, purpose: str) -> ConsentStatus:
        ...
```

## Contributing

1. Install development dependencies: `pip install -e ".[dev]"`
2. Run tests: `pytest`
3. Format code: `black src/`
4. Type check: `mypy src/`
5. Lint: `ruff src/`

## License

MIT
"""