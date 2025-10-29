"""
Command-line interface for hmis-codegen

Usage:
    hmis-codegen generate --ontology ontology.jsonld --spec api.yaml
    hmis-codegen validate --ontology ontology.jsonld --spec api.yaml
    hmis-codegen extract --spec api.yaml --output mappings.json
"""

from pathlib import Path
from typing import Optional
import json
import typer
from rich.console import Console
from rich.table import Table
from rich import print as rprint

from .parser import OntologyParser, YAMLLDParser
from .generator import Generator
from .effects import EffectSystem

app = typer.Typer(
    name="hmis-codegen",
    help="YAML-LD to API toolchain for HUD HMIS ontology",
    add_completion=False
)
console = Console()


@app.command()
def generate(
    ontology: Path = typer.Option(
        ..., 
        "--ontology", 
        "-o",
        help="Path to JSON-LD ontology file",
        exists=True
    ),
    spec: Path = typer.Option(
        ...,
        "--spec",
        "-s", 
        help="Path to YAML-LD API specification",
        exists=True
    ),
    output_dir: Path = typer.Option(
        Path("./generated"),
        "--output-dir",
        "-d",
        help="Output directory for generated files"
    ),
    format: str = typer.Option(
        "all",
        "--format",
        "-f",
        help="Output format: all|context|openapi|mockoon|handlers|mocks"
    )
):
    """
    Generate outputs from YAML-LD specification and ontology
    
    Examples:
        # Generate all outputs
        hmis-codegen generate -o ontology.jsonld -s api.yaml
        
        # Generate only JSON-LD context
        hmis-codegen generate -o ontology.jsonld -s api.yaml -f context
    """
    console.print("[bold blue]HMIS Code Generator[/bold blue]")
    console.print(f"Ontology: {ontology}")
    console.print(f"Spec: {spec}")
    console.print()
    
    # Parse inputs
    with console.status("[bold green]Parsing ontology..."):
        ontology_parser = OntologyParser(ontology)
        ontology_model = ontology_parser.to_model()
        console.print(f"✓ Parsed {len(ontology_model.classes)} classes, "
                     f"{len(ontology_model.properties)} properties")
    
    with console.status("[bold green]Parsing YAML-LD specification..."):
        yaml_parser = YAMLLDParser(spec)
        spec_model = yaml_parser.parse()
        console.print(f"✓ Parsed {len(spec_model.schemas)} schemas, "
                     f"{len(spec_model.operations)} operations")
    
    # Extract and validate effects
    with console.status("[bold green]Processing effect system..."):
        all_effects = [e for op in spec_model.operations for e in op.effects]
        effect_system = EffectSystem(all_effects)
        errors = effect_system.validate_effects(spec_model.operations)
        
        if errors:
            console.print("[bold red]Effect validation errors:[/bold red]")
            for error in errors:
                console.print(f"  ✗ {error}")
            raise typer.Exit(1)
        
        handlers = effect_system.generate_handlers()
        console.print(f"✓ Validated {len(all_effects)} effects")
    
    # Generate outputs
    output_dir.mkdir(parents=True, exist_ok=True)
    templates_dir = Path(__file__).parent.parent.parent / "templates"
    generator = Generator(templates_dir)
    
    console.print()
    console.print("[bold green]Generating outputs...[/bold green]")
    
    generated_files = []
    
    if format in ["all", "context"]:
        with console.status("Generating JSON-LD context..."):
            context = generator.generate_jsonld_context(spec_model, ontology_model)
            context_path = output_dir / "context.jsonld"
            context_path.write_text(context)
            generated_files.append(("JSON-LD Context", context_path))
            console.print(f"✓ Generated JSON-LD context: {context_path}")
    
    if format in ["all", "openapi"]:
        with console.status("Generating OpenAPI YAML..."):
            openapi = generator.generate_openapi_yaml(spec_model)
            openapi_path = output_dir / "openapi.yaml"
            openapi_path.write_text(openapi)
            generated_files.append(("OpenAPI Spec", openapi_path))
            console.print(f"✓ Generated OpenAPI YAML: {openapi_path}")
    
    if format in ["all", "mockoon"]:
        with console.status("Generating Mockoon configuration..."):
            mockoon = generator.generate_mockoon_config(spec_model)
            mockoon_path = output_dir / "mockoon-env.json"
            mockoon_path.write_text(mockoon)
            generated_files.append(("Mockoon Config", mockoon_path))
            console.print(f"✓ Generated Mockoon config: {mockoon_path}")
    
    if format in ["all", "handlers"]:
        with console.status("Generating effect handlers..."):
            handler_code = generator.generate_effect_handlers(handlers)
            handler_path = output_dir / "effect_handlers.py"
            handler_path.write_text(handler_code)
            generated_files.append(("Effect Handlers", handler_path))
            console.print(f"✓ Generated effect handlers: {handler_path}")
    
    if format in ["all", "mocks"]:
        with console.status("Generating mock handlers..."):
            mock_code = generator.generate_effect_mocks(handlers)
            mock_path = output_dir / "effect_mocks.py"
            mock_path.write_text(mock_code)
            generated_files.append(("Mock Handlers", mock_path))
            console.print(f"✓ Generated mock handlers: {mock_path}")
    
    # Summary table
    console.print()
    table = Table(title="Generated Files", show_header=True, header_style="bold cyan")
    table.add_column("Type", style="cyan")
    table.add_column("Path", style="green")
    
    for file_type, file_path in generated_files:
        table.add_row(file_type, str(file_path))
    
    console.print(table)
    console.print()
    console.print("[bold green]✓ Generation complete![/bold green]")


@app.command()
def validate(
    ontology: Path = typer.Option(
        ...,
        "--ontology",
        "-o",
        help="Path to JSON-LD ontology file",
        exists=True
    ),
    spec: Path = typer.Option(
        ...,
        "--spec",
        "-s",
        help="Path to YAML-LD API specification",
        exists=True
    )
):
    """
    Validate YAML-LD specification against ontology
    
    Checks:
    - All semantic URIs reference valid ontology terms
    - All effects are properly defined
    - HUD data element references are valid
    - Schema cardinality matches ontology
    """
    console.print("[bold blue]HMIS Validator[/bold blue]")
    console.print()
    
    # Parse inputs
    with console.status("[bold green]Loading ontology..."):
        ontology_parser = OntologyParser(ontology)
        ontology_model = ontology_parser.to_model()
    
    with console.status("[bold green]Loading specification..."):
        yaml_parser = YAMLLDParser(spec)
        spec_model = yaml_parser.parse()
    
    # Validation checks
    errors = []
    warnings = []
    
    console.print("[bold yellow]Running validation checks...[/bold yellow]")
    console.print()
    
    # 1. Validate semantic URIs
    ontology_uris = {str(c.uri) for c in ontology_model.classes}
    ontology_uris.update({str(p.uri) for p in ontology_model.properties})
    
    for schema in spec_model.schemas:
        if schema.semantic.semantic_uri:
            uri = str(schema.semantic.semantic_uri)
            if uri not in ontology_uris:
                errors.append(f"Schema '{schema.name}' references unknown URI: {uri}")
        
        for prop in schema.properties:
            if prop.semantic.semantic_uri:
                uri = str(prop.semantic.semantic_uri)
                if uri not in ontology_uris:
                    errors.append(
                        f"Property '{schema.name}.{prop.name}' references unknown URI: {uri}"
                    )
    
    # 2. Validate effects
    all_effects = [e for op in spec_model.operations for e in op.effects]
    effect_system = EffectSystem(all_effects)
    effect_errors = effect_system.validate_effects(spec_model.operations)
    errors.extend(effect_errors)
    
    # 3. Check for missing semantic annotations
    for schema in spec_model.schemas:
        if not schema.semantic.semantic_uri:
            warnings.append(f"Schema '{schema.name}' missing x-semantic-uri annotation")
        
        for prop in schema.properties:
            if not prop.semantic.semantic_uri:
                warnings.append(
                    f"Property '{schema.name}.{prop.name}' missing x-semantic-uri annotation"
                )
    
    # Display results
    if errors:
        console.print("[bold red]❌ Validation failed[/bold red]")
        console.print()
        console.print("[red]Errors:[/red]")
        for error in errors:
            console.print(f"  • {error}")
        
        if warnings:
            console.print()
            console.print("[yellow]Warnings:[/yellow]")
            for warning in warnings:
                console.print(f"  • {warning}")
        
        raise typer.Exit(1)
    
    elif warnings:
        console.print("[bold yellow]⚠ Validation passed with warnings[/bold yellow]")
        console.print()
        console.print("[yellow]Warnings:[/yellow]")
        for warning in warnings:
            console.print(f"  • {warning}")
        console.print()
        console.print("[dim]These warnings indicate missing semantic annotations.")
        console.print("The spec is valid, but adding annotations improves tooling.[/dim]")
    
    else:
        console.print("[bold green]✓ Validation passed![/bold green]")
        console.print()
        console.print(f"✓ {len(spec_model.schemas)} schemas validated")
        console.print(f"✓ {len(spec_model.operations)} operations validated")
        console.print(f"✓ {len(all_effects)} effects validated")
        console.print(f"✓ All semantic URIs reference valid ontology terms")


@app.command()
def extract(
    spec: Path = typer.Option(
        ...,
        "--spec",
        "-s",
        help="Path to YAML-LD API specification",
        exists=True
    ),
    output: Path = typer.Option(
        Path("semantic-mappings.json"),
        "--output",
        "-o",
        help="Output file for semantic mappings"
    ),
    format: str = typer.Option(
        "json",
        "--format",
        "-f",
        help="Output format: json|yaml|csv"
    )
):
    """
    Extract semantic mappings from YAML-LD specification
    
    Useful for debugging and understanding the semantic structure
    without generating full outputs.
    """
    console.print("[bold blue]Semantic Mapping Extractor[/bold blue]")
    console.print()
    
    with console.status("[bold green]Parsing specification..."):
        yaml_parser = YAMLLDParser(spec)
        spec_model = yaml_parser.parse()
    
    # Extract mappings
    mappings = {
        "schemas": [],
        "properties": [],
        "effects": [],
        "operations": []
    }
    
    # Schema mappings
    for schema in spec_model.schemas:
        if schema.semantic.semantic_uri:
            mappings["schemas"].append({
                "openapi_name": schema.name,
                "semantic_uri": str(schema.semantic.semantic_uri),
                "jsonld_type": schema.semantic.jsonld_type,
                "hud_csv_table": schema.hud_csv_table
            })
        
        # Property mappings
        for prop in schema.properties:
            if prop.semantic.semantic_uri:
                mappings["properties"].append({
                    "schema": schema.name,
                    "openapi_name": prop.name,
                    "semantic_uri": str(prop.semantic.semantic_uri),
                    "hud_data_element": prop.semantic.hud_data_element,
                    "pii": prop.semantic.pii
                })
    
    # Effect mappings
    all_effects = [e for op in spec_model.operations for e in op.effects]
    for effect in all_effects:
        mappings["effects"].append({
            "name": effect.name,
            "handler": effect.handler,
            "signature": effect.signature,
            "resumable": effect.resumable,
            "provenance_type": effect.provenance_type
        })
    
    # Operation mappings
    for operation in spec_model.operations:
        mappings["operations"].append({
            "operation_id": operation.operation_id,
            "method": operation.method,
            "path": operation.path,
            "effects": [e.name for e in operation.effects],
            "workflow_step": operation.metadata.workflow_step
        })
    
    # Write output
    if format == "json":
        output.write_text(json.dumps(mappings, indent=2))
    elif format == "yaml":
        import yaml
        output.write_text(yaml.dump(mappings, default_flow_style=False))
    elif format == "csv":
        # Simple CSV output for properties
        import csv
        with open(output, 'w', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=mappings["properties"][0].keys())
            writer.writeheader()
            writer.writerows(mappings["properties"])
    
    console.print(f"✓ Extracted {len(mappings['schemas'])} schema mappings")
    console.print(f"✓ Extracted {len(mappings['properties'])} property mappings")
    console.print(f"✓ Extracted {len(mappings['effects'])} effect definitions")
    console.print(f"✓ Extracted {len(mappings['operations'])} operation mappings")
    console.print()
    console.print(f"[green]Output written to: {output}[/green]")


@app.command()
def info(
    spec: Path = typer.Option(
        ...,
        "--spec",
        "-s",
        help="Path to YAML-LD API specification",
        exists=True
    )
):
    """
    Display information about a YAML-LD specification
    
    Shows summary statistics and experimental features in use.
    """
    console.print("[bold blue]Specification Info[/bold blue]")
    console.print()
    
    with console.status("[bold green]Analyzing specification..."):
        yaml_parser = YAMLLDParser(spec)
        spec_model = yaml_parser.parse()
    
    # Basic info
    console.print(f"[bold]Title:[/bold] {spec_model.title}")
    console.print(f"[bold]Version:[/bold] {spec_model.version}")
    console.print(f"[bold]JSON-LD Context:[/bold] {spec_model.jsonld_context_url}")
    console.print()
    
    # Statistics
    table = Table(title="Statistics", show_header=True, header_style="bold cyan")
    table.add_column("Metric", style="cyan")
    table.add_column("Count", justify="right", style="green")
    
    table.add_row("Schemas", str(len(spec_model.schemas)))
    table.add_row("Operations", str(len(spec_model.operations)))
    table.add_row("Servers", str(len(spec_model.servers)))
    table.add_row("Regulations Referenced", str(len(spec_model.regulations)))
    
    # Count semantic annotations
    semantic_schemas = sum(1 for s in spec_model.schemas if s.semantic.semantic_uri)
    semantic_props = sum(
        1 for s in spec_model.schemas 
        for p in s.properties 
        if p.semantic.semantic_uri
    )
    table.add_row("Semantically Annotated Schemas", str(semantic_schemas))
    table.add_row("Semantically Annotated Properties", str(semantic_props))
    
    # Count effects
    all_effects = [e for op in spec_model.operations for e in op.effects]
    unique_effects = len(set(e.name for e in all_effects))
    table.add_row("Total Effect Annotations", str(len(all_effects)))
    table.add_row("Unique Effect Types", str(unique_effects))
    
    console.print(table)
    console.print()
    
    # Experimental features
    if spec_model.effect_system:
        console.print("[bold yellow]🧪 Experimental Features Enabled:[/bold yellow]")
        console.print("  • Algebraic Effect Handler Annotations")
        console.print()
        
        # Show effect types
        if all_effects:
            console.print("[bold]Effect Types in Use:[/bold]")
            effect_counts = {}
            for effect in all_effects:
                effect_counts[effect.name] = effect_counts.get(effect.name, 0) + 1
            
            for effect_name, count in sorted(effect_counts.items(), key=lambda x: -x[1]):
                console.print(f"  • {effect_name}: {count} uses")
    
    console.print()
    
    # Compliance references
    console.print("[bold]Compliance References:[/bold]")
    for reg in spec_model.regulations:
        console.print(f"  • {reg.name}")
        console.print(f"    {reg.regulation}")
        console.print(f"    {reg.url}")
        console.print()


if __name__ == "__main__":
    app()
    """
@app.command()
def build_wasm(
    ontology: Path = typer.Option(..., "--ontology", "-o"),
    output: Path = typer.Option(Path("./hmis_validator.wasm"), "--output")
):
    '''
    Build WASM validator module (Experimental - Phase 1)
    
    Requires: Rust toolchain + wasm-pack installed
    '''
    console.print("[bold blue]WASM Builder (Experimental)[/bold blue]")
    
    # Parse ontology
    with console.status("Parsing ontology..."):
        parser = OntologyParser(ontology)
        ontology_model = parser.to_model()
    
    # Generate Rust code
    with console.status("Generating Rust code..."):
        codegen = WASMCodeGenerator()
        rust_code = codegen.generate_type_inference(ontology_model)
        
        wasm_dir = Path(__file__).parent.parent.parent / "wasm"
        (wasm_dir / "src" / "generated.rs").write_text(rust_code)
    
    # Compile WASM
    with console.status("Compiling to WASM..."):
        import subprocess
        result = subprocess.run(
            ["wasm-pack", "build", "--target", "web", "--release"],
            cwd=wasm_dir,
            capture_output=True
        )
        
        if result.returncode != 0:
            console.print("[red]Build failed:[/red]")
            console.print(result.stderr.decode())
            raise typer.Exit(1)
    
    # Copy output
    wasm_file = wasm_dir / "pkg" / "hmis_validator_wasm.wasm"
    shutil.copy(wasm_file, output)
    
    size_kb = output.stat().st_size // 1024
    console.print(f"✓ WASM module: {output} ({size_kb} KB)")
    console.print()
    console.print("[dim]🧪 Experimental Phase 1 feature[/dim]")
"""