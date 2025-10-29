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
                    local_name = prop.semantic.semantic_uri.split('#')[-1]
                    context[prop.name] = local_name
        
        return template.render(
            context=context,
            vocab_uri=ontology.namespace,
            spec=spec
        )
    
    def generate_openapi_yaml(self, spec: OpenAPISpec) -> str:
        """Generate enhanced OpenAPI YAML (with or without semantic annotations)"""
        template = self.env.get_template('openapi.yaml.j2')
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
        template = self.env.get_template('effect_handlers.py.j2')
        return template.render(handlers=handlers)
    
    def generate_effect_mocks(self, handlers: list[EffectHandler]) -> str:
        """Generate mock effect handlers for testing"""
        template = self.env.get_template('effect_mocks.py.j2')
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