"""
Effect system handling and code generation

Manages algebraic effect annotations and generates handler interfaces
"""

from typing import List, Dict, Set
from .models import Effect, EffectHandler, EffectSignature
from pydantic import BaseModel, Field, HttpUrl


class EffectSystem:
    """Manages effect system operations"""
    
    def __init__(self, effects: List[Effect]):
        self.effects = effects
        self.effect_registry: Dict[str, Effect] = {e.name: e for e in effects}
    
    def get_effect_dependencies(self, operation_effects: List[Effect]) -> Set[str]:
        """Get all effects an operation depends on (transitive)"""
        deps = set()
        for effect in operation_effects:
            deps.add(effect.name)
            # TODO: Add transitive dependency resolution
        return deps
    
    def validate_effects(self, operations: List) -> List[str]:
        """Validate that all referenced effects are defined"""
        errors = []
        
        for op in operations:
            for effect in op.effects:
                if effect.name not in self.effect_registry:
                    errors.append(f"Operation {op.operation_id} references undefined effect: {effect.name}")
        
        return errors
    
    def generate_handlers(self) -> List[EffectHandler]:
        """Generate effect handler interfaces"""
        handlers = []
        
        for effect in self.effects:
            sig = effect.parse_signature()
            handler = EffectHandler(
                name=effect.name,
                effect_type=effect.name,
                signature=sig,
                docstring=f"{effect.description}\n\nSignature: {effect.signature}"
            )
            handlers.append(handler)
        
        return handlers
# Add to effects.py

class FHIREffectHandler(BaseModel):
    """FHIR-specific effect handler with HUD Technical Standards compliance"""
    name: str
    description: str
    hud_standard: str  # e.g., "4.2.1"
    fhir_resources: List[str]  # e.g., ["Patient", "Consent"]
    validation_rules: List[Dict[str, str]]
    effect_handler_code: Optional[str] = None


class EffectSystem:
    """Manages effect system operations including FHIR handlers"""
    
    def __init__(self, effects: List[Effect], fhir_mappings: Optional[FHIRMappingsFile] = None):
        self.effects = effects
        self.effect_registry: Dict[str, Effect] = {e.name: e for e in effects}
        self.fhir_mappings = fhir_mappings
        self.fhir_effect_handlers = self._load_fhir_handlers() if fhir_mappings else {}
    
    def _load_fhir_handlers(self) -> Dict[str, FHIREffectHandler]:
        """Load FHIR effect handlers from mappings"""
        handlers = {}
        
        if self.fhir_mappings:
            for handler_name, handler_data in self.fhir_mappings.effect_handlers.items():
                handlers[handler_name] = FHIREffectHandler(
                    name=handler_name,
                    description=handler_data['description'],
                    hud_standard=handler_data['hud_standard'],
                    fhir_resources=handler_data['fhir_resources'],
                    validation_rules=handler_data['validation_rules'],
                    effect_handler_code=handler_data.get('effect_handler_code')
                )
        
        return handlers
    
    def generate_handlers(self) -> List[EffectHandler]:
        """Generate effect handler interfaces including FHIR handlers"""
        handlers = []
        
        # Regular effect handlers
        for effect in self.effects:
            sig = effect.parse_signature()
            handler = EffectHandler(
                name=effect.name,
                effect_type=effect.name,
                signature=sig,
                docstring=f"{effect.description}\n\nSignature: {effect.signature}"
            )
            handlers.append(handler)
        
        # FHIR effect handlers
        for fhir_handler in self.fhir_effect_handlers.values():
            # Convert FHIR handler to EffectHandler format
            sig = EffectSignature(
                params=self._infer_params_from_rules(fhir_handler.validation_rules),
                return_type="bool"
            )
            handler = EffectHandler(
                name=f"FHIR_{fhir_handler.name}",
                effect_type=fhir_handler.name,
                signature=sig,
                docstring=f"{fhir_handler.description}\n\nHUD Standard: {fhir_handler.hud_standard}"
            )
            handlers.append(handler)
        
        return handlers
    
    def _infer_params_from_rules(self, validation_rules: List[Dict[str, str]]) -> List[str]:
        """Infer handler parameters from validation rules"""
        # Simple inference - extract common parameter patterns
        params = ["patient_id: str", "consent_id: Optional[str] = None"]
        return params

# ==============================================================================
# Example Usage
# ==============================================================================
"""
# Parse ontology
ontology_parser = OntologyParser(Path("ontology.jsonld"))
ontology = ontology_parser.to_model()

# Parse YAML-LD spec
yaml_parser = YAMLLDParser(Path("hmis_api_ld_0.4.yaml"))
spec = yaml_parser.parse()

# Extract and validate effects
effect_system = EffectSystem(
    [effect for op in spec.operations for effect in op.effects]
)
errors = effect_system.validate_effects(spec.operations)
if errors:
    print("Effect validation errors:", errors)

# Generate effect handlers
handlers = effect_system.generate_handlers()
for handler in handlers:
    print(handler.to_python_protocol())
"""
