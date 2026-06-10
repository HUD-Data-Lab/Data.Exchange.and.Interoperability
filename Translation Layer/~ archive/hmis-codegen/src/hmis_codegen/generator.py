"""
Jinja2 template-based code generation

Generates JSON-LD contexts, Mockoon configs, effect handlers, etc.
from parsed YAML-LD specifications and ontologies
"""

from typing import Dict, Any
from pathlib import Path
from jinja2 import Environment, FileSystemLoader, Template
from .models import OpenAPISpec, OntologyModel, EffectHandler


class Generator:
    """Template-based code generator"""
    
    def __init__(self, templates_dir: Path):
        self.env = Environment(
            loader=FileSystemLoader(str(templates_dir)),
            trim_blocks=True,
            lstrip_blocks=True,
        )
        
        # Add custom filters
        self.env.filters['to_python_type'] = self._to_python_type
        self.env.filters['to_jsonld_term'] = self._to_jsonld_term
    
    def generate_jsonld_context(
        self, 
        spec: OpenAPISpec, 
        ontology: OntologyModel
    ) -> str:
        """Generate JSON-LD @context from YAML-LD semantic annotations"""
        template = self.env.get_template('jsonld_context.j2')
        
        # Build context mappings
        context = {
            "@vocab": ontology.namespace,
        }
        
        # Extract all semantic URIs from schemas
        for schema in spec.schemas:
            for prop in schema.properties:
                if prop.semantic.semantic_uri:
                    # Map OpenAPI field name to ontology property
                    local_name = str(prop.semantic.semantic_uri).split('#')[-1]
                    context[prop.name] = local_name
        
        return template.render(
            context=context,
            vocab_uri=ontology.namespace,
            spec=spec
        )
    
    def generate_openapi_yaml(self, spec: OpenAPISpec) -> str:
        """Generate enhanced OpenAPI YAML (with or without semantic annotations)"""
        template = self.env.get_template('openapi_yaml.j2')
        return template.render(spec=spec)
    
    def generate_mockoon_config(self, spec: OpenAPISpec) -> str:
        """Generate Mockoon environment JSON"""
        template = self.env.get_template('mockoon_config.j2')
        
        # Convert spec to Mockoon routes
        routes = []
        for operation in spec.operations:
            route = {
                'uuid': f"route-{operation.operation_id}",
                'method': operation.method.upper(),
                'endpoint': operation.path,
                'documentation': operation.description,
                'responses': self._build_mockoon_responses(operation)
            }
            routes.append(route)
        
        return template.render(
            name=f"{spec.title} Sandbox",
            routes=routes,
            spec=spec
        )
    
    def generate_effect_handlers(self, handlers: list[EffectHandler]) -> str:
        """Generate Python effect handler interfaces"""
        template = self.env.get_template('effect_handlers.j2')
        return template.render(handlers=handlers)
    
    def generate_effect_mocks(self, handlers: list[EffectHandler]) -> str:
        """Generate mock effect handlers for testing"""
        template = self.env.get_template('effect_mocks.j2')
        return template.render(handlers=handlers)
    
    def _build_mockoon_responses(self, operation) -> list:
        """Build Mockoon response configurations"""
        responses = []
        
        # Default 200 response
        responses.append({
            'uuid': f"response-{operation.operation_id}-200",
            'statusCode': 200,
            'label': 'Success',
            'body': '{"status": "success"}',  # TODO: Generate from schema
            'headers': [
                {'key': 'Content-Type', 'value': 'application/json'}
            ]
        })
        
        return responses
    
    @staticmethod
    def _to_python_type(openapi_type: str) -> str:
        """Convert OpenAPI type to Python type"""
        type_map = {
            'string': 'str',
            'integer': 'int',
            'number': 'float',
            'boolean': 'bool',
            'array': 'List',
            'object': 'Dict',
        }
        return type_map.get(openapi_type, 'Any')
    
    @staticmethod
    def _to_jsonld_term(semantic_uri: str) -> str:
        """Extract JSON-LD term from full URI"""
        return semantic_uri.split('#')[-1].split('/')[-1]

def generate_fhir_transformer(
    self,
    spec: OpenAPISpec,
    fhir_mappings: FHIRMappingsFile,
    effect_handlers: List[EffectHandler]
) -> str:
    """Generate FHIR transformer with effect handlers"""
    template = self.env.get_template('fhir_transformer.py.j2')
    
    # Prepare components with FHIR mappings
    components = []
    for schema in spec.schemas:
        if schema.name in fhir_mappings.resource_mappings:
            fhir_mapping = fhir_mappings.resource_mappings[schema.name]
            components.append({
                'name': schema.name,
                'properties': self._prepare_fhir_properties(schema, fhir_mapping),
                'fhir_mapping': fhir_mapping
            })
    
    return template.render(
        components=components,
        effect_handlers=effect_handlers,
        fhir_mappings=fhir_mappings,
        spec_version=spec.version,
        timestamp=datetime.now().isoformat()
    )

def _prepare_fhir_properties(
    self,
    schema: APISchema,
    fhir_mapping: FHIRResourceMapping
) -> List[Dict[str, Any]]:
    """Prepare property data for FHIR template"""
    properties = []
    
    for prop in schema.properties:
        if prop.name in fhir_mapping.field_mappings:
            field_mapping = fhir_mapping.field_mappings[prop.name]
            properties.append({
                'name': prop.name,
                'type': prop.type,
                'fhir_mapping': field_mapping,
                'semantic': prop.semantic
            })
    
    return properties

def generate_fhir_docs(
    self,
    spec: OpenAPISpec,
    fhir_mappings: FHIRMappingsFile
) -> str:
    """Generate FHIR integration documentation"""
    template = self.env.get_template('fhir_docs.md.j2')
    
    return template.render(
        spec_version=spec.version,
        fhir_version=fhir_mappings.fhir_version,
        hud_technical_standards=fhir_mappings.hud_technical_standards,
        resource_mappings=fhir_mappings.resource_mappings,
        effect_handlers=fhir_mappings.effect_handlers,
        transformations=fhir_mappings.transformations,
        timestamp=datetime.now().isoformat(),
        version="0.1.0"
    )
