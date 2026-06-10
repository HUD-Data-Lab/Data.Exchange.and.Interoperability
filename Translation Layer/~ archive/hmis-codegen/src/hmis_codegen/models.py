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
    params: List[str]
    return_type: str
    
    def __str__(self) -> str:
        return f"{', '.join(self.params)} → {self.return_type}"


class Effect(BaseModel):
    """Represents an algebraic effect annotation"""
    name: str = Field(description="Effect name (e.g., ConsentCheck)")
    handler: str = Field(description="Handler module URI")
    description: str = Field(description="Human-readable effect description")
    signature: str = Field(description="Effect type signature")
    resumable: bool = Field(default=True, description="Can computation resume after effect?")
    
    required_by: Optional[str] = Field(None, description="Policy requirement")
    provenance: Optional[HttpUrl] = Field(None, description="PROV-O URI")
    provenance_type: Optional[str] = Field(None, description="PROV-O type (e.g., prov:Create)")
    transaction: Optional[bool] = Field(None, description="Requires transaction semantics")
    
    def parse_signature(self) -> EffectSignature:
        """Parse string signature into structured form"""
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
            f"{p.split(':')[0].strip()}: Any"
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
    
    semantic: SemanticAnnotation = Field(default_factory=SemanticAnnotation)
    fhir_mapping: Optional[FHIRFieldMapping] = Field(None, alias="x-fhir-mapping")  # ADD THIS
    
    hud_reference: Optional[Dict[str, str]] = Field(None, alias="x-hud-reference")
    conditional: Optional[str] = Field(None, alias="x-conditional")
    business_rule: Optional[str] = Field(None, alias="x-business-rule")

    class Config:
        populate_by_name = True


class APISchema(BaseModel):
    """OpenAPI schema component with semantic annotations"""
    name: str
    type: Literal["object", "array", "string", "integer", "number", "boolean"]
    description: Optional[str] = None
    properties: List[SchemaProperty] = Field(default_factory=list)
    
    semantic: SemanticAnnotation = Field(default_factory=SemanticAnnotation)
    hud_csv_table: Optional[str] = Field(None, alias="x-hud-csv-table")
    fhir_mapping: Optional[FHIRMapping] = Field(None, alias="x-fhir-mapping")  # ADD THIS

    class Config:
        populate_by_name = True


# ============= Operation Models =============

class OperationMetadata(BaseModel):
    """Metadata for API operations"""
    workflow_step: Optional[str] = Field(None, alias="x-workflow-step")
    required_by_policy: List[str] = Field(default_factory=list, alias="x-required-by-policy")
    data_governance: Optional[Dict[str, str]] = Field(None, alias="x-data-governance")
    use_cases: List[str] = Field(default_factory=list, alias="x-use-cases")

    class Config:
        populate_by_name = True


class APIOperation(BaseModel):
    """OpenAPI operation (GET, POST, etc.)"""
    operation_id: str
    method: Literal["get", "post", "put", "patch", "delete"]
    path: str
    summary: str
    description: str
    
    effects: List[Effect] = Field(default_factory=list)
    metadata: OperationMetadata = Field(default_factory=OperationMetadata)
    
    request_schema: Optional[str] = None
    response_schemas: Dict[str, str] = Field(default_factory=dict)
    parameters: List[Dict[str, Any]] = Field(default_factory=list)


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
    
    jsonld_context_url: HttpUrl = Field(alias="x-jsonld-context")
    regulations: List[RegulationReference] = Field(alias="x-HMIS-Regulation")
    
    servers: List[ServerConfig]
    schemas: List[APISchema]
    operations: List[APIOperation]
    
    effect_system: Optional[Dict[str, Any]] = Field(None, alias="x-effect-system")
    
    class Config:
        populate_by_name = True


# ============= Ontology Models =============

class OWLClass(BaseModel):
    """OWL class from ontology"""
    uri: str
    label: str
    description: Optional[str] = None
    properties: List[str] = Field(default_factory=list)


class OWLProperty(BaseModel):
    """OWL property from ontology"""
    uri: str
    label: str
    domain: Optional[str] = None
    range: Optional[str] = None
    cardinality: Optional[str] = None


class OntologyModel(BaseModel):
    """Parsed ontology representation"""
    classes: List[OWLClass]
    properties: List[OWLProperty]
    namespace: str

# ============= FHIR Mapping Models =============

class FHIRMapping(BaseModel):
    """FHIR resource mapping metadata"""
    fhir_resource: str = Field(..., description="FHIR resource type (e.g., Patient)")
    fhir_profile: Optional[HttpUrl] = Field(None, description="FHIR profile URL")
    ontology_class: Optional[HttpUrl] = Field(None, description="Ontology class URI")
    hud_data_element: Optional[str] = Field(None, description="HUD data element reference")
    
    class Config:
        populate_by_name = True


class FHIRFieldMapping(BaseModel):
    """FHIR field-level mapping with privacy controls"""
    fhir_path: str = Field(..., description="FHIR path (e.g., Patient.name[0].given[0])")
    fhir_type: Optional[str] = Field(None, description="FHIR data type")
    fhir_system: Optional[HttpUrl] = Field(None, description="FHIR identifier system")
    fhir_url: Optional[HttpUrl] = Field(None, description="FHIR extension URL")
    ontology_property: Optional[HttpUrl] = Field(None, description="Ontology property URI")
    transform: str = Field(default="direct", description="Transformation type")
    hud_data_element: Optional[str] = Field(None, description="HUD data element")
    technical_standard: Optional[str] = Field(None, description="HUD Technical Standard reference")
    
    # Privacy controls (HUD 2004 Technical Standards)
    collection_consent: Optional[str] = Field(None, description="Consent type: inferred|explicit")
    retention_period: Optional[str] = Field(None, description="Data retention period")
    disclosure_restriction: Optional[str] = Field(None, description="Disclosure restrictions")
    encryption_required: Optional[bool] = Field(None, description="Encryption required")
    audit_trail_required: Optional[bool] = Field(None, description="Audit trail required")
    
    class Config:
        populate_by_name = True


class FHIRResourceMapping(BaseModel):
    """Complete FHIR resource mapping"""
    hmis_resource: str
    fhir_resource: str
    fhir_profile: Optional[HttpUrl] = None
    ontology_class: Optional[HttpUrl] = None
    field_mappings: Dict[str, FHIRFieldMapping]
    
    # Semantic extensions
    semantic_extensions: List[Dict[str, str]] = Field(default_factory=list)
    
    # Effect handlers for this resource
    effect_handlers: List[str] = Field(default_factory=list)


class FHIRMappingsFile(BaseModel):
    """Complete FHIR mappings file structure"""
    version: str
    hmis_spec_version: str
    fhir_version: str
    hud_technical_standards: str
    
    resource_mappings: Dict[str, FHIRResourceMapping]
    privacy_security_mappings: Dict[str, Any]
    effect_handlers: Dict[str, Any]
    transformations: Dict[str, Any]
    medicaid_scenarios: Optional[Dict[str, Any]] = None