"""
HMIS Code Generation Toolchain

Parses YAML-LD API specifications and JSON-LD ontologies to generate:
- JSON-LD contexts
- OpenAPI specifications
- Mockoon configurations
- Effect handler interfaces
- Test harnesses
"""

__version__ = "0.1.0"

from .parser import OntologyParser, YAMLLDParser
from .models import OpenAPISpec, APISchema, Effect, EffectHandler
from .generator import Generator
from .effects import EffectSystem

__all__ = [
    "OntologyParser",
    "YAMLLDParser",
    "OpenAPISpec",
    "APISchema",
    "Effect",
    "EffectHandler",
    "Generator",
    "EffectSystem",
]

# ==============================================================================
# File: src/hmis_codegen/models.py
# ==============================================================================
"""
Pydantic models for type-safe intermediate representation

These models represent the parsed YAML-LD specification and ontology,
providing validation and type safety throughout the toolchain.
"""

from typing import List, Optional, Dict, Any, Literal
from pydantic import BaseModel, Field, HttpUrl


# ============= Effect System Models =============

class EffectSignature(BaseModel):
    """Type signature for an effect operation"""
    params: List[str]  # e.g., ["clientID: ID", "purpose: Purpose"]
    return_type: str   # e.g., "ConsentStatus"
    
    def __str__(self) -> str:
        return f"{', '.join(self.params)} → {self.return_type}"


class Effect(BaseModel):
    """Represents an algebraic effect annotation"""
    name: str = Field(description="Effect name (e.g., ConsentCheck)")
    handler: str = Field(description="Handler module URI")
    description: str = Field(description="Human-readable effect description")
    signature: str = Field(description="Effect type signature")
    resumable: bool = Field(default=True, description="Can computation resume after effect?")
    
    # Optional metadata
    required_by: Optional[str] = Field(None, description="Policy requirement")
    provenance: Optional[HttpUrl] = Field(None, description="PROV-O URI")
    provenance_type: Optional[str] = Field(None, description="PROV-O type (e.g., prov:Create)")
    transaction: Optional[bool] = Field(None, description="Requires transaction semantics")
    
    def parse_signature(self) -> EffectSignature:
        """Parse string signature into structured form"""
        # Simple parser: "param1: Type1, param2: Type2 → ReturnType"
        if "→" in self.signature:
            params_str, return_type = self.signature.split("→")
            params = [p.strip() for p in params_str.split(",")]
            return EffectSignature(params=params, return_type=return_type.strip())
        return EffectSignature(params=[], return_type="Unit")


class EffectHandler(BaseModel):
    """Generated effect handler interface"""
    name: str
    effect_type: str
    signature: EffectSignature
    docstring: str
    
    def to_python_protocol(self) -> str:
        """Generate Python Protocol class"""
        params = ", ".join([
            f"{p.split(':')[0].strip()}: Any"  # Simplified type
            for p in self.signature.params
        ])
        
        return f"""
class {self.name}Handler(Protocol):
    '''
    {self.docstring}
    
    Signature: {self.signature}
    '''
    def handle(self, {params}) -> Any:
        ...
"""


# ============= Schema Models =============

class SemanticAnnotation(BaseModel):
    """Semantic web annotations for OpenAPI elements"""
    jsonld_type: Optional[str] = Field(None, alias="x-jsonld-type")
    semantic_uri: Optional[HttpUrl] = Field(None, alias="x-semantic-uri")
    hud_data_element: Optional[str] = Field(None, alias="x-hud-data-element")
    ontology_cardinality: Optional[str] = Field(None, alias="x-ontology-cardinality")
    pii: Optional[bool] = Field(None, alias="x-pii")
    
    class Config:
        populate_by_name = True


class SchemaProperty(BaseModel):
    """OpenAPI schema property with semantic annotations"""
    name: str
    type: str
    format: Optional[str] = None
    description: Optional[str] = None
    max_length: Optional[int] = None
    pattern: Optional[str] = None
    
    # Semantic annotations
    semantic: SemanticAnnotation = Field(default_factory=SemanticAnnotation)
    
    # HUD-specific metadata
    hud_reference: Optional[Dict[str, str]] = Field(None, alias="x-hud-reference")
    conditional: Optional[str] = Field(None, alias="x-conditional")
    business_rule: Optional[str] = Field(None, alias="x-business-rule")


class APISchema(BaseModel):
    """OpenAPI schema component with semantic annotations"""
    name: str
    type: Literal["object", "array", "string", "integer", "number", "boolean"]
    description: Optional[str] = None
    properties: List[SchemaProperty] = Field(default_factory=list)
    
    # Semantic annotations
    semantic: SemanticAnnotation = Field(default_factory=SemanticAnnotation)
    hud_csv_table: Optional[str] = Field(None, alias="x-hud-csv-table")


# ============= Operation Models =============

class OperationMetadata(BaseModel):
    """Metadata for API operations"""
    workflow_step: Optional[str] = Field(None, alias="x-workflow-step")
    required_by_policy: List[str] = Field(default_factory=list, alias="x-required-by-policy")
    data_governance: Optional[Dict[str, str]] = Field(None, alias="x-data-governance")
    use_cases: List[str] = Field(default_factory=list, alias="x-use-cases")


class APIOperation(BaseModel):
    """OpenAPI operation (GET, POST, etc.)"""
    operation_id: str
    method: Literal["get", "post", "put", "patch", "delete"]
    path: str
    summary: str
    description: str
    
    # Effect annotations (experimental)
    effects: List[Effect] = Field(default_factory=list)
    
    # Semantic metadata
    metadata: OperationMetadata = Field(default_factory=OperationMetadata)
    
    # Request/response schemas
    request_schema: Optional[str] = None
    response_schemas: Dict[str, str] = Field(default_factory=dict)  # status code -> schema name


# ============= Top-level Spec Models =============

class ServerConfig(BaseModel):
    """OpenAPI server configuration"""
    url: str
    description: str


class RegulationReference(BaseModel):
    """HUD regulation reference"""
    name: str
    url: HttpUrl
    regulation: str


class OpenAPISpec(BaseModel):
    """Complete OpenAPI specification with YAML-LD extensions"""
    title: str
    version: str
    description: str
    
    # Semantic web integration
    jsonld_context_url: HttpUrl = Field(alias="x-jsonld-context")
    regulations: List[RegulationReference] = Field(alias="x-HMIS-Regulation")
    
    # Server configuration
    servers: List[ServerConfig]
    
    # Components
    schemas: List[APISchema]
    
    # Operations
    operations: List[APIOperation]
    
    # Effect system (experimental)
    effect_system: Optional[Dict[str, Any]] = Field(None, alias="x-effect-system")


# ============= Ontology Models =============

class OWLClass(BaseModel):
    """OWL class from ontology"""
    uri: HttpUrl
    label: str
    description: Optional[str] = None
    properties: List[str] = Field(default_factory=list)


class OWLProperty(BaseModel):
    """OWL property from ontology"""
    uri: HttpUrl
    label: str
    domain: Optional[HttpUrl] = None
    range: Optional[HttpUrl] = None
    cardinality: Optional[str] = None


class OntologyModel(BaseModel):
    """Parsed ontology representation"""
    classes: List[OWLClass]
    properties: List[OWLProperty]
    namespace: str