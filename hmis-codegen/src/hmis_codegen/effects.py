"""
Effect system handling and code generation

Manages algebraic effect annotations and generates handler interfaces
"""

from typing import List, Dict, Set
from .models import Effect, EffectHandler, EffectSignature


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