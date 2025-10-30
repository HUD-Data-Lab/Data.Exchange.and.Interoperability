"""
Parsers for YAML-LD specifications and JSON-LD ontologies

OntologyParser: Extracts classes and properties from JSON-LD ontology
YAMLLDParser: Parses YAML-LD API specifications with semantic annotations
"""

from typing import Dict, List, Any
from pathlib import Path
import yaml
from rdflib import Graph, Namespace, RDF, RDFS, OWL
from .models import (
    OntologyModel, OWLClass, OWLProperty,
    OpenAPISpec, APISchema, APIOperation, Effect,
    SchemaProperty, SemanticAnnotation
)


class OntologyParser:
    """Parse JSON-LD ontology exports to extract semantic structure"""
    
    def __init__(self, ontology_path: Path):
        self.graph = Graph()
        self.graph.parse(str(ontology_path), format="json-ld")
        
        # Define common namespaces
        self.HMIS = Namespace("http://hmis.hud.gov/ontology#")
        self.graph.bind("hmis", self.HMIS)
    
    def extract_classes(self) -> List[OWLClass]:
        """Extract all OWL classes from ontology"""
        classes = []
        
        for cls in self.graph.subjects(RDF.type, OWL.Class):
            label = self._get_label(cls)
            description = self._get_description(cls)
            properties = self._get_class_properties(cls)
            
            classes.append(OWLClass(
                uri=str(cls),
                label=label,
                description=description,
                properties=[str(p) for p in properties]
            ))
        
        return classes
    
    def extract_properties(self) -> List[OWLProperty]:
        """Extract all OWL properties from ontology"""
        properties = []
        
        for prop in self.graph.subjects(RDF.type, OWL.ObjectProperty):
            properties.append(self._parse_property(prop))
        
        for prop in self.graph.subjects(RDF.type, OWL.DatatypeProperty):
            properties.append(self._parse_property(prop))
        
        return properties
    
    def _parse_property(self, prop) -> OWLProperty:
        """Parse a single property"""
        label = self._get_label(prop)
        domain = next(self.graph.objects(prop, RDFS.domain), None)
        range_obj = next(self.graph.objects(prop, RDFS.range), None)
        
        return OWLProperty(
            uri=str(prop),
            label=label,
            domain=str(domain) if domain else None,
            range=str(range_obj) if range_obj else None
        )
    
    def _get_label(self, subject) -> str:
        """Get rdfs:label or use local name"""
        label = next(self.graph.objects(subject, RDFS.label), None)
        if label:
            return str(label)
        # Fallback to local name
        return str(subject).split("#")[-1].split("/")[-1]
    
    def _get_description(self, subject) -> str:
        """Get rdfs:comment"""
        comment = next(self.graph.objects(subject, RDFS.comment), None)
        return str(comment) if comment else None
    
    def _get_class_properties(self, cls) -> List:
        """Get all properties with this class as domain"""
        return list(self.graph.subjects(RDFS.domain, cls))
    
    def to_model(self) -> OntologyModel:
        """Convert to Pydantic model"""
        return OntologyModel(
            classes=self.extract_classes(),
            properties=self.extract_properties(),
            namespace=str(self.HMIS)
        )


class YAMLLDParser:
    """Parse YAML-LD API specifications"""
    
    def __init__(self, yaml_path: Path):
        with open(yaml_path, 'r') as f:
            self.data = yaml.safe_load(f)
    
    def parse(self) -> OpenAPISpec:
        """Parse YAML-LD into structured OpenAPISpec"""
        info = self.data['info']
        
        spec = OpenAPISpec(
            title=info['title'],
            version=info['version'],
            description=info['description'],
            jsonld_context_url=info['x-jsonld-context'],
            regulations=info['x-HMIS-Regulation'],
            servers=self._parse_servers(),
            schemas=self._parse_schemas(),
            operations=self._parse_operations(),
            effect_system=self.data.get('x-effect-system')
        )
        
        return spec
    
    def _parse_servers(self) -> List[Dict]:
        """Parse server configurations"""
        return self.data.get('servers', [])
    
    def _parse_schemas(self) -> List[APISchema]:
        """Parse component schemas"""
        schemas = []
        components = self.data.get('components', {}).get('schemas', {})
        
        for name, schema_def in components.items():
            properties = []
            
            for prop_name, prop_def in schema_def.get('properties', {}).items():
                properties.append(SchemaProperty(
                    name=prop_name,
                    type=prop_def.get('type', 'string'),
                    format=prop_def.get('format'),
                    description=prop_def.get('description'),
                    max_length=prop_def.get('maxLength'),
                    pattern=prop_def.get('pattern'),
                    semantic=SemanticAnnotation(
                        jsonld_type=prop_def.get('x-jsonld-type'),
                        semantic_uri=prop_def.get('x-semantic-uri'),
                        hud_data_element=prop_def.get('x-hud-data-element'),
                        pii=prop_def.get('x-pii')
                    )
                ))
            
            schemas.append(APISchema(
                name=name,
                type=schema_def.get('type', 'object'),
                description=schema_def.get('description'),
                properties=properties,
                semantic=SemanticAnnotation(
                    jsonld_type=schema_def.get('x-jsonld-type'),
                    semantic_uri=schema_def.get('x-semantic-uri')
                ),
                hud_csv_table=schema_def.get('x-hud-csv-table')
            ))
        
        return schemas
    
    def _parse_operations(self) -> List[APIOperation]:
        """Parse API operations from paths"""
        operations = []
        paths = self.data.get('paths', {})
        
        for path, methods in paths.items():
            for method, operation_def in methods.items():
                if method in ['get', 'post', 'put', 'patch', 'delete']:
                    effects = self._parse_effects(operation_def.get('x-effects', []))
                    
                    operations.append(APIOperation(
                        operation_id=operation_def['operationId'],
                        method=method,
                        path=path,
                        summary=operation_def['summary'],
                        description=operation_def['description'],
                        effects=effects
                    ))
        
        return operations
    
    def _parse_effects(self, effects_data: List[Dict]) -> List[Effect]:
        """Parse effect annotations"""
        return [
            Effect(
                name=e['effect'],
                handler=e['handler'],
                description=e['description'],
                signature=e['signature'],
                resumable=e.get('resumable', True),
                required_by=e.get('required-by'),
                provenance=e.get('provenance'),
                provenance_type=e.get('provenance-type'),
                transaction=e.get('transaction')
            )
            for e in effects_data
        ]