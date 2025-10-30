```
C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen>python -m hmis_codegen.cli generate --ontology "C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\FY26HMIS_JSON-LD_v1.jsonld" --spec "C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis_api_ld_0.4.yaml"
HMIS Code Generator
Ontology:
C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\FY26H
MIS_JSON-LD_v1.jsonld
Spec:
C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis_api_ld_0.4.ya
ml

╭──────────────────────────────── Traceback (most recent call last) ────────────────────────────────╮
│ C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\s │
│ rc\hmis_codegen\cli.py:77 in generate                                                             │
│                                                                                                   │
│    74 │   # Parse inputs                                                                          │
│    75 │   with console.status("[bold green]Parsing ontology..."):                                 │
│    76 │   │   ontology_parser = OntologyParser(ontology)                                          │
│ ❱  77 │   │   ontology_model = ontology_parser.to_model()                                         │
│    78 │   │   console.print(f"✓ Parsed {len(ontology_model.classes)} classes, "                   │
│    79 │   │   │   │   │    f"{len(ontology_model.properties)} properties")                        │
│    80                                                                                             │
│                                                                                                   │
│ ╭─────────────────────────────────────────── locals ────────────────────────────────────────────╮ │
│ │          format = 'all'                                                                       │ │
│ │        ontology = WindowsPath('C:/Users/gtuio/OneDrive/Documents/GitHub/002.GT.Data.Exchange… │ │
│ │ ontology_parser = <hmis_codegen.parser.OntologyParser object at 0x0000029027E53B60>           │ │
│ │      output_dir = WindowsPath('generated')                                                    │ │
│ │            spec = WindowsPath('C:/Users/gtuio/OneDrive/Documents/GitHub/002.GT.Data.Exchange… │ │
│ ╰───────────────────────────────────────────────────────────────────────────────────────────────╯ │
│                                                                                                   │
│ C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\s │
│ rc\hmis_codegen\parser.py:93 in to_model                                                          │
│                                                                                                   │
│    90 │   def to_model(self) -> OntologyModel:                                                    │
│    91 │   │   """Convert to Pydantic model"""                                                     │
│    92 │   │   return OntologyModel(                                                               │
│ ❱  93 │   │   │   classes=self.extract_classes(),                                                 │
│    94 │   │   │   properties=self.extract_properties(),                                           │
│    95 │   │   │   namespace=str(self.HMIS)                                                        │
│    96 │   │   )                                                                                   │
│                                                                                                   │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮                      │
│ │ self = <hmis_codegen.parser.OntologyParser object at 0x0000029027E53B60> │                      │
│ ╰──────────────────────────────────────────────────────────────────────────╯                      │
│                                                                                                   │
│ C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\s │
│ rc\hmis_codegen\parser.py:39 in extract_classes                                                   │
│                                                                                                   │
│    36 │   │   │   description = self._get_description(cls)                                        │
│    37 │   │   │   properties = self._get_class_properties(cls)                                    │
│    38 │   │   │                                                                                   │
│ ❱  39 │   │   │   classes.append(OWLClass(                                                        │
│    40 │   │   │   │   uri=str(cls),                                                               │
│    41 │   │   │   │   label=label,                                                                │
│    42 │   │   │   │   description=description,                                                    │
│                                                                                                   │
│ ╭──────────────────────────────────── locals ─────────────────────────────────────╮               │
│ │     classes = []                                                                │               │
│ │         cls = rdflib.term.BNode('genid1717')                                    │               │
│ │ description = None                                                              │               │
│ │       label = 'genid1717'                                                       │               │
│ │  properties = []                                                                │               │
│ │        self = <hmis_codegen.parser.OntologyParser object at 0x0000029027E53B60> │               │
│ ╰─────────────────────────────────────────────────────────────────────────────────╯               │
│                                                                                                   │
│ C:\Users\gtuio\AppData\Local\Python\pythoncore-3.14-64\Lib\site-packages\pydantic\main.py:250 in  │
│ __init__                                                                                          │
│                                                                                                   │
│    247 │   │   """                                                                                │
│    248 │   │   # `__tracebackhide__` tells pytest and some other tools to omit this function fr   │
│    249 │   │   __tracebackhide__ = True                                                           │
│ ❱  250 │   │   validated_self = self.__pydantic_validator__.validate_python(data, self_instance   │
│    251 │   │   if self is not validated_self:                                                     │
│    252 │   │   │   warnings.warn(                                                                 │
│    253 │   │   │   │   'A custom validator is returning a value other than `self`.\n'             │
│                                                                                                   │
│ ╭───────────────────────────────────────── locals ─────────────────────────────────────────╮      │
│ │ data = {'uri': 'genid1717', 'label': 'genid1717', 'description': None, 'properties': []} │      │
│ │ self = OWLClass()                                                                        │      │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────╯      │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
ValidationError: 1 validation error for OWLClass
uri
  Input should be a valid URL, relative URL without a base [type=url_parsing,
input_value='genid1717', input_type=str]
    For further information visit https://errors.pydantic.dev/2.12/v/url_parsing

C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen>
```