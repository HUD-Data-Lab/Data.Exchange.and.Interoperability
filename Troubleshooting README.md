# Current Error
```
C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen>python -m hmis_codegen.cli generate --ontology "C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\FY26HMIS_JSON-LD_v1.jsonld" --spec "C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis_api_ld_0.4.yaml"
HMIS Code Generator
Ontology: C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\FY26HMIS_JSON-LD_v1.jsonld
Spec: C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis_api_ld_0.4.yaml

✓ Parsed 45 classes, 401 properties
✓ Parsed 3 schemas, 1 operations
✓ Validated 3 effects

Generating outputs...
╭─────────────────────────────────────────────────────────────────────── Traceback (most recent call last) ───────────────────────────────────────────────────────────────────────╮
│ C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\src\hmis_codegen\cli.py:114 in generate                                         │
│                                                                                                                                                                                 │
│   111 │                                                                                                                                                                         │
│   112 │   if format in ["all", "context"]:                                                                                                                                      │
│   113 │   │   with console.status("Generating JSON-LD context..."):                                                                                                             │
│ ❱ 114 │   │   │   context = generator.generate_jsonld_context(spec_model, ontology_model)                                                                                       │
│   115 │   │   │   context_path = output_dir / "context.jsonld"                                                                                                                  │
│   116 │   │   │   context_path.write_text(context)                                                                                                                              │
│   117 │   │   │   generated_files.append(("JSON-LD Context", context_path))                                                                                                     │
│                                                                                                                                                                                 │
│ ╭────────────────────────────────────────────────────────────────────────────────── locals ───────────────────────────────────────────────────────────────────────────────────╮ │
│ │     all_effects = [                                                                                                                                                         │ │
│ │                   │   Effect(                                                                                                                                               │ │
│ │                   │   │   name='AuthorizationCheck',                                                                                                                        │ │
│ │                   │   │   handler='hmis:checkSearchPermission',                                                                                                             │ │
│ │                   │   │   description='Verifies user authorized to search client records',                                                                                  │ │
│ │                   │   │   signature='userID: ID â†’ AuthResult',                                                                                                            │ │
│ │                   │   │   resumable=True,                                                                                                                                   │ │
│ │                   │   │   required_by=None,                                                                                                                                 │ │
│ │                   │   │   provenance=None,                                                                                                                                  │ │
│ │                   │   │   provenance_type=None,                                                                                                                             │ │
│ │                   │   │   transaction=None                                                                                                                                  │ │
│ │                   │   ),                                                                                                                                                    │ │
│ │                   │   Effect(                                                                                                                                               │ │
│ │                   │   │   name='DatabaseRead',                                                                                                                              │ │
│ │                   │   │   handler='hmis:searchClients',                                                                                                                     │ │
│ │                   │   │   description='Searches clients by identifying criteria',                                                                                           │ │
│ │                   │   │   signature='query: SearchQuery â†’ List[Client]',                                                                                                  │ │
│ │                   │   │   resumable=True,                                                                                                                                   │ │
│ │                   │   │   required_by=None,                                                                                                                                 │ │
│ │                   │   │   provenance=None,                                                                                                                                  │ │
│ │                   │   │   provenance_type=None,                                                                                                                             │ │
│ │                   │   │   transaction=None                                                                                                                                  │ │
│ │                   │   ),                                                                                                                                                    │ │
│ │                   │   Effect(                                                                                                                                               │ │
│ │                   │   │   name='AuditLog',                                                                                                                                  │ │
│ │                   │   │   handler='hmis:logClientSearch',                                                                                                                   │ │
│ │                   │   │   description='Records search operation (without exposing PII)',                                                                                    │ │
│ │                   │   │   signature='event: SearchEvent â†’ Unit',                                                                                                          │ │
│ │                   │   │   resumable=False,                                                                                                                                  │ │
│ │                   │   │   required_by=None,                                                                                                                                 │ │
│ │                   │   │   provenance=None,                                                                                                                                  │ │
│ │                   │   │   provenance_type='prov:Search',                                                                                                                    │ │
│ │                   │   │   transaction=None                                                                                                                                  │ │
│ │                   │   )                                                                                                                                                     │ │
│ │                   ]                                                                                                                                                         │ │
│ │   effect_system = <hmis_codegen.effects.EffectSystem object at 0x000001B7DC53BA10>                                                                                          │ │
│ │          errors = []                                                                                                                                                        │ │
│ │          format = 'all'                                                                                                                                                     │ │
│ │ generated_files = []                                                                                                                                                        │ │
│ │       generator = <hmis_codegen.generator.Generator object at 0x000001B7DC53BE00>                                                                                           │ │
│ │        handlers = [                                                                                                                                                         │ │
│ │                   │   EffectHandler(                                                                                                                                        │ │
│ │                   │   │   name='AuthorizationCheck',                                                                                                                        │ │
│ │                   │   │   effect_type='AuthorizationCheck',                                                                                                                 │ │
│ │                   │   │   signature=EffectSignature(params=[], return_type='Unit'),                                                                                         │ │
│ │                   │   │   docstring='Verifies user authorized to search client records\n\nSignature: userID: ID â†’ Aut'+7                                                  │ │
│ │                   │   ),                                                                                                                                                    │ │
│ │                   │   EffectHandler(                                                                                                                                        │ │
│ │                   │   │   name='DatabaseRead',                                                                                                                              │ │
│ │                   │   │   effect_type='DatabaseRead',                                                                                                                       │ │
│ │                   │   │   signature=EffectSignature(params=[], return_type='Unit'),                                                                                         │ │
│ │                   │   │   docstring='Searches clients by identifying criteria\n\nSignature: query: SearchQuery â†’ List'+8                                                  │ │
│ │                   │   ),                                                                                                                                                    │ │
│ │                   │   EffectHandler(                                                                                                                                        │ │
│ │                   │   │   name='AuditLog',                                                                                                                                  │ │
│ │                   │   │   effect_type='AuditLog',                                                                                                                           │ │
│ │                   │   │   signature=EffectSignature(params=[], return_type='Unit'),                                                                                         │ │
│ │                   │   │   docstring='Records search operation (without exposing PII)\n\nSignature: event: SearchEvent â'+7                                                  │ │
│ │                   │   )                                                                                                                                                     │ │
│ │                   ]                                                                                                                                                         │ │
│ │        ontology = WindowsPath('C:/Users/gtuio/OneDrive/Documents/GitHub/002.GT.Data.Exchange.and.Interoperability/hmis-codegen/FY26HMIS_JSON-LD_v1.jsonld')                 │ │
│ │  ontology_model = OntologyModel(                                                                                                                                            │ │
│ │                   │   classes=[                                                                                                                                             │ │
│ │                   │   │   OWLClass(uri='genid1717', label='genid1717', description=None, properties=[]),                                                                    │ │
│ │                   │   │   OWLClass(uri='genid2003', label='genid2003', description=None, properties=[]),                                                                    │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#Affiliation',                                                                                                           │ │
│ │                   │   │   │   label='Affiliation',                                                                                                                          │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=['urn:hud:hmis:owl#AffiliationID', 'urn:hud:hmis:owl#ResProjectID']                                                                │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#Assessment',                                                                                                            │ │
│ │                   │   │   │   label='Assessment',                                                                                                                           │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentDate',                                                                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentID',                                                                                                          │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentLevel',                                                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentLocation',                                                                                                    │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentType',                                                                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#PrioritizationStatus',                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#hasAssessmentQuestion',                                                                                                 │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#hasAssessmentResult'                                                                                                    │ │
│ │                   │   │   │   ]                                                                                                                                             │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#AssessmentQuestionClass',                                                                                               │ │
│ │                   │   │   │   label='AssessmentQuestionClass',                                                                                                              │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentAnswer',                                                                                                      │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestion',                                                                                                    │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionGroup',                                                                                               │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionID',                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionOrder'                                                                                                │ │
│ │                   │   │   │   ]                                                                                                                                             │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#AssessmentResultClass',                                                                                                 │ │
│ │                   │   │   │   label='AssessmentResultClass',                                                                                                                │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=['urn:hud:hmis:owl#AssessmentResult', 'urn:hud:hmis:owl#AssessmentResultID', 'urn:hud:hmis:owl#AssessmentResultType']              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#CEParticipation',                                                                                                       │ │
│ │                   │   │   │   label='CEParticipation',                                                                                                                      │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AccessPoint',                                                                                                           │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CEParticipationID',                                                                                                     │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CEParticipationStatusEndDate',                                                                                          │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CEParticipationStatusStartDate',                                                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CrisisAssessment',                                                                                                      │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DirectServices',                                                                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#HousingAssessment',                                                                                                     │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#PreventionAssessment',                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#ReceivesReferrals'                                                                                                      │ │
│ │                   │   │   │   ]                                                                                                                                             │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#Client',                                                                                                                │ │
│ │                   │   │   │   label='Client',                                                                                                                               │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AdditionalRaceEthnicity',                                                                                               │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AmIndAKNative',                                                                                                         │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#Asian',                                                                                                                 │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#BlackAfAmerican',                                                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DOB',                                                                                                                   │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DOBDataQuality',                                                                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#FirstName',                                                                                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#HispanicLatinao',                                                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#LastName',                                                                                                              │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#MidEastNAfrican',                                                                                                       │ │
│ │                   │   │   │   │   ... +13                                                                                                                                   │ │
│ │                   │   │   │   ]                                                                                                                                             │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#ClientVeteranInfo',                                                                                                     │ │
│ │                   │   │   │   label='ClientVeteranInfo',                                                                                                                    │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AfghanistanOEF',                                                                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DesertStorm',                                                                                                           │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DischargeStatus',                                                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#IraqOIF',                                                                                                               │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#IraqOND',                                                                                                               │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#KoreanWar',                                                                                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#MilitaryBranch',                                                                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#OtherTheater',                                                                                                          │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#VietnamWar',                                                                                                            │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#WorldWarII',                                                                                                            │ │
│ │                   │   │   │   │   ... +2                                                                                                                                    │ │
│ │                   │   │   │   ]                                                                                                                                             │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLClass(                                                                                                                                         │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#ConnectionWithSOAR',                                                                                                    │ │
│ │                   │   │   │   label='ConnectionWithSOAR',                                                                                                                   │ │
│ │                   │   │   │   description=None,                                                                                                                             │ │
│ │                   │   │   │   properties=['urn:hud:hmis:owl#ConnectionWithSOAR', 'urn:hud:hmis:owl#IncomeBenefitsID']                                                       │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   ... +35                                                                                                                                           │ │
│ │                   │   ],                                                                                                                                                    │ │
│ │                   │   properties=[                                                                                                                                          │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAffiliation',                                                                                                        │ │
│ │                   │   │   │   label='hasAffiliation',                                                                                                                       │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Project',                                                                                                            │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#Affiliation',                                                                                                         │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAssessment',                                                                                                         │ │
│ │                   │   │   │   label='hasAssessment',                                                                                                                        │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                         │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#Assessment',                                                                                                          │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAssessmentQuestion',                                                                                                 │ │
│ │                   │   │   │   label='hasAssessmentQuestion',                                                                                                                │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Assessment',                                                                                                         │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#AssessmentQuestionClass',                                                                                             │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAssessmentResult',                                                                                                   │ │
│ │                   │   │   │   label='hasAssessmentResult',                                                                                                                  │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Assessment',                                                                                                         │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#AssessmentResultClass',                                                                                               │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasCEParticipation',                                                                                                    │ │
│ │                   │   │   │   label='hasCEParticipation',                                                                                                                   │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Project',                                                                                                            │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#CEParticipation',                                                                                                     │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasClientEnrollment',                                                                                                   │ │
│ │                   │   │   │   label='hasClientEnrollment',                                                                                                                  │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Client',                                                                                                             │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#Enrollment',                                                                                                          │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasClientVeteranInfo',                                                                                                  │ │
│ │                   │   │   │   label='hasClientVeteranInfo',                                                                                                                 │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Client',                                                                                                             │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#ClientVeteranInfo',                                                                                                   │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasConnectionWithSOAR',                                                                                                 │ │
│ │                   │   │   │   label='hasConnectionWithSOAR',                                                                                                                │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                         │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#ConnectionWithSOAR',                                                                                                  │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasCurrentLivingSituation',                                                                                             │ │
│ │                   │   │   │   label='hasCurrentLivingSituation',                                                                                                            │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                         │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#CurrentLivingSituationClass',                                                                                         │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   OWLProperty(                                                                                                                                      │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasDateOfEngagement',                                                                                                   │ │
│ │                   │   │   │   label='hasDateOfEngagement',                                                                                                                  │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                         │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#DateOfEngagementClass',                                                                                               │ │
│ │                   │   │   │   cardinality=None                                                                                                                              │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   ... +391                                                                                                                                          │ │
│ │                   │   ],                                                                                                                                                    │ │
│ │                   │   namespace='http://hmis.hud.gov/ontology#'                                                                                                             │ │
│ │                   )                                                                                                                                                         │ │
│ │ ontology_parser = <hmis_codegen.parser.OntologyParser object at 0x000001B7DC397B60>                                                                                         │ │
│ │      output_dir = WindowsPath('generated')                                                                                                                                  │ │
│ │            spec = WindowsPath('C:/Users/gtuio/OneDrive/Documents/GitHub/002.GT.Data.Exchange.and.Interoperability/hmis_api_ld_0.4.yaml')                                    │ │
│ │      spec_model = OpenAPISpec(                                                                                                                                              │ │
│ │                   │   title='HMIS API Sandbox Specifications',                                                                                                              │ │
│ │                   │   version='1.0.0',                                                                                                                                      │ │
│ │                   │   description='HMIS API Sandbox request, response, and error responses for each scenario in the'+323,                                                   │ │
│ │                   │                                                                                                                                                         │ │
│ │                   jsonld_context_url=HttpUrl('https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/001.%20Upcoming%20Versions/JSONLD/FY26HMIS_J… │ │
│ │                   │   regulations=[                                                                                                                                         │ │
│ │                   │   │   RegulationReference(                                                                                                                              │ │
│ │                   │   │   │   name='FY 2026 HMIS Data Standards',                                                                                                           │ │
│ │                   │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/3824/hmis-data-dictionary/'),                                                              │ │
│ │                   │   │   │   regulation='Data collection and implementation guidance'                                                                                      │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   RegulationReference(                                                                                                                              │ │
│ │                   │   │   │   name='2004 Data and Technical Standards Notice',                                                                                              │ │
│ │                   │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/1318/2004-hmis-data-and-technical-standards-final-notice/'),                               │ │
│ │                   │   │   │   regulation='Privacy and Security Standards'                                                                                                   │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   RegulationReference(                                                                                                                              │ │
│ │                   │   │   │   name='Coordinated Entry Management and Data Guide',                                                                                           │ │
│ │                   │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/5758/coordinated-entry-management-and-data-guide/'),                                       │ │
│ │                   │   │   │   regulation='Guidance on Privacy and Security Standards including allowable uses and disclosu'+3                                               │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   RegulationReference(                                                                                                                              │ │
│ │                   │   │   │   name='CoC Program Interim Rule',                                                                                                              │ │
│ │                   │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/2033/hearth-coc-program-interim-rule/'),                                                   │ │
│ │                   │   │   │   regulation='Procedures and Policies needed to designate and operate an HMIS, ensuring HMIS c'+79                                              │ │
│ │                   │   │   )                                                                                                                                                 │ │
│ │                   │   ],                                                                                                                                                    │ │
│ │                   │   servers=[ServerConfig(url='http://localhost:3000/api/v1', description='HMIS API Sandbox (Mockoon Reference Implementation)')],                        │ │
│ │                   │   schemas=[                                                                                                                                             │ │
│ │                   │   │   APISchema(                                                                                                                                        │ │
│ │                   │   │   │   name='clientPrimaryKey',                                                                                                                      │ │
│ │                   │   │   │   type='object',                                                                                                                                │ │
│ │                   │   │   │   description='Unique identifier for Client resource',                                                                                          │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='PersonalID',                                                                                                                    │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description='Unique identifier for the client',                                                                                       │ │
│ │                   │   │   │   │   │   max_length=32,                                                                                                                        │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasPersonalID'),                                                               │ │
│ │                   │   │   │   │   │   │   hud_data_element='Universal Data Element',                                                                                        │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   )                                                                                                                                         │ │
│ │                   │   │   │   ],                                                                                                                                            │ │
│ │                   │   │   │   semantic=SemanticAnnotation(                                                                                                                  │ │
│ │                   │   │   │   │   jsonld_type='hmis:ClientIdentifier',                                                                                                      │ │
│ │                   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#ClientIdentifier'),                                                                    │ │
│ │                   │   │   │   │   hud_data_element=None,                                                                                                                    │ │
│ │                   │   │   │   │   ontology_cardinality=None,                                                                                                                │ │
│ │                   │   │   │   │   pii=None                                                                                                                                  │ │
│ │                   │   │   │   ),                                                                                                                                            │ │
│ │                   │   │   │   hud_csv_table=None                                                                                                                            │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   APISchema(                                                                                                                                        │ │
│ │                   │   │   │   name='clientBase',                                                                                                                            │ │
│ │                   │   │   │   type='object',                                                                                                                                │ │
│ │                   │   │   │   description='Core Client demographic and identifying information',                                                                            │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='FirstName',                                                                                                                     │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description='First name of the client',                                                                                               │ │
│ │                   │   │   │   │   │   max_length=50,                                                                                                                        │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasFirstName'),                                                                │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.01',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='MiddleName',                                                                                                                    │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description='Middle name of the client',                                                                                              │ │
│ │                   │   │   │   │   │   max_length=50,                                                                                                                        │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasMiddleName'),                                                               │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.01',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='LastName',                                                                                                                      │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description='Last name of the client',                                                                                                │ │
│ │                   │   │   │   │   │   max_length=50,                                                                                                                        │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasLastName'),                                                                 │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.01',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='NameSuffix',                                                                                                                    │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description="Suffix of the client's name",                                                                                            │ │
│ │                   │   │   │   │   │   max_length=50,                                                                                                                        │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasNameSuffix'),                                                               │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.01',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='NameDataQuality',                                                                                                               │ │
│ │                   │   │   │   │   │   type='integer',                                                                                                                       │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description='Data quality indicator for name fields',                                                                                 │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasNameDataQuality'),                                                          │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.01',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='SSN',                                                                                                                           │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description='Social Security Number',                                                                                                 │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern='^[0-9]{9}$',                                                                                                                 │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasSSN'),                                                                      │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.02',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=True                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='SSNDataQuality',                                                                                                                │ │
│ │                   │   │   │   │   │   type='integer',                                                                                                                       │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasSSNDataQuality'),                                                           │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.02',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='DOB',                                                                                                                           │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format='date',                                                                                                                        │ │
│ │                   │   │   │   │   │   description='Date of birth of the client',                                                                                            │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDateOfBirth'),                                                              │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.03',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=True                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='DOBDataQuality',                                                                                                                │ │
│ │                   │   │   │   │   │   type='integer',                                                                                                                       │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDOBDataQuality'),                                                           │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.03',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='AmIndAKNative',                                                                                                                 │ │
│ │                   │   │   │   │   │   type='integer',                                                                                                                       │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasAmIndAKNative'),                                                            │ │
│ │                   │   │   │   │   │   │   hud_data_element='3.04',                                                                                                          │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   ... +30                                                                                                                                   │ │
│ │                   │   │   │   ],                                                                                                                                            │ │
│ │                   │   │   │   semantic=SemanticAnnotation(                                                                                                                  │ │
│ │                   │   │   │   │   jsonld_type='hmis:Client',                                                                                                                │ │
│ │                   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#Client'),                                                                              │ │
│ │                   │   │   │   │   hud_data_element=None,                                                                                                                    │ │
│ │                   │   │   │   │   ontology_cardinality=None,                                                                                                                │ │
│ │                   │   │   │   │   pii=None                                                                                                                                  │ │
│ │                   │   │   │   ),                                                                                                                                            │ │
│ │                   │   │   │   hud_csv_table='Client.csv'                                                                                                                    │ │
│ │                   │   │   ),                                                                                                                                                │ │
│ │                   │   │   APISchema(                                                                                                                                        │ │
│ │                   │   │   │   name='clientMetaData',                                                                                                                        │ │
│ │                   │   │   │   type='object',                                                                                                                                │ │
│ │                   │   │   │   description='Audit and versioning metadata for Client records',                                                                               │ │
│ │                   │   │   │   properties=[                                                                                                                                  │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='DateCreated',                                                                                                                   │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format='date-time',                                                                                                                   │ │
│ │                   │   │   │   │   │   description=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://purl.org/dc/terms/created'),                                                                         │ │
│ │                   │   │   │   │   │   │   hud_data_element=None,                                                                                                            │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='DateUpdated',                                                                                                                   │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format='date-time',                                                                                                                   │ │
│ │                   │   │   │   │   │   description=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://purl.org/dc/terms/modified'),                                                                        │ │
│ │                   │   │   │   │   │   │   hud_data_element=None,                                                                                                            │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='UserID',                                                                                                                        │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format=None,                                                                                                                          │ │
│ │                   │   │   │   │   │   description=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   max_length=32,                                                                                                                        │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://www.w3.org/ns/prov#wasAttributedTo'),                                                                │ │
│ │                   │   │   │   │   │   │   hud_data_element=None,                                                                                                            │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   SchemaProperty(                                                                                                                           │ │
│ │                   │   │   │   │   │   name='DateDeleted',                                                                                                                   │ │
│ │                   │   │   │   │   │   type='string',                                                                                                                        │ │
│ │                   │   │   │   │   │   format='date-time',                                                                                                                   │ │
│ │                   │   │   │   │   │   description=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   max_length=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   pattern=None,                                                                                                                         │ │
│ │                   │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                          │ │
│ │                   │   │   │   │   │   │   jsonld_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDateDeleted'),                                                              │ │
│ │                   │   │   │   │   │   │   hud_data_element=None,                                                                                                            │ │
│ │                   │   │   │   │   │   │   ontology_cardinality=None,                                                                                                        │ │
│ │                   │   │   │   │   │   │   pii=None                                                                                                                          │ │
│ │                   │   │   │   │   │   ),                                                                                                                                    │ │
│ │                   │   │   │   │   │   hud_reference=None,                                                                                                                   │ │
│ │                   │   │   │   │   │   conditional=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   business_rule=None                                                                                                                    │ │
│ │                   │   │   │   │   )                                                                                                                                         │ │
│ │                   │   │   │   ],                                                                                                                                            │ │
│ │                   │   │   │   semantic=SemanticAnnotation(                                                                                                                  │ │
│ │                   │   │   │   │   jsonld_type='prov:Entity',                                                                                                                │ │
│ │                   │   │   │   │   semantic_uri=HttpUrl('http://www.w3.org/ns/prov#Entity'),                                                                                 │ │
│ │                   │   │   │   │   hud_data_element=None,                                                                                                                    │ │
│ │                   │   │   │   │   ontology_cardinality=None,                                                                                                                │ │
│ │                   │   │   │   │   pii=None                                                                                                                                  │ │
│ │                   │   │   │   ),                                                                                                                                            │ │
│ │                   │   │   │   hud_csv_table=None                                                                                                                            │ │
│ │                   │   │   )                                                                                                                                                 │ │
│ │                   │   ],                                                                                                                                                    │ │
│ │                   │   operations=[                                                                                                                                          │ │
│ │                   │   │   APIOperation(                                                                                                                                     │ │
│ │                   │   │   │   operation_id='clientSearch',                                                                                                                  │ │
│ │                   │   │   │   method='post',                                                                                                                                │ │
│ │                   │   │   │   path='/client/search',                                                                                                                        │ │
│ │                   │   │   │   summary='Search for clients by identifying information using POST',                                                                           │ │
│ │                   │   │   │   description='Search for client records using various identifying criteria:\n- Name (first, las'+144,                                          │ │
│ │                   │   │   │   effects=[                                                                                                                                     │ │
│ │                   │   │   │   │   Effect(                                                                                                                                   │ │
│ │                   │   │   │   │   │   name='AuthorizationCheck',                                                                                                            │ │
│ │                   │   │   │   │   │   handler='hmis:checkSearchPermission',                                                                                                 │ │
│ │                   │   │   │   │   │   description='Verifies user authorized to search client records',                                                                      │ │
│ │                   │   │   │   │   │   signature='userID: ID â†’ AuthResult',                                                                                                │ │
│ │                   │   │   │   │   │   resumable=True,                                                                                                                       │ │
│ │                   │   │   │   │   │   required_by=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   provenance=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   provenance_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   transaction=None                                                                                                                      │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   Effect(                                                                                                                                   │ │
│ │                   │   │   │   │   │   name='DatabaseRead',                                                                                                                  │ │
│ │                   │   │   │   │   │   handler='hmis:searchClients',                                                                                                         │ │
│ │                   │   │   │   │   │   description='Searches clients by identifying criteria',                                                                               │ │
│ │                   │   │   │   │   │   signature='query: SearchQuery â†’ List[Client]',                                                                                      │ │
│ │                   │   │   │   │   │   resumable=True,                                                                                                                       │ │
│ │                   │   │   │   │   │   required_by=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   provenance=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   provenance_type=None,                                                                                                                 │ │
│ │                   │   │   │   │   │   transaction=None                                                                                                                      │ │
│ │                   │   │   │   │   ),                                                                                                                                        │ │
│ │                   │   │   │   │   Effect(                                                                                                                                   │ │
│ │                   │   │   │   │   │   name='AuditLog',                                                                                                                      │ │
│ │                   │   │   │   │   │   handler='hmis:logClientSearch',                                                                                                       │ │
│ │                   │   │   │   │   │   description='Records search operation (without exposing PII)',                                                                        │ │
│ │                   │   │   │   │   │   signature='event: SearchEvent â†’ Unit',                                                                                              │ │
│ │                   │   │   │   │   │   resumable=False,                                                                                                                      │ │
│ │                   │   │   │   │   │   required_by=None,                                                                                                                     │ │
│ │                   │   │   │   │   │   provenance=None,                                                                                                                      │ │
│ │                   │   │   │   │   │   provenance_type='prov:Search',                                                                                                        │ │
│ │                   │   │   │   │   │   transaction=None                                                                                                                      │ │
│ │                   │   │   │   │   )                                                                                                                                         │ │
│ │                   │   │   │   ],                                                                                                                                            │ │
│ │                   │   │   │   metadata=OperationMetadata(workflow_step=None, required_by_policy=[], data_governance=None, use_cases=[]),                                    │ │
│ │                   │   │   │   request_schema=None,                                                                                                                          │ │
│ │                   │   │   │   response_schemas={}                                                                                                                           │ │
│ │                   │   │   )                                                                                                                                                 │ │
│ │                   │   ],                                                                                                                                                    │ │
│ │                   │   effect_system={                                                                                                                                       │ │
│ │                   │   │   'description': 'HMIS API operations are annotated with algebraic effects they may perform.\nEffec'+321,                                           │ │
│ │                   │   │   'paradigm': 'Algebraic effects with handlers',                                                                                                    │ │
│ │                   │   │   'phase1-behavior': 'Documentary annotations for tooling',                                                                                         │ │
│ │                   │   │   'phase2-behavior': 'Runtime effect handlers with delimited continuations',                                                                        │ │
│ │                   │   │   'effect-types': [                                                                                                                                 │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'DatabaseRead',                                                                                                                   │ │
│ │                   │   │   │   │   'signature': 'query: Query â†’ Result',                                                                                                   │ │
│ │                   │   │   │   │   'description': 'Read operation against HMIS database',                                                                                    │ │
│ │                   │   │   │   │   'resumable': True,                                                                                                                        │ │
│ │                   │   │   │   │   'handler': 'Database handler provides actual SQL execution'                                                                               │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'DatabaseWrite',                                                                                                                  │ │
│ │                   │   │   │   │   'signature': 'entity: Entity, data: Data â†’ EntityID',                                                                                   │ │
│ │                   │   │   │   │   'description': 'Persist operation to HMIS database',                                                                                      │ │
│ │                   │   │   │   │   'resumable': False,                                                                                                                       │ │
│ │                   │   │   │   │   'handler': 'Database handler with transaction semantics'                                                                                  │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'ConsentCheck',                                                                                                                   │ │
│ │                   │   │   │   │   'signature': 'clientID: ID, purpose: Purpose â†’ ConsentStatus',                                                                          │ │
│ │                   │   │   │   │   'description': 'Validate client consent for specific purpose',                                                                            │ │
│ │                   │   │   │   │   'resumable': True,                                                                                                                        │ │
│ │                   │   │   │   │   'handler': 'Consent service checks ROI and consent records',                                                                              │ │
│ │                   │   │   │   │   'policy-uri': 'http://hmis.hud.gov/policy#ConsentRequired'                                                                                │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'ValidationCheck',                                                                                                                │ │
│ │                   │   │   │   │   'signature': 'data: Data, schema: Schema â†’ ValidationResult',                                                                           │ │
│ │                   │   │   │   │   'description': 'Validate data against HUD Data Standards',                                                                                │ │
│ │                   │   │   │   │   'resumable': True,                                                                                                                        │ │
│ │                   │   │   │   │   'handler': 'SHACL validator with ontology reasoning'                                                                                      │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'AuditLog',                                                                                                                       │ │
│ │                   │   │   │   │   'signature': 'event: Event â†’ Unit',                                                                                                     │ │
│ │                   │   │   │   │   'description': 'Record operation in immutable audit trail',                                                                               │ │
│ │                   │   │   │   │   'resumable': False,                                                                                                                       │ │
│ │                   │   │   │   │   'handler': 'Append-only audit log service',                                                                                               │ │
│ │                   │   │   │   │   'provenance': 'http://www.w3.org/ns/prov#Activity'                                                                                        │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'AuthorizationCheck',                                                                                                             │ │
│ │                   │   │   │   │   'signature': 'user: UserID, resource: ResourceID, action: Action â†’ Authorized',                                                         │ │
│ │                   │   │   │   │   'description': 'Check if user authorized for action on resource',                                                                         │ │
│ │                   │   │   │   │   'resumable': True,                                                                                                                        │ │
│ │                   │   │   │   │   'handler': 'Policy engine evaluates RBAC/ABAC rules'                                                                                      │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'ExternalAPI',                                                                                                                    │ │
│ │                   │   │   │   │   'signature': 'endpoint: URL, params: Params â†’ Response',                                                                                │ │
│ │                   │   │   │   │   'description': 'Call external service (e.g., SSN verification)',                                                                          │ │
│ │                   │   │   │   │   'resumable': True,                                                                                                                        │ │
│ │                   │   │   │   │   'handler': 'HTTP client with retry/timeout semantics'                                                                                     │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'ValidationError',                                                                                                                │ │
│ │                   │   │   │   │   'signature': 'error: ErrorDetail â†’ Never',                                                                                              │ │
│ │                   │   │   │   │   'description': 'Abort computation with validation error',                                                                                 │ │
│ │                   │   │   │   │   'resumable': False,                                                                                                                       │ │
│ │                   │   │   │   │   'handler': 'Error response generator'                                                                                                     │ │
│ │                   │   │   │   },                                                                                                                                            │ │
│ │                   │   │   │   {                                                                                                                                             │ │
│ │                   │   │   │   │   'name': 'BusinessRuleError',                                                                                                              │ │
│ │                   │   │   │   │   'signature': 'rule: Rule, violation: Detail â†’ Never',                                                                                   │ │
│ │                   │   │   │   │   'description': 'Abort computation due to business rule violation',                                                                        │ │
│ │                   │   │   │   │   'resumable': False,                                                                                                                       │ │
│ │                   │   │   │   │   'handler': 'Error response with policy traceability'                                                                                      │ │
│ │                   │   │   │   }                                                                                                                                             │ │
│ │                   │   │   ],                                                                                                                                                │ │
│ │                   │   │   'effect-patterns': {                                                                                                                              │ │
│ │                   │   │   │   'description': 'Effects compose naturally - an operation that calls sub-operations\ninherits thei'+62,                                        │ │
│ │                   │   │   │   'examples': [                                                                                                                                 │ │
│ │                   │   │   │   │   {                                                                                                                                         │ │
│ │                   │   │   │   │   │   'name': 'Client creation workflow',                                                                                                   │ │
│ │                   │   │   │   │   │   'effects': ['ConsentCheck', 'ValidationCheck', 'DatabaseWrite', 'AuditLog'],                                                          │ │
│ │                   │   │   │   │   │   'composition': 'Sequential effect execution with early termination on error'                                                          │ │
│ │                   │   │   │   │   },                                                                                                                                        │ │
│ │                   │   │   │   │   {                                                                                                                                         │ │
│ │                   │   │   │   │   │   'name': 'Client search with authorization',                                                                                           │ │
│ │                   │   │   │   │   │   'effects': ['AuthorizationCheck', 'DatabaseRead', 'AuditLog'],                                                                        │ │
│ │                   │   │   │   │   │   'composition': 'Authorization gates database access'                                                                                  │ │
│ │                   │   │   │   │   },                                                                                                                                        │ │
│ │                   │   │   │   │   {                                                                                                                                         │ │
│ │                   │   │   │   │   │   'name': 'Cross-organization data sharing',                                                                                            │ │
│ │                   │   │   │   │   │   'effects': ['AuthorizationCheck', 'ConsentCheck', 'DatabaseRead', 'AuditLog', 'ExternalAPI'],                                         │ │
│ │                   │   │   │   │   │   'composition': 'Multiple authorization layers before data access'                                                                     │ │
│ │                   │   │   │   │   }                                                                                                                                         │ │
│ │                   │   │   │   ]                                                                                                                                             │ │
│ │                   │   │   },                                                                                                                                                │ │
│ │                   │   │   'toolchain-integration': {                                                                                                                        │ │
│ │                   │   │   │   'parser': 'Extract x-effects from operations â†’ Effect AST',                                                                                 │ │
│ │                   │   │   │   'generator': 'Generate effect handler interfaces from Effect AST',                                                                            │ │
│ │                   │   │   │   'validator': 'Ensure all effects have registered handlers',                                                                                   │ │
│ │                   │   │   │   'test-harness': 'Generate mock effect handlers for unit tests',                                                                               │ │
│ │                   │   │   │   'example-output': '# Generated Python effect handler interfaces:\n\nclass DatabaseWriteHandler(Protoc'+292                                    │ │
│ │                   │   │   },                                                                                                                                                │ │
│ │                   │   │   '/client': {                                                                                                                                      │ │
│ │                   │   │   │   'post': {                                                                                                                                     │ │
│ │                   │   │   │   │   'operationId': 'postClient',                                                                                                              │ │
│ │                   │   │   │   │   'summary': 'Create a new client record',                                                                                                  │ │
│ │                   │   │   │   │   'description': 'Creates a new client record in the HMIS.\n\nValidates data quality requirements pe'+96,                                   │ │
│ │                   │   │   │   │   'x-workflow-step': 'client-intake',                                                                                                       │ │
│ │                   │   │   │   │   'x-required-by-policy': [                                                                                                                 │ │
│ │                   │   │   │   │   │   '2004 HMIS Data Standards Section 5.2.1: Client data must be collected',                                                              │ │
│ │                   │   │   │   │   │   'CoC Program Interim Rule: HMIS participation required for HUD-funded projects'                                                       │ │
│ │                   │   │   │   │   ],                                                                                                                                        │ │
│ │                   │   │   │   │   'x-data-governance': {                                                                                                                    │ │
│ │                   │   │   │   │   │   'retention': '7 years (per 2004 Technical Standards Section 5.2.1)',                                                                  │ │
│ │                   │   │   │   │   │   'consent-required': True,                                                                                                             │ │
│ │                   │   │   │   │   │   'allowable-disclosure': 'CoC-level aggregated reporting only'                                                                         │ │
│ │                   │   │   │   │   },                                                                                                                                        │ │
│ │                   │   │   │   │   'x-effects': [                                                                                                                            │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'effect': 'ConsentCheck',                                                                                                         │ │
│ │                   │   │   │   │   │   │   'handler': 'hmis:validateConsent',                                                                                                │ │
│ │                   │   │   │   │   │   │   'description': 'Verifies client consent for data collection',                                                                     │ │
│ │                   │   │   │   │   │   │   'signature': 'clientID: ID, purpose: Purpose â†’ ConsentStatus',                                                                  │ │
│ │                   │   │   │   │   │   │   'resumable': True,                                                                                                                │ │
│ │                   │   │   │   │   │   │   'required-by': '2004 HMIS Standards Section 4.2'                                                                                  │ │
│ │                   │   │   │   │   │   },                                                                                                                                    │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'effect': 'ValidationCheck',                                                                                                      │ │
│ │                   │   │   │   │   │   │   'handler': 'hmis:validateHUDStandards',                                                                                           │ │
│ │                   │   │   │   │   │   │   'description': 'Validates client data against HUD Data Standards',                                                                │ │
│ │                   │   │   │   │   │   │   'signature': 'data: ClientData, schema: Schema â†’ ValidationResult',                                                             │ │
│ │                   │   │   │   │   │   │   'resumable': True,                                                                                                                │ │
│ │                   │   │   │   │   │   │   'ontology-validation': 'Uses SHACL shapes from ontology'                                                                          │ │
│ │                   │   │   │   │   │   },                                                                                                                                    │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'effect': 'DatabaseWrite',                                                                                                        │ │
│ │                   │   │   │   │   │   │   'handler': 'hmis:persistClient',                                                                                                  │ │
│ │                   │   │   │   │   │   │   'description': 'Persists client record to HMIS database',                                                                         │ │
│ │                   │   │   │   │   │   │   'signature': 'entity: Client, data: Data â†’ PersonalID',                                                                         │ │
│ │                   │   │   │   │   │   │   'resumable': False,                                                                                                               │ │
│ │                   │   │   │   │   │   │   'transaction': True                                                                                                               │ │
│ │                   │   │   │   │   │   },                                                                                                                                    │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'effect': 'AuditLog',                                                                                                             │ │
│ │                   │   │   │   │   │   │   'handler': 'hmis:logClientCreation',                                                                                              │ │
│ │                   │   │   │   │   │   │   'description': 'Records client creation in immutable audit trail',                                                                │ │
│ │                   │   │   │   │   │   │   'signature': 'event: ClientCreatedEvent â†’ Unit',                                                                                │ │
│ │                   │   │   │   │   │   │   'resumable': False,                                                                                                               │ │
│ │                   │   │   │   │   │   │   'provenance': 'http://www.w3.org/ns/prov#Activity',                                                                               │ │
│ │                   │   │   │   │   │   │   'provenance-type': 'prov:Create'                                                                                                  │ │
│ │                   │   │   │   │   │   }                                                                                                                                     │ │
│ │                   │   │   │   │   ],                                                                                                                                        │ │
│ │                   │   │   │   │   'requestBody': {                                                                                                                          │ │
│ │                   │   │   │   │   │   'content': {                                                                                                                          │ │
│ │                   │   │   │   │   │   │   'application/json': {                                                                                                             │ │
│ │                   │   │   │   │   │   │   │   'schema': {'$ref': '#/components/schemas/clientBase'},                                                                        │ │
│ │                   │   │   │   │   │   │   │   'x-validation-rules': [                                                                                                       │ │
│ │                   │   │   │   │   │   │   │   │   {'rule': 'At least one name field (FirstName or LastName) required', 'severity': 'error'},                                │ │
│ │                   │   │   │   │   │   │   │   │   {'rule': 'SSN must be valid if SSNDataQuality = Full SSN reported', 'severity': 'error'},                                 │ │
│ │                   │   │   │   │   │   │   │   │   {'rule': 'Gender fields follow HUD multi-select logic', 'severity': 'warning'}                                            │ │
│ │                   │   │   │   │   │   │   │   ]                                                                                                                             │ │
│ │                   │   │   │   │   │   │   }                                                                                                                                 │ │
│ │                   │   │   │   │   │   }                                                                                                                                     │ │
│ │                   │   │   │   │   },                                                                                                                                        │ │
│ │                   │   │   │   │   'responses': {                                                                                                                            │ │
│ │                   │   │   │   │   │   '200': {                                                                                                                              │ │
│ │                   │   │   │   │   │   │   'description': 'Client record created successfully',                                                                              │ │
│ │                   │   │   │   │   │   │   'content': {                                                                                                                      │ │
│ │                   │   │   │   │   │   │   │   'application/json': {                                                                                                         │ │
│ │                   │   │   │   │   │   │   │   │   'schema': {                                                                                                               │ │
│ │                   │   │   │   │   │   │   │   │   │   'allOf': [                                                                                                            │ │
│ │                   │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientPrimaryKey'},                                                                │ │
│ │                   │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientBase'},                                                                      │ │
│ │                   │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientMetaData'}                                                                   │ │
│ │                   │   │   │   │   │   │   │   │   │   ]                                                                                                                     │ │
│ │                   │   │   │   │   │   │   │   │   },                                                                                                                        │ │
│ │                   │   │   │   │   │   │   │   │   'x-jsonld-frame': {                                                                                                       │ │
│ │                   │   │   │   │   │   │   │   │   │   '@context': 'https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/'+60,                    │ │
│ │                   │   │   │   │   │   │   │   │   │   '@type': 'hmis:Client',                                                                                               │ │
│ │                   │   │   │   │   │   │   │   │   │   '@id': 'http://hmis.example.org/client/{PersonalID}'                                                                  │ │
│ │                   │   │   │   │   │   │   │   │   }                                                                                                                         │ │
│ │                   │   │   │   │   │   │   │   }                                                                                                                             │ │
│ │                   │   │   │   │   │   │   }                                                                                                                                 │ │
│ │                   │   │   │   │   │   },                                                                                                                                    │ │
│ │                   │   │   │   │   │   '400': {                                                                                                                              │ │
│ │                   │   │   │   │   │   │   'description': 'Invalid input provided',                                                                                          │ │
│ │                   │   │   │   │   │   │   'content': {                                                                                                                      │ │
│ │                   │   │   │   │   │   │   │   'application/json': {                                                                                                         │ │
│ │                   │   │   │   │   │   │   │   │   'schema': {                                                                                                               │ │
│ │                   │   │   │   │   │   │   │   │   │   'oneOf': [                                                                                                            │ │
│ │                   │   │   │   │   │   │   │   │   │   │   {                                                                                                                 │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'type': 'object',                                                                                             │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'description': 'Data type validation error',                                                                  │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'x-jsonld-type': 'hmis:ValidationError',                                                                      │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'properties': {                                                                                               │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   'missingInformationIncorrectDatatype': {                                                                  │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   │   'type': 'string',                                                                                     │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   │   'description': 'Invalid input provided - incorrect data type or missing required field',              │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   │   'x-semantic-uri': 'http://hmis.hud.gov/errors#ValidationError'                                        │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   }                                                                                                         │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   }                                                                                                             │ │
│ │                   │   │   │   │   │   │   │   │   │   │   },                                                                                                                │ │
│ │                   │   │   │   │   │   │   │   │   │   │   {                                                                                                                 │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'type': 'object',                                                                                             │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'description': 'Business rule validation error',                                                              │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'x-jsonld-type': 'hmis:BusinessRuleError',                                                                    │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   'properties': {                                                                                               │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   'invalidInputProvided': {                                                                                 │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   │   'type': 'string',                                                                                     │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   │   'description': 'Business rule violation (e.g., conditional field requirements)',                      │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   │   'example': 'VeteranStatus = Yes requires YearEnteredService',                                         │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   │   'x-semantic-uri': 'http://hmis.hud.gov/errors#BusinessRuleError'                                      │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   │   }                                                                                                         │ │
│ │                   │   │   │   │   │   │   │   │   │   │   │   }                                                                                                             │ │
│ │                   │   │   │   │   │   │   │   │   │   │   }                                                                                                                 │ │
│ │                   │   │   │   │   │   │   │   │   │   ]                                                                                                                     │ │
│ │                   │   │   │   │   │   │   │   │   },                                                                                                                        │ │
│ │                   │   │   │   │   │   │   │   │   'x-error-classification': {                                                                                               │ │
│ │                   │   │   │   │   │   │   │   │   │   'validation-error': 'Data fails HUD Data Standards validation',                                                       │ │
│ │                   │   │   │   │   │   │   │   │   │   'business-rule-error': 'Violates HUD program logic (e.g., conditional requirements)'                                  │ │
│ │                   │   │   │   │   │   │   │   │   }                                                                                                                         │ │
│ │                   │   │   │   │   │   │   │   }                                                                                                                             │ │
│ │                   │   │   │   │   │   │   }                                                                                                                                 │ │
│ │                   │   │   │   │   │   }                                                                                                                                     │ │
│ │                   │   │   │   │   }                                                                                                                                         │ │
│ │                   │   │   │   }                                                                                                                                             │ │
│ │                   │   │   },                                                                                                                                                │ │
│ │                   │   │   '/clientinproject': {                                                                                                                             │ │
│ │                   │   │   │   'get': {                                                                                                                                      │ │
│ │                   │   │   │   │   'operationId': 'clientListByProjectID',                                                                                                   │ │
│ │                   │   │   │   │   'summary': 'Get list of clients by project using ProjectID',                                                                              │ │
│ │                   │   │   │   │   'description': 'Returns all clients enrolled in specified project(s).\n\nSupports multi-project qu'+104,                                  │ │
│ │                   │   │   │   │   'x-workflow-step': 'project-reporting',                                                                                                   │ │
│ │                   │   │   │   │   'x-required-by-policy': ['CoC Program Interim Rule: Project-level data reporting requirements'],                                          │ │
│ │                   │   │   │   │   'x-use-cases': ['Annual Performance Report (APR) data extraction', 'CAPER report generation', 'CoC competition application data'],        │ │
│ │                   │   │   │   │   'x-effects': [                                                                                                                            │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'effect': 'AuthorizationCheck',                                                                                                   │ │
│ │                   │   │   │   │   │   │   'handler': 'hmis:checkProjectAccess',                                                                                             │ │
│ │                   │   │   │   │   │   │   'description': 'Verifies user has read access to requested projects',                                                             │ │
│ │                   │   │   │   │   │   │   'signature': 'userID: ID, projectIDs: List[ID] â†’ AuthResult',                                                                   │ │
│ │                   │   │   │   │   │   │   'resumable': True                                                                                                                 │ │
│ │                   │   │   │   │   │   },                                                                                                                                    │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'effect': 'DatabaseRead',                                                                                                         │ │
│ │                   │   │   │   │   │   │   'handler': 'hmis:queryClientsByProject',                                                                                          │ │
│ │                   │   │   │   │   │   │   'description': 'Queries clients enrolled in specified projects',                                                                  │ │
│ │                   │   │   │   │   │   │   'signature': 'projectIDs: List[ID] â†’ List[Client]',                                                                             │ │
│ │                   │   │   │   │   │   │   'resumable': True,                                                                                                                │ │
│ │                   │   │   │   │   │   │   'query-complexity': 'O(n) where n = number of enrollments'                                                                        │ │
│ │                   │   │   │   │   │   },                                                                                                                                    │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'effect': 'AuditLog',                                                                                                             │ │
│ │                   │   │   │   │   │   │   'handler': 'hmis:logProjectQuery',                                                                                                │ │
│ │                   │   │   │   │   │   │   'description': 'Records project data access for compliance',                                                                      │ │
│ │                   │   │   │   │   │   │   'signature': 'event: ProjectQueryEvent â†’ Unit',                                                                                 │ │
│ │                   │   │   │   │   │   │   'resumable': False,                                                                                                               │ │
│ │                   │   │   │   │   │   │   'provenance-type': 'prov:Read'                                                                                                    │ │
│ │                   │   │   │   │   │   }                                                                                                                                     │ │
│ │                   │   │   │   │   ],                                                                                                                                        │ │
│ │                   │   │   │   │   'parameters': [                                                                                                                           │ │
│ │                   │   │   │   │   │   {                                                                                                                                     │ │
│ │                   │   │   │   │   │   │   'name': 'ProjectID',                                                                                                              │ │
│ │                   │   │   │   │   │   │   'in': 'query',                                                                                                                    │ │
│ │                   │   │   │   │   │   │   'required': False,                                                                                                                │ │
│ │                   │   │   │   │   │   │   'description': 'One or more project IDs to filter clients',                                                                       │ │
│ │                   │   │   │   │   │   │   'style': 'form',                                                                                                                  │ │
│ │                   │   │   │   │   │   │   'explode': True,                                                                                                                  │ │
│ │                   │   │   │   │   │   │   'schema': {                                                                                                                       │ │
│ │                   │   │   │   │   │   │   │   'type': 'array',                                                                                                              │ │
│ │                   │   │   │   │   │   │   │   'items': {'type': 'string', 'maxLength': 32, 'x-semantic-uri': 'http://hmis.hud.gov/ontology#hasProjectID'}                   │ │
│ │                   │   │   │   │   │   │   }                                                                                                                                 │ │
│ │                   │   │   │   │   │   }                                                                                                                                     │ │
│ │                   │   │   │   │   ],                                                                                                                                        │ │
│ │                   │   │   │   │   'responses': {                                                                                                                            │ │
│ │                   │   │   │   │   │   '200': {                                                                                                                              │ │
│ │                   │   │   │   │   │   │   'description': 'A list of clients and any unmatched project IDs',                                                                 │ │
│ │                   │   │   │   │   │   │   'content': {                                                                                                                      │ │
│ │                   │   │   │   │   │   │   │   'application/json': {'schema': {'type': 'object', 'x-jsonld-type': 'hmis:ProjectClientListResponse', 'properties': None}}     │ │
│ │                   │   │   │   │   │   │   }                                                                                                                                 │ │
│ │                   │   │   │   │   │   }                                                                                                                                     │ │
│ │                   │   │   │   │   }                                                                                                                                         │ │
│ │                   │   │   │   }                                                                                                                                             │ │
│ │                   │   │   }                                                                                                                                                 │ │
│ │                   │   }                                                                                                                                                     │ │
│ │                   )                                                                                                                                                         │ │
│ │   templates_dir = WindowsPath('C:/Users/gtuio/OneDrive/Documents/GitHub/002.GT.Data.Exchange.and.Interoperability/hmis-codegen/templates')                                  │ │
│ │     yaml_parser = <hmis_codegen.parser.YAMLLDParser object at 0x000001B7DC397380>                                                                                           │ │
│ ╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│                                                                                                                                                                                 │
│ C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\src\hmis_codegen\generator.py:34 in generate_jsonld_context                     │
│                                                                                                                                                                                 │
│    31 │   │   ontology: OntologyModel                                                                                                                                           │
│    32 │   ) -> str:                                                                                                                                                             │
│    33 │   │   """Generate JSON-LD @context from YAML-LD semantic annotations"""                                                                                                 │
│ ❱  34 │   │   template = self.env.get_template('jsonld_context.j2')                                                                                                             │
│    35 │   │                                                                                                                                                                     │
│    36 │   │   # Build context mappings                                                                                                                                          │
│    37 │   │   context = {                                                                                                                                                       │
│                                                                                                                                                                                 │
│ ╭────────────────────────────────────────────────────────────────────────────────── locals ───────────────────────────────────────────────────────────────────────────────────╮ │
│ │ ontology = OntologyModel(                                                                                                                                                   │ │
│ │            │   classes=[                                                                                                                                                    │ │
│ │            │   │   OWLClass(uri='genid1717', label='genid1717', description=None, properties=[]),                                                                           │ │
│ │            │   │   OWLClass(uri='genid2003', label='genid2003', description=None, properties=[]),                                                                           │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#Affiliation',                                                                                                                  │ │
│ │            │   │   │   label='Affiliation',                                                                                                                                 │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=['urn:hud:hmis:owl#AffiliationID', 'urn:hud:hmis:owl#ResProjectID']                                                                       │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#Assessment',                                                                                                                   │ │
│ │            │   │   │   label='Assessment',                                                                                                                                  │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentDate',                                                                                                               │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentID',                                                                                                                 │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentLevel',                                                                                                              │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentLocation',                                                                                                           │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentType',                                                                                                               │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#PrioritizationStatus',                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#hasAssessmentQuestion',                                                                                                        │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#hasAssessmentResult'                                                                                                           │ │
│ │            │   │   │   ]                                                                                                                                                    │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#AssessmentQuestionClass',                                                                                                      │ │
│ │            │   │   │   label='AssessmentQuestionClass',                                                                                                                     │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentAnswer',                                                                                                             │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestion',                                                                                                           │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionGroup',                                                                                                      │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionID',                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionOrder'                                                                                                       │ │
│ │            │   │   │   ]                                                                                                                                                    │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#AssessmentResultClass',                                                                                                        │ │
│ │            │   │   │   label='AssessmentResultClass',                                                                                                                       │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=['urn:hud:hmis:owl#AssessmentResult', 'urn:hud:hmis:owl#AssessmentResultID', 'urn:hud:hmis:owl#AssessmentResultType']                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#CEParticipation',                                                                                                              │ │
│ │            │   │   │   label='CEParticipation',                                                                                                                             │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AccessPoint',                                                                                                                  │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#CEParticipationID',                                                                                                            │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#CEParticipationStatusEndDate',                                                                                                 │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#CEParticipationStatusStartDate',                                                                                               │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#CrisisAssessment',                                                                                                             │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#DirectServices',                                                                                                               │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#HousingAssessment',                                                                                                            │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#PreventionAssessment',                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#ReceivesReferrals'                                                                                                             │ │
│ │            │   │   │   ]                                                                                                                                                    │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#Client',                                                                                                                       │ │
│ │            │   │   │   label='Client',                                                                                                                                      │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AdditionalRaceEthnicity',                                                                                                      │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AmIndAKNative',                                                                                                                │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#Asian',                                                                                                                        │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#BlackAfAmerican',                                                                                                              │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#DOB',                                                                                                                          │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#DOBDataQuality',                                                                                                               │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#FirstName',                                                                                                                    │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#HispanicLatinao',                                                                                                              │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#LastName',                                                                                                                     │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#MidEastNAfrican',                                                                                                              │ │
│ │            │   │   │   │   ... +13                                                                                                                                          │ │
│ │            │   │   │   ]                                                                                                                                                    │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#ClientVeteranInfo',                                                                                                            │ │
│ │            │   │   │   label='ClientVeteranInfo',                                                                                                                           │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#AfghanistanOEF',                                                                                                               │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#DesertStorm',                                                                                                                  │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#DischargeStatus',                                                                                                              │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#IraqOIF',                                                                                                                      │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#IraqOND',                                                                                                                      │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#KoreanWar',                                                                                                                    │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#MilitaryBranch',                                                                                                               │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#OtherTheater',                                                                                                                 │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#VietnamWar',                                                                                                                   │ │
│ │            │   │   │   │   'urn:hud:hmis:owl#WorldWarII',                                                                                                                   │ │
│ │            │   │   │   │   ... +2                                                                                                                                           │ │
│ │            │   │   │   ]                                                                                                                                                    │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLClass(                                                                                                                                                │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#ConnectionWithSOAR',                                                                                                           │ │
│ │            │   │   │   label='ConnectionWithSOAR',                                                                                                                          │ │
│ │            │   │   │   description=None,                                                                                                                                    │ │
│ │            │   │   │   properties=['urn:hud:hmis:owl#ConnectionWithSOAR', 'urn:hud:hmis:owl#IncomeBenefitsID']                                                              │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   ... +35                                                                                                                                                  │ │
│ │            │   ],                                                                                                                                                           │ │
│ │            │   properties=[                                                                                                                                                 │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasAffiliation',                                                                                                               │ │
│ │            │   │   │   label='hasAffiliation',                                                                                                                              │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Project',                                                                                                                   │ │
│ │            │   │   │   range='urn:hud:hmis:owl#Affiliation',                                                                                                                │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasAssessment',                                                                                                                │ │
│ │            │   │   │   label='hasAssessment',                                                                                                                               │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                                │ │
│ │            │   │   │   range='urn:hud:hmis:owl#Assessment',                                                                                                                 │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasAssessmentQuestion',                                                                                                        │ │
│ │            │   │   │   label='hasAssessmentQuestion',                                                                                                                       │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Assessment',                                                                                                                │ │
│ │            │   │   │   range='urn:hud:hmis:owl#AssessmentQuestionClass',                                                                                                    │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasAssessmentResult',                                                                                                          │ │
│ │            │   │   │   label='hasAssessmentResult',                                                                                                                         │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Assessment',                                                                                                                │ │
│ │            │   │   │   range='urn:hud:hmis:owl#AssessmentResultClass',                                                                                                      │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasCEParticipation',                                                                                                           │ │
│ │            │   │   │   label='hasCEParticipation',                                                                                                                          │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Project',                                                                                                                   │ │
│ │            │   │   │   range='urn:hud:hmis:owl#CEParticipation',                                                                                                            │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasClientEnrollment',                                                                                                          │ │
│ │            │   │   │   label='hasClientEnrollment',                                                                                                                         │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Client',                                                                                                                    │ │
│ │            │   │   │   range='urn:hud:hmis:owl#Enrollment',                                                                                                                 │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasClientVeteranInfo',                                                                                                         │ │
│ │            │   │   │   label='hasClientVeteranInfo',                                                                                                                        │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Client',                                                                                                                    │ │
│ │            │   │   │   range='urn:hud:hmis:owl#ClientVeteranInfo',                                                                                                          │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasConnectionWithSOAR',                                                                                                        │ │
│ │            │   │   │   label='hasConnectionWithSOAR',                                                                                                                       │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                                │ │
│ │            │   │   │   range='urn:hud:hmis:owl#ConnectionWithSOAR',                                                                                                         │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasCurrentLivingSituation',                                                                                                    │ │
│ │            │   │   │   label='hasCurrentLivingSituation',                                                                                                                   │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                                │ │
│ │            │   │   │   range='urn:hud:hmis:owl#CurrentLivingSituationClass',                                                                                                │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   OWLProperty(                                                                                                                                             │ │
│ │            │   │   │   uri='urn:hud:hmis:owl#hasDateOfEngagement',                                                                                                          │ │
│ │            │   │   │   label='hasDateOfEngagement',                                                                                                                         │ │
│ │            │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                                                                                                │ │
│ │            │   │   │   range='urn:hud:hmis:owl#DateOfEngagementClass',                                                                                                      │ │
│ │            │   │   │   cardinality=None                                                                                                                                     │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   ... +391                                                                                                                                                 │ │
│ │            │   ],                                                                                                                                                           │ │
│ │            │   namespace='http://hmis.hud.gov/ontology#'                                                                                                                    │ │
│ │            )                                                                                                                                                                │ │
│ │     self = <hmis_codegen.generator.Generator object at 0x000001B7DC53BE00>                                                                                                  │ │
│ │     spec = OpenAPISpec(                                                                                                                                                     │ │
│ │            │   title='HMIS API Sandbox Specifications',                                                                                                                     │ │
│ │            │   version='1.0.0',                                                                                                                                             │ │
│ │            │   description='HMIS API Sandbox request, response, and error responses for each scenario in the'+323,                                                          │ │
│ │            │                                                                                                                                                                │ │
│ │            jsonld_context_url=HttpUrl('https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/001.%20Upcoming%20Versions/JSONLD/FY26HMIS_JSON-LD_… │ │
│ │            │   regulations=[                                                                                                                                                │ │
│ │            │   │   RegulationReference(                                                                                                                                     │ │
│ │            │   │   │   name='FY 2026 HMIS Data Standards',                                                                                                                  │ │
│ │            │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/3824/hmis-data-dictionary/'),                                                                     │ │
│ │            │   │   │   regulation='Data collection and implementation guidance'                                                                                             │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   RegulationReference(                                                                                                                                     │ │
│ │            │   │   │   name='2004 Data and Technical Standards Notice',                                                                                                     │ │
│ │            │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/1318/2004-hmis-data-and-technical-standards-final-notice/'),                                      │ │
│ │            │   │   │   regulation='Privacy and Security Standards'                                                                                                          │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   RegulationReference(                                                                                                                                     │ │
│ │            │   │   │   name='Coordinated Entry Management and Data Guide',                                                                                                  │ │
│ │            │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/5758/coordinated-entry-management-and-data-guide/'),                                              │ │
│ │            │   │   │   regulation='Guidance on Privacy and Security Standards including allowable uses and disclosu'+3                                                      │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   RegulationReference(                                                                                                                                     │ │
│ │            │   │   │   name='CoC Program Interim Rule',                                                                                                                     │ │
│ │            │   │   │   url=HttpUrl('https://www.hudexchange.info/resource/2033/hearth-coc-program-interim-rule/'),                                                          │ │
│ │            │   │   │   regulation='Procedures and Policies needed to designate and operate an HMIS, ensuring HMIS c'+79                                                     │ │
│ │            │   │   )                                                                                                                                                        │ │
│ │            │   ],                                                                                                                                                           │ │
│ │            │   servers=[ServerConfig(url='http://localhost:3000/api/v1', description='HMIS API Sandbox (Mockoon Reference Implementation)')],                               │ │
│ │            │   schemas=[                                                                                                                                                    │ │
│ │            │   │   APISchema(                                                                                                                                               │ │
│ │            │   │   │   name='clientPrimaryKey',                                                                                                                             │ │
│ │            │   │   │   type='object',                                                                                                                                       │ │
│ │            │   │   │   description='Unique identifier for Client resource',                                                                                                 │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='PersonalID',                                                                                                                           │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description='Unique identifier for the client',                                                                                              │ │
│ │            │   │   │   │   │   max_length=32,                                                                                                                               │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasPersonalID'),                                                                      │ │
│ │            │   │   │   │   │   │   hud_data_element='Universal Data Element',                                                                                               │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   )                                                                                                                                                │ │
│ │            │   │   │   ],                                                                                                                                                   │ │
│ │            │   │   │   semantic=SemanticAnnotation(                                                                                                                         │ │
│ │            │   │   │   │   jsonld_type='hmis:ClientIdentifier',                                                                                                             │ │
│ │            │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#ClientIdentifier'),                                                                           │ │
│ │            │   │   │   │   hud_data_element=None,                                                                                                                           │ │
│ │            │   │   │   │   ontology_cardinality=None,                                                                                                                       │ │
│ │            │   │   │   │   pii=None                                                                                                                                         │ │
│ │            │   │   │   ),                                                                                                                                                   │ │
│ │            │   │   │   hud_csv_table=None                                                                                                                                   │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   APISchema(                                                                                                                                               │ │
│ │            │   │   │   name='clientBase',                                                                                                                                   │ │
│ │            │   │   │   type='object',                                                                                                                                       │ │
│ │            │   │   │   description='Core Client demographic and identifying information',                                                                                   │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='FirstName',                                                                                                                            │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description='First name of the client',                                                                                                      │ │
│ │            │   │   │   │   │   max_length=50,                                                                                                                               │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasFirstName'),                                                                       │ │
│ │            │   │   │   │   │   │   hud_data_element='3.01',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='MiddleName',                                                                                                                           │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description='Middle name of the client',                                                                                                     │ │
│ │            │   │   │   │   │   max_length=50,                                                                                                                               │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasMiddleName'),                                                                      │ │
│ │            │   │   │   │   │   │   hud_data_element='3.01',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='LastName',                                                                                                                             │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description='Last name of the client',                                                                                                       │ │
│ │            │   │   │   │   │   max_length=50,                                                                                                                               │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasLastName'),                                                                        │ │
│ │            │   │   │   │   │   │   hud_data_element='3.01',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='NameSuffix',                                                                                                                           │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description="Suffix of the client's name",                                                                                                   │ │
│ │            │   │   │   │   │   max_length=50,                                                                                                                               │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasNameSuffix'),                                                                      │ │
│ │            │   │   │   │   │   │   hud_data_element='3.01',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='NameDataQuality',                                                                                                                      │ │
│ │            │   │   │   │   │   type='integer',                                                                                                                              │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description='Data quality indicator for name fields',                                                                                        │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasNameDataQuality'),                                                                 │ │
│ │            │   │   │   │   │   │   hud_data_element='3.01',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='SSN',                                                                                                                                  │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description='Social Security Number',                                                                                                        │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern='^[0-9]{9}$',                                                                                                                        │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasSSN'),                                                                             │ │
│ │            │   │   │   │   │   │   hud_data_element='3.02',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=True                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='SSNDataQuality',                                                                                                                       │ │
│ │            │   │   │   │   │   type='integer',                                                                                                                              │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description=None,                                                                                                                            │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasSSNDataQuality'),                                                                  │ │
│ │            │   │   │   │   │   │   hud_data_element='3.02',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='DOB',                                                                                                                                  │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format='date',                                                                                                                               │ │
│ │            │   │   │   │   │   description='Date of birth of the client',                                                                                                   │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDateOfBirth'),                                                                     │ │
│ │            │   │   │   │   │   │   hud_data_element='3.03',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=True                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='DOBDataQuality',                                                                                                                       │ │
│ │            │   │   │   │   │   type='integer',                                                                                                                              │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description=None,                                                                                                                            │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDOBDataQuality'),                                                                  │ │
│ │            │   │   │   │   │   │   hud_data_element='3.03',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='AmIndAKNative',                                                                                                                        │ │
│ │            │   │   │   │   │   type='integer',                                                                                                                              │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description=None,                                                                                                                            │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasAmIndAKNative'),                                                                   │ │
│ │            │   │   │   │   │   │   hud_data_element='3.04',                                                                                                                 │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   ... +30                                                                                                                                          │ │
│ │            │   │   │   ],                                                                                                                                                   │ │
│ │            │   │   │   semantic=SemanticAnnotation(                                                                                                                         │ │
│ │            │   │   │   │   jsonld_type='hmis:Client',                                                                                                                       │ │
│ │            │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#Client'),                                                                                     │ │
│ │            │   │   │   │   hud_data_element=None,                                                                                                                           │ │
│ │            │   │   │   │   ontology_cardinality=None,                                                                                                                       │ │
│ │            │   │   │   │   pii=None                                                                                                                                         │ │
│ │            │   │   │   ),                                                                                                                                                   │ │
│ │            │   │   │   hud_csv_table='Client.csv'                                                                                                                           │ │
│ │            │   │   ),                                                                                                                                                       │ │
│ │            │   │   APISchema(                                                                                                                                               │ │
│ │            │   │   │   name='clientMetaData',                                                                                                                               │ │
│ │            │   │   │   type='object',                                                                                                                                       │ │
│ │            │   │   │   description='Audit and versioning metadata for Client records',                                                                                      │ │
│ │            │   │   │   properties=[                                                                                                                                         │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='DateCreated',                                                                                                                          │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format='date-time',                                                                                                                          │ │
│ │            │   │   │   │   │   description=None,                                                                                                                            │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://purl.org/dc/terms/created'),                                                                                │ │
│ │            │   │   │   │   │   │   hud_data_element=None,                                                                                                                   │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='DateUpdated',                                                                                                                          │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format='date-time',                                                                                                                          │ │
│ │            │   │   │   │   │   description=None,                                                                                                                            │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://purl.org/dc/terms/modified'),                                                                               │ │
│ │            │   │   │   │   │   │   hud_data_element=None,                                                                                                                   │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='UserID',                                                                                                                               │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format=None,                                                                                                                                 │ │
│ │            │   │   │   │   │   description=None,                                                                                                                            │ │
│ │            │   │   │   │   │   max_length=32,                                                                                                                               │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://www.w3.org/ns/prov#wasAttributedTo'),                                                                       │ │
│ │            │   │   │   │   │   │   hud_data_element=None,                                                                                                                   │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   SchemaProperty(                                                                                                                                  │ │
│ │            │   │   │   │   │   name='DateDeleted',                                                                                                                          │ │
│ │            │   │   │   │   │   type='string',                                                                                                                               │ │
│ │            │   │   │   │   │   format='date-time',                                                                                                                          │ │
│ │            │   │   │   │   │   description=None,                                                                                                                            │ │
│ │            │   │   │   │   │   max_length=None,                                                                                                                             │ │
│ │            │   │   │   │   │   pattern=None,                                                                                                                                │ │
│ │            │   │   │   │   │   semantic=SemanticAnnotation(                                                                                                                 │ │
│ │            │   │   │   │   │   │   jsonld_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDateDeleted'),                                                                     │ │
│ │            │   │   │   │   │   │   hud_data_element=None,                                                                                                                   │ │
│ │            │   │   │   │   │   │   ontology_cardinality=None,                                                                                                               │ │
│ │            │   │   │   │   │   │   pii=None                                                                                                                                 │ │
│ │            │   │   │   │   │   ),                                                                                                                                           │ │
│ │            │   │   │   │   │   hud_reference=None,                                                                                                                          │ │
│ │            │   │   │   │   │   conditional=None,                                                                                                                            │ │
│ │            │   │   │   │   │   business_rule=None                                                                                                                           │ │
│ │            │   │   │   │   )                                                                                                                                                │ │
│ │            │   │   │   ],                                                                                                                                                   │ │
│ │            │   │   │   semantic=SemanticAnnotation(                                                                                                                         │ │
│ │            │   │   │   │   jsonld_type='prov:Entity',                                                                                                                       │ │
│ │            │   │   │   │   semantic_uri=HttpUrl('http://www.w3.org/ns/prov#Entity'),                                                                                        │ │
│ │            │   │   │   │   hud_data_element=None,                                                                                                                           │ │
│ │            │   │   │   │   ontology_cardinality=None,                                                                                                                       │ │
│ │            │   │   │   │   pii=None                                                                                                                                         │ │
│ │            │   │   │   ),                                                                                                                                                   │ │
│ │            │   │   │   hud_csv_table=None                                                                                                                                   │ │
│ │            │   │   )                                                                                                                                                        │ │
│ │            │   ],                                                                                                                                                           │ │
│ │            │   operations=[                                                                                                                                                 │ │
│ │            │   │   APIOperation(                                                                                                                                            │ │
│ │            │   │   │   operation_id='clientSearch',                                                                                                                         │ │
│ │            │   │   │   method='post',                                                                                                                                       │ │
│ │            │   │   │   path='/client/search',                                                                                                                               │ │
│ │            │   │   │   summary='Search for clients by identifying information using POST',                                                                                  │ │
│ │            │   │   │   description='Search for client records using various identifying criteria:\n- Name (first, las'+144,                                                 │ │
│ │            │   │   │   effects=[                                                                                                                                            │ │
│ │            │   │   │   │   Effect(                                                                                                                                          │ │
│ │            │   │   │   │   │   name='AuthorizationCheck',                                                                                                                   │ │
│ │            │   │   │   │   │   handler='hmis:checkSearchPermission',                                                                                                        │ │
│ │            │   │   │   │   │   description='Verifies user authorized to search client records',                                                                             │ │
│ │            │   │   │   │   │   signature='userID: ID â†’ AuthResult',                                                                                                       │ │
│ │            │   │   │   │   │   resumable=True,                                                                                                                              │ │
│ │            │   │   │   │   │   required_by=None,                                                                                                                            │ │
│ │            │   │   │   │   │   provenance=None,                                                                                                                             │ │
│ │            │   │   │   │   │   provenance_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   transaction=None                                                                                                                             │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   Effect(                                                                                                                                          │ │
│ │            │   │   │   │   │   name='DatabaseRead',                                                                                                                         │ │
│ │            │   │   │   │   │   handler='hmis:searchClients',                                                                                                                │ │
│ │            │   │   │   │   │   description='Searches clients by identifying criteria',                                                                                      │ │
│ │            │   │   │   │   │   signature='query: SearchQuery â†’ List[Client]',                                                                                             │ │
│ │            │   │   │   │   │   resumable=True,                                                                                                                              │ │
│ │            │   │   │   │   │   required_by=None,                                                                                                                            │ │
│ │            │   │   │   │   │   provenance=None,                                                                                                                             │ │
│ │            │   │   │   │   │   provenance_type=None,                                                                                                                        │ │
│ │            │   │   │   │   │   transaction=None                                                                                                                             │ │
│ │            │   │   │   │   ),                                                                                                                                               │ │
│ │            │   │   │   │   Effect(                                                                                                                                          │ │
│ │            │   │   │   │   │   name='AuditLog',                                                                                                                             │ │
│ │            │   │   │   │   │   handler='hmis:logClientSearch',                                                                                                              │ │
│ │            │   │   │   │   │   description='Records search operation (without exposing PII)',                                                                               │ │
│ │            │   │   │   │   │   signature='event: SearchEvent â†’ Unit',                                                                                                     │ │
│ │            │   │   │   │   │   resumable=False,                                                                                                                             │ │
│ │            │   │   │   │   │   required_by=None,                                                                                                                            │ │
│ │            │   │   │   │   │   provenance=None,                                                                                                                             │ │
│ │            │   │   │   │   │   provenance_type='prov:Search',                                                                                                               │ │
│ │            │   │   │   │   │   transaction=None                                                                                                                             │ │
│ │            │   │   │   │   )                                                                                                                                                │ │
│ │            │   │   │   ],                                                                                                                                                   │ │
│ │            │   │   │   metadata=OperationMetadata(workflow_step=None, required_by_policy=[], data_governance=None, use_cases=[]),                                           │ │
│ │            │   │   │   request_schema=None,                                                                                                                                 │ │
│ │            │   │   │   response_schemas={}                                                                                                                                  │ │
│ │            │   │   )                                                                                                                                                        │ │
│ │            │   ],                                                                                                                                                           │ │
│ │            │   effect_system={                                                                                                                                              │ │
│ │            │   │   'description': 'HMIS API operations are annotated with algebraic effects they may perform.\nEffec'+321,                                                  │ │
│ │            │   │   'paradigm': 'Algebraic effects with handlers',                                                                                                           │ │
│ │            │   │   'phase1-behavior': 'Documentary annotations for tooling',                                                                                                │ │
│ │            │   │   'phase2-behavior': 'Runtime effect handlers with delimited continuations',                                                                               │ │
│ │            │   │   'effect-types': [                                                                                                                                        │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'DatabaseRead',                                                                                                                          │ │
│ │            │   │   │   │   'signature': 'query: Query â†’ Result',                                                                                                          │ │
│ │            │   │   │   │   'description': 'Read operation against HMIS database',                                                                                           │ │
│ │            │   │   │   │   'resumable': True,                                                                                                                               │ │
│ │            │   │   │   │   'handler': 'Database handler provides actual SQL execution'                                                                                      │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'DatabaseWrite',                                                                                                                         │ │
│ │            │   │   │   │   'signature': 'entity: Entity, data: Data â†’ EntityID',                                                                                          │ │
│ │            │   │   │   │   'description': 'Persist operation to HMIS database',                                                                                             │ │
│ │            │   │   │   │   'resumable': False,                                                                                                                              │ │
│ │            │   │   │   │   'handler': 'Database handler with transaction semantics'                                                                                         │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'ConsentCheck',                                                                                                                          │ │
│ │            │   │   │   │   'signature': 'clientID: ID, purpose: Purpose â†’ ConsentStatus',                                                                                 │ │
│ │            │   │   │   │   'description': 'Validate client consent for specific purpose',                                                                                   │ │
│ │            │   │   │   │   'resumable': True,                                                                                                                               │ │
│ │            │   │   │   │   'handler': 'Consent service checks ROI and consent records',                                                                                     │ │
│ │            │   │   │   │   'policy-uri': 'http://hmis.hud.gov/policy#ConsentRequired'                                                                                       │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'ValidationCheck',                                                                                                                       │ │
│ │            │   │   │   │   'signature': 'data: Data, schema: Schema â†’ ValidationResult',                                                                                  │ │
│ │            │   │   │   │   'description': 'Validate data against HUD Data Standards',                                                                                       │ │
│ │            │   │   │   │   'resumable': True,                                                                                                                               │ │
│ │            │   │   │   │   'handler': 'SHACL validator with ontology reasoning'                                                                                             │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'AuditLog',                                                                                                                              │ │
│ │            │   │   │   │   'signature': 'event: Event â†’ Unit',                                                                                                            │ │
│ │            │   │   │   │   'description': 'Record operation in immutable audit trail',                                                                                      │ │
│ │            │   │   │   │   'resumable': False,                                                                                                                              │ │
│ │            │   │   │   │   'handler': 'Append-only audit log service',                                                                                                      │ │
│ │            │   │   │   │   'provenance': 'http://www.w3.org/ns/prov#Activity'                                                                                               │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'AuthorizationCheck',                                                                                                                    │ │
│ │            │   │   │   │   'signature': 'user: UserID, resource: ResourceID, action: Action â†’ Authorized',                                                                │ │
│ │            │   │   │   │   'description': 'Check if user authorized for action on resource',                                                                                │ │
│ │            │   │   │   │   'resumable': True,                                                                                                                               │ │
│ │            │   │   │   │   'handler': 'Policy engine evaluates RBAC/ABAC rules'                                                                                             │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'ExternalAPI',                                                                                                                           │ │
│ │            │   │   │   │   'signature': 'endpoint: URL, params: Params â†’ Response',                                                                                       │ │
│ │            │   │   │   │   'description': 'Call external service (e.g., SSN verification)',                                                                                 │ │
│ │            │   │   │   │   'resumable': True,                                                                                                                               │ │
│ │            │   │   │   │   'handler': 'HTTP client with retry/timeout semantics'                                                                                            │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'ValidationError',                                                                                                                       │ │
│ │            │   │   │   │   'signature': 'error: ErrorDetail â†’ Never',                                                                                                     │ │
│ │            │   │   │   │   'description': 'Abort computation with validation error',                                                                                        │ │
│ │            │   │   │   │   'resumable': False,                                                                                                                              │ │
│ │            │   │   │   │   'handler': 'Error response generator'                                                                                                            │ │
│ │            │   │   │   },                                                                                                                                                   │ │
│ │            │   │   │   {                                                                                                                                                    │ │
│ │            │   │   │   │   'name': 'BusinessRuleError',                                                                                                                     │ │
│ │            │   │   │   │   'signature': 'rule: Rule, violation: Detail â†’ Never',                                                                                          │ │
│ │            │   │   │   │   'description': 'Abort computation due to business rule violation',                                                                               │ │
│ │            │   │   │   │   'resumable': False,                                                                                                                              │ │
│ │            │   │   │   │   'handler': 'Error response with policy traceability'                                                                                             │ │
│ │            │   │   │   }                                                                                                                                                    │ │
│ │            │   │   ],                                                                                                                                                       │ │
│ │            │   │   'effect-patterns': {                                                                                                                                     │ │
│ │            │   │   │   'description': 'Effects compose naturally - an operation that calls sub-operations\ninherits thei'+62,                                               │ │
│ │            │   │   │   'examples': [                                                                                                                                        │ │
│ │            │   │   │   │   {                                                                                                                                                │ │
│ │            │   │   │   │   │   'name': 'Client creation workflow',                                                                                                          │ │
│ │            │   │   │   │   │   'effects': ['ConsentCheck', 'ValidationCheck', 'DatabaseWrite', 'AuditLog'],                                                                 │ │
│ │            │   │   │   │   │   'composition': 'Sequential effect execution with early termination on error'                                                                 │ │
│ │            │   │   │   │   },                                                                                                                                               │ │
│ │            │   │   │   │   {                                                                                                                                                │ │
│ │            │   │   │   │   │   'name': 'Client search with authorization',                                                                                                  │ │
│ │            │   │   │   │   │   'effects': ['AuthorizationCheck', 'DatabaseRead', 'AuditLog'],                                                                               │ │
│ │            │   │   │   │   │   'composition': 'Authorization gates database access'                                                                                         │ │
│ │            │   │   │   │   },                                                                                                                                               │ │
│ │            │   │   │   │   {                                                                                                                                                │ │
│ │            │   │   │   │   │   'name': 'Cross-organization data sharing',                                                                                                   │ │
│ │            │   │   │   │   │   'effects': ['AuthorizationCheck', 'ConsentCheck', 'DatabaseRead', 'AuditLog', 'ExternalAPI'],                                                │ │
│ │            │   │   │   │   │   'composition': 'Multiple authorization layers before data access'                                                                            │ │
│ │            │   │   │   │   }                                                                                                                                                │ │
│ │            │   │   │   ]                                                                                                                                                    │ │
│ │            │   │   },                                                                                                                                                       │ │
│ │            │   │   'toolchain-integration': {                                                                                                                               │ │
│ │            │   │   │   'parser': 'Extract x-effects from operations â†’ Effect AST',                                                                                        │ │
│ │            │   │   │   'generator': 'Generate effect handler interfaces from Effect AST',                                                                                   │ │
│ │            │   │   │   'validator': 'Ensure all effects have registered handlers',                                                                                          │ │
│ │            │   │   │   'test-harness': 'Generate mock effect handlers for unit tests',                                                                                      │ │
│ │            │   │   │   'example-output': '# Generated Python effect handler interfaces:\n\nclass DatabaseWriteHandler(Protoc'+292                                           │ │
│ │            │   │   },                                                                                                                                                       │ │
│ │            │   │   '/client': {                                                                                                                                             │ │
│ │            │   │   │   'post': {                                                                                                                                            │ │
│ │            │   │   │   │   'operationId': 'postClient',                                                                                                                     │ │
│ │            │   │   │   │   'summary': 'Create a new client record',                                                                                                         │ │
│ │            │   │   │   │   'description': 'Creates a new client record in the HMIS.\n\nValidates data quality requirements pe'+96,                                          │ │
│ │            │   │   │   │   'x-workflow-step': 'client-intake',                                                                                                              │ │
│ │            │   │   │   │   'x-required-by-policy': [                                                                                                                        │ │
│ │            │   │   │   │   │   '2004 HMIS Data Standards Section 5.2.1: Client data must be collected',                                                                     │ │
│ │            │   │   │   │   │   'CoC Program Interim Rule: HMIS participation required for HUD-funded projects'                                                              │ │
│ │            │   │   │   │   ],                                                                                                                                               │ │
│ │            │   │   │   │   'x-data-governance': {                                                                                                                           │ │
│ │            │   │   │   │   │   'retention': '7 years (per 2004 Technical Standards Section 5.2.1)',                                                                         │ │
│ │            │   │   │   │   │   'consent-required': True,                                                                                                                    │ │
│ │            │   │   │   │   │   'allowable-disclosure': 'CoC-level aggregated reporting only'                                                                                │ │
│ │            │   │   │   │   },                                                                                                                                               │ │
│ │            │   │   │   │   'x-effects': [                                                                                                                                   │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'effect': 'ConsentCheck',                                                                                                                │ │
│ │            │   │   │   │   │   │   'handler': 'hmis:validateConsent',                                                                                                       │ │
│ │            │   │   │   │   │   │   'description': 'Verifies client consent for data collection',                                                                            │ │
│ │            │   │   │   │   │   │   'signature': 'clientID: ID, purpose: Purpose â†’ ConsentStatus',                                                                         │ │
│ │            │   │   │   │   │   │   'resumable': True,                                                                                                                       │ │
│ │            │   │   │   │   │   │   'required-by': '2004 HMIS Standards Section 4.2'                                                                                         │ │
│ │            │   │   │   │   │   },                                                                                                                                           │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'effect': 'ValidationCheck',                                                                                                             │ │
│ │            │   │   │   │   │   │   'handler': 'hmis:validateHUDStandards',                                                                                                  │ │
│ │            │   │   │   │   │   │   'description': 'Validates client data against HUD Data Standards',                                                                       │ │
│ │            │   │   │   │   │   │   'signature': 'data: ClientData, schema: Schema â†’ ValidationResult',                                                                    │ │
│ │            │   │   │   │   │   │   'resumable': True,                                                                                                                       │ │
│ │            │   │   │   │   │   │   'ontology-validation': 'Uses SHACL shapes from ontology'                                                                                 │ │
│ │            │   │   │   │   │   },                                                                                                                                           │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'effect': 'DatabaseWrite',                                                                                                               │ │
│ │            │   │   │   │   │   │   'handler': 'hmis:persistClient',                                                                                                         │ │
│ │            │   │   │   │   │   │   'description': 'Persists client record to HMIS database',                                                                                │ │
│ │            │   │   │   │   │   │   'signature': 'entity: Client, data: Data â†’ PersonalID',                                                                                │ │
│ │            │   │   │   │   │   │   'resumable': False,                                                                                                                      │ │
│ │            │   │   │   │   │   │   'transaction': True                                                                                                                      │ │
│ │            │   │   │   │   │   },                                                                                                                                           │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'effect': 'AuditLog',                                                                                                                    │ │
│ │            │   │   │   │   │   │   'handler': 'hmis:logClientCreation',                                                                                                     │ │
│ │            │   │   │   │   │   │   'description': 'Records client creation in immutable audit trail',                                                                       │ │
│ │            │   │   │   │   │   │   'signature': 'event: ClientCreatedEvent â†’ Unit',                                                                                       │ │
│ │            │   │   │   │   │   │   'resumable': False,                                                                                                                      │ │
│ │            │   │   │   │   │   │   'provenance': 'http://www.w3.org/ns/prov#Activity',                                                                                      │ │
│ │            │   │   │   │   │   │   'provenance-type': 'prov:Create'                                                                                                         │ │
│ │            │   │   │   │   │   }                                                                                                                                            │ │
│ │            │   │   │   │   ],                                                                                                                                               │ │
│ │            │   │   │   │   'requestBody': {                                                                                                                                 │ │
│ │            │   │   │   │   │   'content': {                                                                                                                                 │ │
│ │            │   │   │   │   │   │   'application/json': {                                                                                                                    │ │
│ │            │   │   │   │   │   │   │   'schema': {'$ref': '#/components/schemas/clientBase'},                                                                               │ │
│ │            │   │   │   │   │   │   │   'x-validation-rules': [                                                                                                              │ │
│ │            │   │   │   │   │   │   │   │   {'rule': 'At least one name field (FirstName or LastName) required', 'severity': 'error'},                                       │ │
│ │            │   │   │   │   │   │   │   │   {'rule': 'SSN must be valid if SSNDataQuality = Full SSN reported', 'severity': 'error'},                                        │ │
│ │            │   │   │   │   │   │   │   │   {'rule': 'Gender fields follow HUD multi-select logic', 'severity': 'warning'}                                                   │ │
│ │            │   │   │   │   │   │   │   ]                                                                                                                                    │ │
│ │            │   │   │   │   │   │   }                                                                                                                                        │ │
│ │            │   │   │   │   │   }                                                                                                                                            │ │
│ │            │   │   │   │   },                                                                                                                                               │ │
│ │            │   │   │   │   'responses': {                                                                                                                                   │ │
│ │            │   │   │   │   │   '200': {                                                                                                                                     │ │
│ │            │   │   │   │   │   │   'description': 'Client record created successfully',                                                                                     │ │
│ │            │   │   │   │   │   │   'content': {                                                                                                                             │ │
│ │            │   │   │   │   │   │   │   'application/json': {                                                                                                                │ │
│ │            │   │   │   │   │   │   │   │   'schema': {                                                                                                                      │ │
│ │            │   │   │   │   │   │   │   │   │   'allOf': [                                                                                                                   │ │
│ │            │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientPrimaryKey'},                                                                       │ │
│ │            │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientBase'},                                                                             │ │
│ │            │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientMetaData'}                                                                          │ │
│ │            │   │   │   │   │   │   │   │   │   ]                                                                                                                            │ │
│ │            │   │   │   │   │   │   │   │   },                                                                                                                               │ │
│ │            │   │   │   │   │   │   │   │   'x-jsonld-frame': {                                                                                                              │ │
│ │            │   │   │   │   │   │   │   │   │   '@context': 'https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/'+60,                           │ │
│ │            │   │   │   │   │   │   │   │   │   '@type': 'hmis:Client',                                                                                                      │ │
│ │            │   │   │   │   │   │   │   │   │   '@id': 'http://hmis.example.org/client/{PersonalID}'                                                                         │ │
│ │            │   │   │   │   │   │   │   │   }                                                                                                                                │ │
│ │            │   │   │   │   │   │   │   }                                                                                                                                    │ │
│ │            │   │   │   │   │   │   }                                                                                                                                        │ │
│ │            │   │   │   │   │   },                                                                                                                                           │ │
│ │            │   │   │   │   │   '400': {                                                                                                                                     │ │
│ │            │   │   │   │   │   │   'description': 'Invalid input provided',                                                                                                 │ │
│ │            │   │   │   │   │   │   'content': {                                                                                                                             │ │
│ │            │   │   │   │   │   │   │   'application/json': {                                                                                                                │ │
│ │            │   │   │   │   │   │   │   │   'schema': {                                                                                                                      │ │
│ │            │   │   │   │   │   │   │   │   │   'oneOf': [                                                                                                                   │ │
│ │            │   │   │   │   │   │   │   │   │   │   {                                                                                                                        │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'type': 'object',                                                                                                    │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'description': 'Data type validation error',                                                                         │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'x-jsonld-type': 'hmis:ValidationError',                                                                             │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'properties': {                                                                                                      │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   'missingInformationIncorrectDatatype': {                                                                         │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   │   'type': 'string',                                                                                            │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   │   'description': 'Invalid input provided - incorrect data type or missing required field',                     │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   │   'x-semantic-uri': 'http://hmis.hud.gov/errors#ValidationError'                                               │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   }                                                                                                                │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   }                                                                                                                    │ │
│ │            │   │   │   │   │   │   │   │   │   │   },                                                                                                                       │ │
│ │            │   │   │   │   │   │   │   │   │   │   {                                                                                                                        │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'type': 'object',                                                                                                    │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'description': 'Business rule validation error',                                                                     │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'x-jsonld-type': 'hmis:BusinessRuleError',                                                                           │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   'properties': {                                                                                                      │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   'invalidInputProvided': {                                                                                        │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   │   'type': 'string',                                                                                            │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   │   'description': 'Business rule violation (e.g., conditional field requirements)',                             │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   │   'example': 'VeteranStatus = Yes requires YearEnteredService',                                                │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   │   'x-semantic-uri': 'http://hmis.hud.gov/errors#BusinessRuleError'                                             │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   │   }                                                                                                                │ │
│ │            │   │   │   │   │   │   │   │   │   │   │   }                                                                                                                    │ │
│ │            │   │   │   │   │   │   │   │   │   │   }                                                                                                                        │ │
│ │            │   │   │   │   │   │   │   │   │   ]                                                                                                                            │ │
│ │            │   │   │   │   │   │   │   │   },                                                                                                                               │ │
│ │            │   │   │   │   │   │   │   │   'x-error-classification': {                                                                                                      │ │
│ │            │   │   │   │   │   │   │   │   │   'validation-error': 'Data fails HUD Data Standards validation',                                                              │ │
│ │            │   │   │   │   │   │   │   │   │   'business-rule-error': 'Violates HUD program logic (e.g., conditional requirements)'                                         │ │
│ │            │   │   │   │   │   │   │   │   }                                                                                                                                │ │
│ │            │   │   │   │   │   │   │   }                                                                                                                                    │ │
│ │            │   │   │   │   │   │   }                                                                                                                                        │ │
│ │            │   │   │   │   │   }                                                                                                                                            │ │
│ │            │   │   │   │   }                                                                                                                                                │ │
│ │            │   │   │   }                                                                                                                                                    │ │
│ │            │   │   },                                                                                                                                                       │ │
│ │            │   │   '/clientinproject': {                                                                                                                                    │ │
│ │            │   │   │   'get': {                                                                                                                                             │ │
│ │            │   │   │   │   'operationId': 'clientListByProjectID',                                                                                                          │ │
│ │            │   │   │   │   'summary': 'Get list of clients by project using ProjectID',                                                                                     │ │
│ │            │   │   │   │   'description': 'Returns all clients enrolled in specified project(s).\n\nSupports multi-project qu'+104,                                         │ │
│ │            │   │   │   │   'x-workflow-step': 'project-reporting',                                                                                                          │ │
│ │            │   │   │   │   'x-required-by-policy': ['CoC Program Interim Rule: Project-level data reporting requirements'],                                                 │ │
│ │            │   │   │   │   'x-use-cases': ['Annual Performance Report (APR) data extraction', 'CAPER report generation', 'CoC competition application data'],               │ │
│ │            │   │   │   │   'x-effects': [                                                                                                                                   │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'effect': 'AuthorizationCheck',                                                                                                          │ │
│ │            │   │   │   │   │   │   'handler': 'hmis:checkProjectAccess',                                                                                                    │ │
│ │            │   │   │   │   │   │   'description': 'Verifies user has read access to requested projects',                                                                    │ │
│ │            │   │   │   │   │   │   'signature': 'userID: ID, projectIDs: List[ID] â†’ AuthResult',                                                                          │ │
│ │            │   │   │   │   │   │   'resumable': True                                                                                                                        │ │
│ │            │   │   │   │   │   },                                                                                                                                           │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'effect': 'DatabaseRead',                                                                                                                │ │
│ │            │   │   │   │   │   │   'handler': 'hmis:queryClientsByProject',                                                                                                 │ │
│ │            │   │   │   │   │   │   'description': 'Queries clients enrolled in specified projects',                                                                         │ │
│ │            │   │   │   │   │   │   'signature': 'projectIDs: List[ID] â†’ List[Client]',                                                                                    │ │
│ │            │   │   │   │   │   │   'resumable': True,                                                                                                                       │ │
│ │            │   │   │   │   │   │   'query-complexity': 'O(n) where n = number of enrollments'                                                                               │ │
│ │            │   │   │   │   │   },                                                                                                                                           │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'effect': 'AuditLog',                                                                                                                    │ │
│ │            │   │   │   │   │   │   'handler': 'hmis:logProjectQuery',                                                                                                       │ │
│ │            │   │   │   │   │   │   'description': 'Records project data access for compliance',                                                                             │ │
│ │            │   │   │   │   │   │   'signature': 'event: ProjectQueryEvent â†’ Unit',                                                                                        │ │
│ │            │   │   │   │   │   │   'resumable': False,                                                                                                                      │ │
│ │            │   │   │   │   │   │   'provenance-type': 'prov:Read'                                                                                                           │ │
│ │            │   │   │   │   │   }                                                                                                                                            │ │
│ │            │   │   │   │   ],                                                                                                                                               │ │
│ │            │   │   │   │   'parameters': [                                                                                                                                  │ │
│ │            │   │   │   │   │   {                                                                                                                                            │ │
│ │            │   │   │   │   │   │   'name': 'ProjectID',                                                                                                                     │ │
│ │            │   │   │   │   │   │   'in': 'query',                                                                                                                           │ │
│ │            │   │   │   │   │   │   'required': False,                                                                                                                       │ │
│ │            │   │   │   │   │   │   'description': 'One or more project IDs to filter clients',                                                                              │ │
│ │            │   │   │   │   │   │   'style': 'form',                                                                                                                         │ │
│ │            │   │   │   │   │   │   'explode': True,                                                                                                                         │ │
│ │            │   │   │   │   │   │   'schema': {                                                                                                                              │ │
│ │            │   │   │   │   │   │   │   'type': 'array',                                                                                                                     │ │
│ │            │   │   │   │   │   │   │   'items': {'type': 'string', 'maxLength': 32, 'x-semantic-uri': 'http://hmis.hud.gov/ontology#hasProjectID'}                          │ │
│ │            │   │   │   │   │   │   }                                                                                                                                        │ │
│ │            │   │   │   │   │   }                                                                                                                                            │ │
│ │            │   │   │   │   ],                                                                                                                                               │ │
│ │            │   │   │   │   'responses': {                                                                                                                                   │ │
│ │            │   │   │   │   │   '200': {                                                                                                                                     │ │
│ │            │   │   │   │   │   │   'description': 'A list of clients and any unmatched project IDs',                                                                        │ │
│ │            │   │   │   │   │   │   'content': {'application/json': {'schema': {'type': 'object', 'x-jsonld-type': 'hmis:ProjectClientListResponse', 'properties': None}}}   │ │
│ │            │   │   │   │   │   }                                                                                                                                            │ │
│ │            │   │   │   │   }                                                                                                                                                │ │
│ │            │   │   │   }                                                                                                                                                    │ │
│ │            │   │   }                                                                                                                                                        │ │
│ │            │   }                                                                                                                                                            │ │
│ │            )                                                                                                                                                                │ │
│ ╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│                                                                                                                                                                                 │
│ C:\Users\gtuio\AppData\Local\Python\pythoncore-3.14-64\Lib\site-packages\jinja2\environment.py:1016 in get_template                                                             │
│                                                                                                                                                                                 │
│   1013 │   │   if parent is not None:                                                           ╭──────────────────────────────── locals ─────────────────────────────────╮     │
│   1014 │   │   │   name = self.join_path(name, parent)                                          │ globals = None                                                          │     │
│   1015 │   │                                                                                    │    name = 'jsonld_context.j2'                                           │     │
│ ❱ 1016 │   │   return self._load_template(name, globals)                                        │  parent = None                                                          │     │
│   1017 │                                                                                        │    self = <jinja2.environment.Environment object at 0x000001B7DC82C1A0> │     │
│   1018 │   @internalcode                                                                        ╰─────────────────────────────────────────────────────────────────────────╯     │
│   1019 │   def select_template(                                                                                                                                                 │
│                                                                                                                                                                                 │
│ C:\Users\gtuio\AppData\Local\Python\pythoncore-3.14-64\Lib\site-packages\jinja2\environment.py:975 in _load_template                                                            │
│                                                                                                                                                                                 │
│    972 │   │   │   │                                                                                                                                                            │
│    973 │   │   │   │   return template                                                                                                                                          │
│    974 │   │                                                                                                                                                                    │
│ ❱  975 │   │   template = self.loader.load(self, name, self.make_globals(globals))                                                                                              │
│    976 │   │                                                                                                                                                                    │
│    977 │   │   if self.cache is not None:                                                                                                                                       │
│    978 │   │   │   self.cache[cache_key] = template                                                                                                                             │
│                                                                                                                                                                                 │
│ ╭──────────────────────────────────────────────────────────── locals ────────────────────────────────────────────────────────────╮                                              │
│ │ cache_key = (<weakref at 0x000001B7DC7E60C0; to 'jinja2.loaders.FileSystemLoader' at 0x000001B7DC82C050>, 'jsonld_context.j2') │                                              │
│ │   globals = None                                                                                                               │                                              │
│ │      name = 'jsonld_context.j2'                                                                                                │                                              │
│ │      self = <jinja2.environment.Environment object at 0x000001B7DC82C1A0>                                                      │                                              │
│ │  template = None                                                                                                               │                                              │
│ ╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯                                              │
│                                                                                                                                                                                 │
│ C:\Users\gtuio\AppData\Local\Python\pythoncore-3.14-64\Lib\site-packages\jinja2\loaders.py:126 in load                                                                          │
│                                                                                                                                                                                 │
│   123 │   │                                                                                                                                                                     │
│   124 │   │   # first we try to get the source for this template together                                                                                                       │
│   125 │   │   # with the filename and the uptodate function.                                                                                                                    │
│ ❱ 126 │   │   source, filename, uptodate = self.get_source(environment, name)                                                                                                   │
│   127 │   │                                                                                                                                                                     │
│   128 │   │   # try to load the code from the bytecode cache if there is a                                                                                                      │
│   129 │   │   # bytecode cache configured.                                                                                                                                      │
│                                                                                                                                                                                 │
│ ╭────────────────────────────────────────────────────────────────────────────────── locals ───────────────────────────────────────────────────────────────────────────────────╮ │
│ │        code = None                                                                                                                                                          │ │
│ │ environment = <jinja2.environment.Environment object at 0x000001B7DC82C1A0>                                                                                                 │ │
│ │     globals = ChainMap({}, {'range': <class 'range'>, 'dict': <class 'dict'>, 'lipsum': <function generate_lorem_ipsum at 0x000001B7DBDEF5E0>, 'cycler': <class             │ │
│ │               'jinja2.utils.Cycler'>, 'joiner': <class 'jinja2.utils.Joiner'>, 'namespace': <class 'jinja2.utils.Namespace'>})                                              │ │
│ │        name = 'jsonld_context.j2'                                                                                                                                           │ │
│ │        self = <jinja2.loaders.FileSystemLoader object at 0x000001B7DC82C050>                                                                                                │ │
│ ╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│                                                                                                                                                                                 │
│ C:\Users\gtuio\AppData\Local\Python\pythoncore-3.14-64\Lib\site-packages\jinja2\loaders.py:209 in get_source                                                                    │
│                                                                                                                                                                                 │
│   206 │   │   else:                                                                                                                                                             │
│   207 │   │   │   plural = "path" if len(self.searchpath) == 1 else "paths"                                                                                                     │
│   208 │   │   │   paths_str = ", ".join(repr(p) for p in self.searchpath)                                                                                                       │
│ ❱ 209 │   │   │   raise TemplateNotFound(                                                                                                                                       │
│   210 │   │   │   │   template,                                                                                                                                                 │
│   211 │   │   │   │   f"{template!r} not found in search {plural}: {paths_str}",                                                                                                │
│   212 │   │   │   )                                                                                                                                                             │
│                                                                                                                                                                                 │
│ ╭──────────────────────────────────────────────────── locals ─────────────────────────────────────────────────────╮                                                             │
│ │ environment = <jinja2.environment.Environment object at 0x000001B7DC82C1A0>                                     │                                                             │
│ │    filename = 'C:\\Users\\gtuio\\OneDrive\\Documents\\GitHub\\002.GT.Data.Exchange.and.Interoperabili'+43       │                                                             │
│ │   paths_str = "'C:\\\\Users\\\\gtuio\\\\OneDrive\\\\Documents\\\\GitHub\\\\002.GT.Data.Exchange.and.Interop"+35 │                                                             │
│ │      pieces = ['jsonld_context.j2']                                                                             │                                                             │
│ │      plural = 'path'                                                                                            │                                                             │
│ │  searchpath = 'C:\\Users\\gtuio\\OneDrive\\Documents\\GitHub\\002.GT.Data.Exchange.and.Interoperabili'+25       │                                                             │
│ │        self = <jinja2.loaders.FileSystemLoader object at 0x000001B7DC82C050>                                    │                                                             │
│ │    template = 'jsonld_context.j2'                                                                               │                                                             │
│ ╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯                                                             │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
TemplateNotFound: 'jsonld_context.j2' not found in search path: 'C:\\Users\\gtuio\\OneDrive\\Documents\\GitHub\\002.GT.Data.Exchange.and.Interoperability\\hmis-codegen\\templates'

C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen>
```

# PAST/RESOLVED
*** #########
```
Microsoft Windows [Version 10.0.26100.6899]
(c) Microsoft Corporation. All rights reserved.

C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability>cd C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen

C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen>python -m hmis_codegen.cli generate --ontology "C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\FY26HMIS_JSON-LD_v1.jsonld" --spec "C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis_api_ld_0.4.yaml"
HMIS Code Generator
Ontology:
C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\FY26HMIS_JSON-LD_v1.json
ld
Spec: C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis_api_ld_0.4.yaml

✓ Parsed 45 classes, 401 properties
╭───────────────────────────────────────── Traceback (most recent call last) ──────────────────────────────────────────╮
│ C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\src\hmis_codegen\cli │
│ .py:83 in generate                                                                                                   │
│                                                                                                                      │
│    80 │                                                                                                              │
│    81 │   with console.status("[bold green]Parsing YAML-LD specification..."):                                       │
│    82 │   │   yaml_parser = YAMLLDParser(spec)                                                                       │
│ ❱  83 │   │   spec_model = yaml_parser.parse()                                                                       │
│    84 │   │   console.print(f"✓ Parsed {len(spec_model.schemas)} schemas, "                                          │
│    85 │   │   │   │   │    f"{len(spec_model.operations)} operations")                                               │
│    86                                                                                                                │
│                                                                                                                      │
│ ╭───────────────────────────────────────────────────── locals ─────────────────────────────────────────────────────╮ │
│ │          format = 'all'                                                                                          │ │
│ │        ontology = WindowsPath('C:/Users/gtuio/OneDrive/Documents/GitHub/002.GT.Data.Exchange.and.Interoperabili… │ │
│ │  ontology_model = OntologyModel(                                                                                 │ │
│ │                   │   classes=[                                                                                  │ │
│ │                   │   │   OWLClass(uri='genid1717', label='genid1717', description=None, properties=[]),         │ │
│ │                   │   │   OWLClass(uri='genid2003', label='genid2003', description=None, properties=[]),         │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#Affiliation',                                                │ │
│ │                   │   │   │   label='Affiliation',                                                               │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=['urn:hud:hmis:owl#AffiliationID', 'urn:hud:hmis:owl#ResProjectID']     │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#Assessment',                                                 │ │
│ │                   │   │   │   label='Assessment',                                                                │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=[                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentDate',                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentID',                                               │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentLevel',                                            │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentLocation',                                         │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentType',                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#PrioritizationStatus',                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#hasAssessmentQuestion',                                      │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#hasAssessmentResult'                                         │ │
│ │                   │   │   │   ]                                                                                  │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#AssessmentQuestionClass',                                    │ │
│ │                   │   │   │   label='AssessmentQuestionClass',                                                   │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=[                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentAnswer',                                           │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestion',                                         │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionGroup',                                    │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionID',                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentQuestionOrder'                                     │ │
│ │                   │   │   │   ]                                                                                  │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#AssessmentResultClass',                                      │ │
│ │                   │   │   │   label='AssessmentResultClass',                                                     │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=[                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentResult',                                           │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentResultID',                                         │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AssessmentResultType'                                        │ │
│ │                   │   │   │   ]                                                                                  │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#CEParticipation',                                            │ │
│ │                   │   │   │   label='CEParticipation',                                                           │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=[                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AccessPoint',                                                │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CEParticipationID',                                          │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CEParticipationStatusEndDate',                               │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CEParticipationStatusStartDate',                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#CrisisAssessment',                                           │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DirectServices',                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#HousingAssessment',                                          │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#PreventionAssessment',                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#ReceivesReferrals'                                           │ │
│ │                   │   │   │   ]                                                                                  │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#Client',                                                     │ │
│ │                   │   │   │   label='Client',                                                                    │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=[                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AdditionalRaceEthnicity',                                    │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AmIndAKNative',                                              │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#Asian',                                                      │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#BlackAfAmerican',                                            │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DOB',                                                        │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DOBDataQuality',                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#FirstName',                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#HispanicLatinao',                                            │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#LastName',                                                   │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#MidEastNAfrican',                                            │ │
│ │                   │   │   │   │   ... +13                                                                        │ │
│ │                   │   │   │   ]                                                                                  │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#ClientVeteranInfo',                                          │ │
│ │                   │   │   │   label='ClientVeteranInfo',                                                         │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=[                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#AfghanistanOEF',                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DesertStorm',                                                │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#DischargeStatus',                                            │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#IraqOIF',                                                    │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#IraqOND',                                                    │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#KoreanWar',                                                  │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#MilitaryBranch',                                             │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#OtherTheater',                                               │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#VietnamWar',                                                 │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#WorldWarII',                                                 │ │
│ │                   │   │   │   │   ... +2                                                                         │ │
│ │                   │   │   │   ]                                                                                  │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLClass(                                                                              │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#ConnectionWithSOAR',                                         │ │
│ │                   │   │   │   label='ConnectionWithSOAR',                                                        │ │
│ │                   │   │   │   description=None,                                                                  │ │
│ │                   │   │   │   properties=[                                                                       │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#ConnectionWithSOAR',                                         │ │
│ │                   │   │   │   │   'urn:hud:hmis:owl#IncomeBenefitsID'                                            │ │
│ │                   │   │   │   ]                                                                                  │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   ... +35                                                                                │ │
│ │                   │   ],                                                                                         │ │
│ │                   │   properties=[                                                                               │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAffiliation',                                             │ │
│ │                   │   │   │   label='hasAffiliation',                                                            │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Project',                                                 │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#Affiliation',                                              │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAssessment',                                              │ │
│ │                   │   │   │   label='hasAssessment',                                                             │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                              │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#Assessment',                                               │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAssessmentQuestion',                                      │ │
│ │                   │   │   │   label='hasAssessmentQuestion',                                                     │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Assessment',                                              │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#AssessmentQuestionClass',                                  │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasAssessmentResult',                                        │ │
│ │                   │   │   │   label='hasAssessmentResult',                                                       │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Assessment',                                              │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#AssessmentResultClass',                                    │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasCEParticipation',                                         │ │
│ │                   │   │   │   label='hasCEParticipation',                                                        │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Project',                                                 │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#CEParticipation',                                          │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasClientEnrollment',                                        │ │
│ │                   │   │   │   label='hasClientEnrollment',                                                       │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Client',                                                  │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#Enrollment',                                               │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasClientVeteranInfo',                                       │ │
│ │                   │   │   │   label='hasClientVeteranInfo',                                                      │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Client',                                                  │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#ClientVeteranInfo',                                        │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasConnectionWithSOAR',                                      │ │
│ │                   │   │   │   label='hasConnectionWithSOAR',                                                     │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                              │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#ConnectionWithSOAR',                                       │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasCurrentLivingSituation',                                  │ │
│ │                   │   │   │   label='hasCurrentLivingSituation',                                                 │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                              │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#CurrentLivingSituationClass',                              │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   OWLProperty(                                                                           │ │
│ │                   │   │   │   uri='urn:hud:hmis:owl#hasDateOfEngagement',                                        │ │
│ │                   │   │   │   label='hasDateOfEngagement',                                                       │ │
│ │                   │   │   │   domain='urn:hud:hmis:owl#Enrollment',                                              │ │
│ │                   │   │   │   range='urn:hud:hmis:owl#DateOfEngagementClass',                                    │ │
│ │                   │   │   │   cardinality=None                                                                   │ │
│ │                   │   │   ),                                                                                     │ │
│ │                   │   │   ... +391                                                                               │ │
│ │                   │   ],                                                                                         │ │
│ │                   │   namespace='http://hmis.hud.gov/ontology#'                                                  │ │
│ │                   )                                                                                              │ │
│ │ ontology_parser = <hmis_codegen.parser.OntologyParser object at 0x0000029B0D8E3B60>                              │ │
│ │      output_dir = WindowsPath('generated')                                                                       │ │
│ │            spec = WindowsPath('C:/Users/gtuio/OneDrive/Documents/GitHub/002.GT.Data.Exchange.and.Interoperabili… │ │
│ │     yaml_parser = <hmis_codegen.parser.YAMLLDParser object at 0x0000029B0D8E3380>                                │ │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│                                                                                                                      │
│ C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen\src\hmis_codegen\par │
│ ser.py:110 in parse                                                                                                  │
│                                                                                                                      │
│   107 │   │   """Parse YAML-LD into structured OpenAPISpec"""                                                        │
│   108 │   │   info = self.data['info']                                                                               │
│   109 │   │                                                                                                          │
│ ❱ 110 │   │   spec = OpenAPISpec(                                                                                    │
│   111 │   │   │   title=info['title'],                                                                               │
│   112 │   │   │   version=info['version'],                                                                           │
│   113 │   │   │   description=info['description'],                                                                   │
│                                                                                                                      │
│ ╭───────────────────────────────────────────────────── locals ─────────────────────────────────────────────────────╮ │
│ │ info = {                                                                                                         │ │
│ │        │   'title': 'HMIS API Sandbox Specifications',                                                           │ │
│ │        │   'version': '1.0.0',                                                                                   │ │
│ │        │   'description': 'HMIS API Sandbox request, response, and error responses for each scenario in          │ │
│ │        the'+323,                                                                                                 │ │
│ │        │   'x-jsonld-context':                                                                                   │ │
│ │        'https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/'+60,                    │ │
│ │        │   'x-HMIS-Regulation': [                                                                                │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': 'FY 2026 HMIS Data Standards',                                                        │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/3824/hmis-data-dictionary/',                    │ │
│ │        │   │   │   'regulation': 'Data collection and implementation guidance'                                   │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': '2004 Data and Technical Standards Notice',                                           │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/1318/2004-hmis-data-and-technical-standard'+15, │ │
│ │        │   │   │   'regulation': 'Privacy and Security Standards'                                                │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': 'Coordinated Entry Management and Data Guide',                                        │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/5758/coordinated-entry-management-and-data'+7,  │ │
│ │        │   │   │   'regulation': 'Guidance on Privacy and Security Standards including allowable uses and        │ │
│ │        disclosu'+3                                                                                               │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': 'CoC Program Interim Rule',                                                           │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/2033/hearth-coc-program-interim-rule/',         │ │
│ │        │   │   │   'regulation': 'Procedures and Policies needed to designate and operate an HMIS, ensuring HMIS │ │
│ │        c'+79                                                                                                     │ │
│ │        │   │   }                                                                                                 │ │
│ │        │   ],                                                                                                    │ │
│ │        │   'x-semantic-web-integration': {                                                                       │ │
│ │        │   │   'description': 'This API specification uses YAML-LD (YAML + Linked Data) extensions to            │ │
│ │        maintain\n'+515,                                                                                          │ │
│ │        │   │   'ontology-source': 'https://github.com/HUD-Data-Lab/HMIS-Logic-Model',                            │ │
│ │        │   │   'python-toolchain': 'https://github.com/HUD-Data-Lab/hmis-codegen',                               │ │
│ │        │   │   'format-inspiration': 'JSON-LD-Star, Jelly-RDF (simplified for OpenAPI)'                          │ │
│ │        │   },                                                                                                    │ │
│ │        │   'x-data-governance': {                                                                                │ │
│ │        │   │   'retention-period': '7 years (per 2004 Technical Standards Section 5.2.1)',                       │ │
│ │        │   │   'privacy-framework': '2004 HMIS Data and Technical Standards',                                    │ │
│ │        │   │   'consent-management': 'Required for cross-organization data sharing (ROI)',                       │ │
│ │        │   │   'allowable-disclosure': 'CoC-level aggregated reporting, HUD reporting requirements'              │ │
│ │        │   }                                                                                                     │ │
│ │        }                                                                                                         │ │
│ │ self = <hmis_codegen.parser.YAMLLDParser object at 0x0000029B0D8E3380>                                           │ │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│                                                                                                                      │
│ C:\Users\gtuio\AppData\Local\Python\pythoncore-3.14-64\Lib\site-packages\pydantic\main.py:250 in __init__            │
│                                                                                                                      │
│    247 │   │   """                                                                                                   │
│    248 │   │   # `__tracebackhide__` tells pytest and some other tools to omit this function fr                      │
│    249 │   │   __tracebackhide__ = True                                                                              │
│ ❱  250 │   │   validated_self = self.__pydantic_validator__.validate_python(data, self_instance                      │
│    251 │   │   if self is not validated_self:                                                                        │
│    252 │   │   │   warnings.warn(                                                                                    │
│    253 │   │   │   │   'A custom validator is returning a value other than `self`.\n'                                │
│                                                                                                                      │
│ ╭───────────────────────────────────────────────────── locals ─────────────────────────────────────────────────────╮ │
│ │ data = {                                                                                                         │ │
│ │        │   'title': 'HMIS API Sandbox Specifications',                                                           │ │
│ │        │   'version': '1.0.0',                                                                                   │ │
│ │        │   'description': 'HMIS API Sandbox request, response, and error responses for each scenario in          │ │
│ │        the'+323,                                                                                                 │ │
│ │        │   'jsonld_context_url':                                                                                 │ │
│ │        'https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/'+60,                    │ │
│ │        │   'regulations': [                                                                                      │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': 'FY 2026 HMIS Data Standards',                                                        │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/3824/hmis-data-dictionary/',                    │ │
│ │        │   │   │   'regulation': 'Data collection and implementation guidance'                                   │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': '2004 Data and Technical Standards Notice',                                           │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/1318/2004-hmis-data-and-technical-standard'+15, │ │
│ │        │   │   │   'regulation': 'Privacy and Security Standards'                                                │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': 'Coordinated Entry Management and Data Guide',                                        │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/5758/coordinated-entry-management-and-data'+7,  │ │
│ │        │   │   │   'regulation': 'Guidance on Privacy and Security Standards including allowable uses and        │ │
│ │        disclosu'+3                                                                                               │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'name': 'CoC Program Interim Rule',                                                           │ │
│ │        │   │   │   'url': 'https://www.hudexchange.info/resource/2033/hearth-coc-program-interim-rule/',         │ │
│ │        │   │   │   'regulation': 'Procedures and Policies needed to designate and operate an HMIS, ensuring HMIS │ │
│ │        c'+79                                                                                                     │ │
│ │        │   │   }                                                                                                 │ │
│ │        │   ],                                                                                                    │ │
│ │        │   'servers': [                                                                                          │ │
│ │        │   │   {                                                                                                 │ │
│ │        │   │   │   'url': 'http://localhost:3000/api/v1',                                                        │ │
│ │        │   │   │   'description': 'HMIS API Sandbox (Mockoon Reference Implementation)'                          │ │
│ │        │   │   }                                                                                                 │ │
│ │        │   ],                                                                                                    │ │
│ │        │   'schemas': [                                                                                          │ │
│ │        │   │   APISchema(                                                                                        │ │
│ │        │   │   │   name='clientPrimaryKey',                                                                      │ │
│ │        │   │   │   type='object',                                                                                │ │
│ │        │   │   │   description='Unique identifier for Client resource',                                          │ │
│ │        │   │   │   properties=[                                                                                  │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='PersonalID',                                                                    │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description='Unique identifier for the client',                                       │ │
│ │        │   │   │   │   │   max_length=32,                                                                        │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasPersonalID'),               │ │
│ │        │   │   │   │   │   │   hud_data_element='Universal Data Element',                                        │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   )                                                                                         │ │
│ │        │   │   │   ],                                                                                            │ │
│ │        │   │   │   semantic=SemanticAnnotation(                                                                  │ │
│ │        │   │   │   │   jsonld_type='hmis:ClientIdentifier',                                                      │ │
│ │        │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#ClientIdentifier'),                    │ │
│ │        │   │   │   │   hud_data_element=None,                                                                    │ │
│ │        │   │   │   │   ontology_cardinality=None,                                                                │ │
│ │        │   │   │   │   pii=None                                                                                  │ │
│ │        │   │   │   ),                                                                                            │ │
│ │        │   │   │   hud_csv_table=None                                                                            │ │
│ │        │   │   ),                                                                                                │ │
│ │        │   │   APISchema(                                                                                        │ │
│ │        │   │   │   name='clientBase',                                                                            │ │
│ │        │   │   │   type='object',                                                                                │ │
│ │        │   │   │   description='Core Client demographic and identifying information',                            │ │
│ │        │   │   │   properties=[                                                                                  │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='FirstName',                                                                     │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description='First name of the client',                                               │ │
│ │        │   │   │   │   │   max_length=50,                                                                        │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasFirstName'),                │ │
│ │        │   │   │   │   │   │   hud_data_element='3.01',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='MiddleName',                                                                    │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description='Middle name of the client',                                              │ │
│ │        │   │   │   │   │   max_length=50,                                                                        │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasMiddleName'),               │ │
│ │        │   │   │   │   │   │   hud_data_element='3.01',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='LastName',                                                                      │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description='Last name of the client',                                                │ │
│ │        │   │   │   │   │   max_length=50,                                                                        │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasLastName'),                 │ │
│ │        │   │   │   │   │   │   hud_data_element='3.01',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='NameSuffix',                                                                    │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description="Suffix of the client's name",                                            │ │
│ │        │   │   │   │   │   max_length=50,                                                                        │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasNameSuffix'),               │ │
│ │        │   │   │   │   │   │   hud_data_element='3.01',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='NameDataQuality',                                                               │ │
│ │        │   │   │   │   │   type='integer',                                                                       │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description='Data quality indicator for name fields',                                 │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasNameDataQuality'),          │ │
│ │        │   │   │   │   │   │   hud_data_element='3.01',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='SSN',                                                                           │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description='Social Security Number',                                                 │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern='^[0-9]{9}$',                                                                 │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasSSN'),                      │ │
│ │        │   │   │   │   │   │   hud_data_element='3.02',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=True                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='SSNDataQuality',                                                                │ │
│ │        │   │   │   │   │   type='integer',                                                                       │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description=None,                                                                     │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasSSNDataQuality'),           │ │
│ │        │   │   │   │   │   │   hud_data_element='3.02',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='DOB',                                                                           │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format='date',                                                                        │ │
│ │        │   │   │   │   │   description='Date of birth of the client',                                            │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDateOfBirth'),              │ │
│ │        │   │   │   │   │   │   hud_data_element='3.03',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=True                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='DOBDataQuality',                                                                │ │
│ │        │   │   │   │   │   type='integer',                                                                       │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description=None,                                                                     │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDOBDataQuality'),           │ │
│ │        │   │   │   │   │   │   hud_data_element='3.03',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='AmIndAKNative',                                                                 │ │
│ │        │   │   │   │   │   type='integer',                                                                       │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description=None,                                                                     │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasAmIndAKNative'),            │ │
│ │        │   │   │   │   │   │   hud_data_element='3.04',                                                          │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   ... +30                                                                                   │ │
│ │        │   │   │   ],                                                                                            │ │
│ │        │   │   │   semantic=SemanticAnnotation(                                                                  │ │
│ │        │   │   │   │   jsonld_type='hmis:Client',                                                                │ │
│ │        │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#Client'),                              │ │
│ │        │   │   │   │   hud_data_element=None,                                                                    │ │
│ │        │   │   │   │   ontology_cardinality=None,                                                                │ │
│ │        │   │   │   │   pii=None                                                                                  │ │
│ │        │   │   │   ),                                                                                            │ │
│ │        │   │   │   hud_csv_table=None                                                                            │ │
│ │        │   │   ),                                                                                                │ │
│ │        │   │   APISchema(                                                                                        │ │
│ │        │   │   │   name='clientMetaData',                                                                        │ │
│ │        │   │   │   type='object',                                                                                │ │
│ │        │   │   │   description='Audit and versioning metadata for Client records',                               │ │
│ │        │   │   │   properties=[                                                                                  │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='DateCreated',                                                                   │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format='date-time',                                                                   │ │
│ │        │   │   │   │   │   description=None,                                                                     │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://purl.org/dc/terms/created'),                         │ │
│ │        │   │   │   │   │   │   hud_data_element=None,                                                            │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='DateUpdated',                                                                   │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format='date-time',                                                                   │ │
│ │        │   │   │   │   │   description=None,                                                                     │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://purl.org/dc/terms/modified'),                        │ │
│ │        │   │   │   │   │   │   hud_data_element=None,                                                            │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='UserID',                                                                        │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format=None,                                                                          │ │
│ │        │   │   │   │   │   description=None,                                                                     │ │
│ │        │   │   │   │   │   max_length=32,                                                                        │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://www.w3.org/ns/prov#wasAttributedTo'),                │ │
│ │        │   │   │   │   │   │   hud_data_element=None,                                                            │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   SchemaProperty(                                                                           │ │
│ │        │   │   │   │   │   name='DateDeleted',                                                                   │ │
│ │        │   │   │   │   │   type='string',                                                                        │ │
│ │        │   │   │   │   │   format='date-time',                                                                   │ │
│ │        │   │   │   │   │   description=None,                                                                     │ │
│ │        │   │   │   │   │   max_length=None,                                                                      │ │
│ │        │   │   │   │   │   pattern=None,                                                                         │ │
│ │        │   │   │   │   │   semantic=SemanticAnnotation(                                                          │ │
│ │        │   │   │   │   │   │   jsonld_type=None,                                                                 │ │
│ │        │   │   │   │   │   │   semantic_uri=HttpUrl('http://hmis.hud.gov/ontology#hasDateDeleted'),              │ │
│ │        │   │   │   │   │   │   hud_data_element=None,                                                            │ │
│ │        │   │   │   │   │   │   ontology_cardinality=None,                                                        │ │
│ │        │   │   │   │   │   │   pii=None                                                                          │ │
│ │        │   │   │   │   │   ),                                                                                    │ │
│ │        │   │   │   │   │   hud_reference=None,                                                                   │ │
│ │        │   │   │   │   │   conditional=None,                                                                     │ │
│ │        │   │   │   │   │   business_rule=None                                                                    │ │
│ │        │   │   │   │   )                                                                                         │ │
│ │        │   │   │   ],                                                                                            │ │
│ │        │   │   │   semantic=SemanticAnnotation(                                                                  │ │
│ │        │   │   │   │   jsonld_type='prov:Entity',                                                                │ │
│ │        │   │   │   │   semantic_uri=HttpUrl('http://www.w3.org/ns/prov#Entity'),                                 │ │
│ │        │   │   │   │   hud_data_element=None,                                                                    │ │
│ │        │   │   │   │   ontology_cardinality=None,                                                                │ │
│ │        │   │   │   │   pii=None                                                                                  │ │
│ │        │   │   │   ),                                                                                            │ │
│ │        │   │   │   hud_csv_table=None                                                                            │ │
│ │        │   │   )                                                                                                 │ │
│ │        │   ],                                                                                                    │ │
│ │        │   'operations': [                                                                                       │ │
│ │        │   │   APIOperation(                                                                                     │ │
│ │        │   │   │   operation_id='clientSearch',                                                                  │ │
│ │        │   │   │   method='post',                                                                                │ │
│ │        │   │   │   path='/client/search',                                                                        │ │
│ │        │   │   │   summary='Search for clients by identifying information using POST',                           │ │
│ │        │   │   │   description='Search for client records using various identifying criteria:\n- Name (first,    │ │
│ │        las'+144,                                                                                                 │ │
│ │        │   │   │   effects=[                                                                                     │ │
│ │        │   │   │   │   Effect(                                                                                   │ │
│ │        │   │   │   │   │   name='AuthorizationCheck',                                                            │ │
│ │        │   │   │   │   │   handler='hmis:checkSearchPermission',                                                 │ │
│ │        │   │   │   │   │   description='Verifies user authorized to search client records',                      │ │
│ │        │   │   │   │   │   signature='userID: ID â†’ AuthResult',                                                │ │
│ │        │   │   │   │   │   resumable=True,                                                                       │ │
│ │        │   │   │   │   │   required_by=None,                                                                     │ │
│ │        │   │   │   │   │   provenance=None,                                                                      │ │
│ │        │   │   │   │   │   provenance_type=None,                                                                 │ │
│ │        │   │   │   │   │   transaction=None                                                                      │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   Effect(                                                                                   │ │
│ │        │   │   │   │   │   name='DatabaseRead',                                                                  │ │
│ │        │   │   │   │   │   handler='hmis:searchClients',                                                         │ │
│ │        │   │   │   │   │   description='Searches clients by identifying criteria',                               │ │
│ │        │   │   │   │   │   signature='query: SearchQuery â†’ List[Client]',                                      │ │
│ │        │   │   │   │   │   resumable=True,                                                                       │ │
│ │        │   │   │   │   │   required_by=None,                                                                     │ │
│ │        │   │   │   │   │   provenance=None,                                                                      │ │
│ │        │   │   │   │   │   provenance_type=None,                                                                 │ │
│ │        │   │   │   │   │   transaction=None                                                                      │ │
│ │        │   │   │   │   ),                                                                                        │ │
│ │        │   │   │   │   Effect(                                                                                   │ │
│ │        │   │   │   │   │   name='AuditLog',                                                                      │ │
│ │        │   │   │   │   │   handler='hmis:logClientSearch',                                                       │ │
│ │        │   │   │   │   │   description='Records search operation (without exposing PII)',                        │ │
│ │        │   │   │   │   │   signature='event: SearchEvent â†’ Unit',                                              │ │
│ │        │   │   │   │   │   resumable=False,                                                                      │ │
│ │        │   │   │   │   │   required_by=None,                                                                     │ │
│ │        │   │   │   │   │   provenance=None,                                                                      │ │
│ │        │   │   │   │   │   provenance_type='prov:Search',                                                        │ │
│ │        │   │   │   │   │   transaction=None                                                                      │ │
│ │        │   │   │   │   )                                                                                         │ │
│ │        │   │   │   ],                                                                                            │ │
│ │        │   │   │   metadata=OperationMetadata(                                                                   │ │
│ │        │   │   │   │   workflow_step=None,                                                                       │ │
│ │        │   │   │   │   required_by_policy=[],                                                                    │ │
│ │        │   │   │   │   data_governance=None,                                                                     │ │
│ │        │   │   │   │   use_cases=[]                                                                              │ │
│ │        │   │   │   ),                                                                                            │ │
│ │        │   │   │   request_schema=None,                                                                          │ │
│ │        │   │   │   response_schemas={}                                                                           │ │
│ │        │   │   )                                                                                                 │ │
│ │        │   ],                                                                                                    │ │
│ │        │   'effect_system': {                                                                                    │ │
│ │        │   │   'description': 'HMIS API operations are annotated with algebraic effects they may                 │ │
│ │        perform.\nEffec'+321,                                                                                     │ │
│ │        │   │   'paradigm': 'Algebraic effects with handlers',                                                    │ │
│ │        │   │   'phase1-behavior': 'Documentary annotations for tooling',                                         │ │
│ │        │   │   'phase2-behavior': 'Runtime effect handlers with delimited continuations',                        │ │
│ │        │   │   'effect-types': [                                                                                 │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'DatabaseRead',                                                                   │ │
│ │        │   │   │   │   'signature': 'query: Query â†’ Result',                                                   │ │
│ │        │   │   │   │   'description': 'Read operation against HMIS database',                                    │ │
│ │        │   │   │   │   'resumable': True,                                                                        │ │
│ │        │   │   │   │   'handler': 'Database handler provides actual SQL execution'                               │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'DatabaseWrite',                                                                  │ │
│ │        │   │   │   │   'signature': 'entity: Entity, data: Data â†’ EntityID',                                   │ │
│ │        │   │   │   │   'description': 'Persist operation to HMIS database',                                      │ │
│ │        │   │   │   │   'resumable': False,                                                                       │ │
│ │        │   │   │   │   'handler': 'Database handler with transaction semantics'                                  │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'ConsentCheck',                                                                   │ │
│ │        │   │   │   │   'signature': 'clientID: ID, purpose: Purpose â†’ ConsentStatus',                          │ │
│ │        │   │   │   │   'description': 'Validate client consent for specific purpose',                            │ │
│ │        │   │   │   │   'resumable': True,                                                                        │ │
│ │        │   │   │   │   'handler': 'Consent service checks ROI and consent records',                              │ │
│ │        │   │   │   │   'policy-uri': 'http://hmis.hud.gov/policy#ConsentRequired'                                │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'ValidationCheck',                                                                │ │
│ │        │   │   │   │   'signature': 'data: Data, schema: Schema â†’ ValidationResult',                           │ │
│ │        │   │   │   │   'description': 'Validate data against HUD Data Standards',                                │ │
│ │        │   │   │   │   'resumable': True,                                                                        │ │
│ │        │   │   │   │   'handler': 'SHACL validator with ontology reasoning'                                      │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'AuditLog',                                                                       │ │
│ │        │   │   │   │   'signature': 'event: Event â†’ Unit',                                                     │ │
│ │        │   │   │   │   'description': 'Record operation in immutable audit trail',                               │ │
│ │        │   │   │   │   'resumable': False,                                                                       │ │
│ │        │   │   │   │   'handler': 'Append-only audit log service',                                               │ │
│ │        │   │   │   │   'provenance': 'http://www.w3.org/ns/prov#Activity'                                        │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'AuthorizationCheck',                                                             │ │
│ │        │   │   │   │   'signature': 'user: UserID, resource: ResourceID, action: Action â†’ Authorized',         │ │
│ │        │   │   │   │   'description': 'Check if user authorized for action on resource',                         │ │
│ │        │   │   │   │   'resumable': True,                                                                        │ │
│ │        │   │   │   │   'handler': 'Policy engine evaluates RBAC/ABAC rules'                                      │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'ExternalAPI',                                                                    │ │
│ │        │   │   │   │   'signature': 'endpoint: URL, params: Params â†’ Response',                                │ │
│ │        │   │   │   │   'description': 'Call external service (e.g., SSN verification)',                          │ │
│ │        │   │   │   │   'resumable': True,                                                                        │ │
│ │        │   │   │   │   'handler': 'HTTP client with retry/timeout semantics'                                     │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'ValidationError',                                                                │ │
│ │        │   │   │   │   'signature': 'error: ErrorDetail â†’ Never',                                              │ │
│ │        │   │   │   │   'description': 'Abort computation with validation error',                                 │ │
│ │        │   │   │   │   'resumable': False,                                                                       │ │
│ │        │   │   │   │   'handler': 'Error response generator'                                                     │ │
│ │        │   │   │   },                                                                                            │ │
│ │        │   │   │   {                                                                                             │ │
│ │        │   │   │   │   'name': 'BusinessRuleError',                                                              │ │
│ │        │   │   │   │   'signature': 'rule: Rule, violation: Detail â†’ Never',                                   │ │
│ │        │   │   │   │   'description': 'Abort computation due to business rule violation',                        │ │
│ │        │   │   │   │   'resumable': False,                                                                       │ │
│ │        │   │   │   │   'handler': 'Error response with policy traceability'                                      │ │
│ │        │   │   │   }                                                                                             │ │
│ │        │   │   ],                                                                                                │ │
│ │        │   │   'effect-patterns': {                                                                              │ │
│ │        │   │   │   'description': 'Effects compose naturally - an operation that calls sub-operations\ninherits  │ │
│ │        thei'+62,                                                                                                 │ │
│ │        │   │   │   'examples': [                                                                                 │ │
│ │        │   │   │   │   {                                                                                         │ │
│ │        │   │   │   │   │   'name': 'Client creation workflow',                                                   │ │
│ │        │   │   │   │   │   'effects': ['ConsentCheck', 'ValidationCheck', 'DatabaseWrite', 'AuditLog'],          │ │
│ │        │   │   │   │   │   'composition': 'Sequential effect execution with early termination on error'          │ │
│ │        │   │   │   │   },                                                                                        │ │
│ │        │   │   │   │   {                                                                                         │ │
│ │        │   │   │   │   │   'name': 'Client search with authorization',                                           │ │
│ │        │   │   │   │   │   'effects': ['AuthorizationCheck', 'DatabaseRead', 'AuditLog'],                        │ │
│ │        │   │   │   │   │   'composition': 'Authorization gates database access'                                  │ │
│ │        │   │   │   │   },                                                                                        │ │
│ │        │   │   │   │   {                                                                                         │ │
│ │        │   │   │   │   │   'name': 'Cross-organization data sharing',                                            │ │
│ │        │   │   │   │   │   'effects': [                                                                          │ │
│ │        │   │   │   │   │   │   'AuthorizationCheck',                                                             │ │
│ │        │   │   │   │   │   │   'ConsentCheck',                                                                   │ │
│ │        │   │   │   │   │   │   'DatabaseRead',                                                                   │ │
│ │        │   │   │   │   │   │   'AuditLog',                                                                       │ │
│ │        │   │   │   │   │   │   'ExternalAPI'                                                                     │ │
│ │        │   │   │   │   │   ],                                                                                    │ │
│ │        │   │   │   │   │   'composition': 'Multiple authorization layers before data access'                     │ │
│ │        │   │   │   │   }                                                                                         │ │
│ │        │   │   │   ]                                                                                             │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   'toolchain-integration': {                                                                        │ │
│ │        │   │   │   'parser': 'Extract x-effects from operations â†’ Effect AST',                                 │ │
│ │        │   │   │   'generator': 'Generate effect handler interfaces from Effect AST',                            │ │
│ │        │   │   │   'validator': 'Ensure all effects have registered handlers',                                   │ │
│ │        │   │   │   'test-harness': 'Generate mock effect handlers for unit tests',                               │ │
│ │        │   │   │   'example-output': '# Generated Python effect handler interfaces:\n\nclass                     │ │
│ │        DatabaseWriteHandler(Protoc'+292                                                                          │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   '/client': {                                                                                      │ │
│ │        │   │   │   'post': {                                                                                     │ │
│ │        │   │   │   │   'operationId': 'postClient',                                                              │ │
│ │        │   │   │   │   'summary': 'Create a new client record',                                                  │ │
│ │        │   │   │   │   'description': 'Creates a new client record in the HMIS.\n\nValidates data quality        │ │
│ │        requirements pe'+96,                                                                                      │ │
│ │        │   │   │   │   'x-workflow-step': 'client-intake',                                                       │ │
│ │        │   │   │   │   'x-required-by-policy': [                                                                 │ │
│ │        │   │   │   │   │   '2004 HMIS Data Standards Section 5.2.1: Client data must be collected',              │ │
│ │        │   │   │   │   │   'CoC Program Interim Rule: HMIS participation required for HUD-funded projects'       │ │
│ │        │   │   │   │   ],                                                                                        │ │
│ │        │   │   │   │   'x-data-governance': {                                                                    │ │
│ │        │   │   │   │   │   'retention': '7 years (per 2004 Technical Standards Section 5.2.1)',                  │ │
│ │        │   │   │   │   │   'consent-required': True,                                                             │ │
│ │        │   │   │   │   │   'allowable-disclosure': 'CoC-level aggregated reporting only'                         │ │
│ │        │   │   │   │   },                                                                                        │ │
│ │        │   │   │   │   'x-effects': [                                                                            │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'effect': 'ConsentCheck',                                                         │ │
│ │        │   │   │   │   │   │   'handler': 'hmis:validateConsent',                                                │ │
│ │        │   │   │   │   │   │   'description': 'Verifies client consent for data collection',                     │ │
│ │        │   │   │   │   │   │   'signature': 'clientID: ID, purpose: Purpose â†’ ConsentStatus',                  │ │
│ │        │   │   │   │   │   │   'resumable': True,                                                                │ │
│ │        │   │   │   │   │   │   'required-by': '2004 HMIS Standards Section 4.2'                                  │ │
│ │        │   │   │   │   │   },                                                                                    │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'effect': 'ValidationCheck',                                                      │ │
│ │        │   │   │   │   │   │   'handler': 'hmis:validateHUDStandards',                                           │ │
│ │        │   │   │   │   │   │   'description': 'Validates client data against HUD Data Standards',                │ │
│ │        │   │   │   │   │   │   'signature': 'data: ClientData, schema: Schema â†’ ValidationResult',             │ │
│ │        │   │   │   │   │   │   'resumable': True,                                                                │ │
│ │        │   │   │   │   │   │   'ontology-validation': 'Uses SHACL shapes from ontology'                          │ │
│ │        │   │   │   │   │   },                                                                                    │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'effect': 'DatabaseWrite',                                                        │ │
│ │        │   │   │   │   │   │   'handler': 'hmis:persistClient',                                                  │ │
│ │        │   │   │   │   │   │   'description': 'Persists client record to HMIS database',                         │ │
│ │        │   │   │   │   │   │   'signature': 'entity: Client, data: Data â†’ PersonalID',                         │ │
│ │        │   │   │   │   │   │   'resumable': False,                                                               │ │
│ │        │   │   │   │   │   │   'transaction': True                                                               │ │
│ │        │   │   │   │   │   },                                                                                    │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'effect': 'AuditLog',                                                             │ │
│ │        │   │   │   │   │   │   'handler': 'hmis:logClientCreation',                                              │ │
│ │        │   │   │   │   │   │   'description': 'Records client creation in immutable audit trail',                │ │
│ │        │   │   │   │   │   │   'signature': 'event: ClientCreatedEvent â†’ Unit',                                │ │
│ │        │   │   │   │   │   │   'resumable': False,                                                               │ │
│ │        │   │   │   │   │   │   'provenance': 'http://www.w3.org/ns/prov#Activity',                               │ │
│ │        │   │   │   │   │   │   'provenance-type': 'prov:Create'                                                  │ │
│ │        │   │   │   │   │   }                                                                                     │ │
│ │        │   │   │   │   ],                                                                                        │ │
│ │        │   │   │   │   'requestBody': {                                                                          │ │
│ │        │   │   │   │   │   'content': {                                                                          │ │
│ │        │   │   │   │   │   │   'application/json': {                                                             │ │
│ │        │   │   │   │   │   │   │   'schema': {'$ref': '#/components/schemas/clientBase'},                        │ │
│ │        │   │   │   │   │   │   │   'x-validation-rules': [                                                       │ │
│ │        │   │   │   │   │   │   │   │   {                                                                         │ │
│ │        │   │   │   │   │   │   │   │   │   'rule': 'At least one name field (FirstName or LastName) required',   │ │
│ │        │   │   │   │   │   │   │   │   │   'severity': 'error'                                                   │ │
│ │        │   │   │   │   │   │   │   │   },                                                                        │ │
│ │        │   │   │   │   │   │   │   │   {                                                                         │ │
│ │        │   │   │   │   │   │   │   │   │   'rule': 'SSN must be valid if SSNDataQuality = Full SSN reported',    │ │
│ │        │   │   │   │   │   │   │   │   │   'severity': 'error'                                                   │ │
│ │        │   │   │   │   │   │   │   │   },                                                                        │ │
│ │        │   │   │   │   │   │   │   │   {                                                                         │ │
│ │        │   │   │   │   │   │   │   │   │   'rule': 'Gender fields follow HUD multi-select logic',                │ │
│ │        │   │   │   │   │   │   │   │   │   'severity': 'warning'                                                 │ │
│ │        │   │   │   │   │   │   │   │   }                                                                         │ │
│ │        │   │   │   │   │   │   │   ]                                                                             │ │
│ │        │   │   │   │   │   │   }                                                                                 │ │
│ │        │   │   │   │   │   }                                                                                     │ │
│ │        │   │   │   │   },                                                                                        │ │
│ │        │   │   │   │   'responses': {                                                                            │ │
│ │        │   │   │   │   │   '200': {                                                                              │ │
│ │        │   │   │   │   │   │   'description': 'Client record created successfully',                              │ │
│ │        │   │   │   │   │   │   'content': {                                                                      │ │
│ │        │   │   │   │   │   │   │   'application/json': {                                                         │ │
│ │        │   │   │   │   │   │   │   │   'schema': {                                                               │ │
│ │        │   │   │   │   │   │   │   │   │   'allOf': [                                                            │ │
│ │        │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientPrimaryKey'},                │ │
│ │        │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientBase'},                      │ │
│ │        │   │   │   │   │   │   │   │   │   │   {'$ref': '#/components/schemas/clientMetaData'}                   │ │
│ │        │   │   │   │   │   │   │   │   │   ]                                                                     │ │
│ │        │   │   │   │   │   │   │   │   },                                                                        │ │
│ │        │   │   │   │   │   │   │   │   'x-jsonld-frame': {                                                       │ │
│ │        │   │   │   │   │   │   │   │   │   '@context':                                                           │ │
│ │        'https://raw.githubusercontent.com/HUD-Data-Lab/HMIS-Logic-Model/refs/heads/main/'+60,                    │ │
│ │        │   │   │   │   │   │   │   │   │   '@type': 'hmis:Client',                                               │ │
│ │        │   │   │   │   │   │   │   │   │   '@id': 'http://hmis.example.org/client/{PersonalID}'                  │ │
│ │        │   │   │   │   │   │   │   │   }                                                                         │ │
│ │        │   │   │   │   │   │   │   }                                                                             │ │
│ │        │   │   │   │   │   │   }                                                                                 │ │
│ │        │   │   │   │   │   },                                                                                    │ │
│ │        │   │   │   │   │   '400': {                                                                              │ │
│ │        │   │   │   │   │   │   'description': 'Invalid input provided',                                          │ │
│ │        │   │   │   │   │   │   'content': {                                                                      │ │
│ │        │   │   │   │   │   │   │   'application/json': {                                                         │ │
│ │        │   │   │   │   │   │   │   │   'schema': {                                                               │ │
│ │        │   │   │   │   │   │   │   │   │   'oneOf': [                                                            │ │
│ │        │   │   │   │   │   │   │   │   │   │   {                                                                 │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'type': 'object',                                             │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'description': 'Data type validation error',                  │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'x-jsonld-type': 'hmis:ValidationError',                      │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'properties': {                                               │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   'missingInformationIncorrectDatatype': {                  │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   │   'type': 'string',                                     │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   │   'description': 'Invalid input provided - incorrect    │ │
│ │        data type or missing required field',                                                                     │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   │   'x-semantic-uri':                                     │ │
│ │        'http://hmis.hud.gov/errors#ValidationError'                                                              │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   }                                                         │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   }                                                             │ │
│ │        │   │   │   │   │   │   │   │   │   │   },                                                                │ │
│ │        │   │   │   │   │   │   │   │   │   │   {                                                                 │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'type': 'object',                                             │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'description': 'Business rule validation error',              │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'x-jsonld-type': 'hmis:BusinessRuleError',                    │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   'properties': {                                               │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   'invalidInputProvided': {                                 │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   │   'type': 'string',                                     │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   │   'description': 'Business rule violation (e.g.,        │ │
│ │        conditional field requirements)',                                                                         │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   │   'example': 'VeteranStatus = Yes requires              │ │
│ │        YearEnteredService',                                                                                      │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   │   'x-semantic-uri':                                     │ │
│ │        'http://hmis.hud.gov/errors#BusinessRuleError'                                                            │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   │   }                                                         │ │
│ │        │   │   │   │   │   │   │   │   │   │   │   }                                                             │ │
│ │        │   │   │   │   │   │   │   │   │   │   }                                                                 │ │
│ │        │   │   │   │   │   │   │   │   │   ]                                                                     │ │
│ │        │   │   │   │   │   │   │   │   },                                                                        │ │
│ │        │   │   │   │   │   │   │   │   'x-error-classification': {                                               │ │
│ │        │   │   │   │   │   │   │   │   │   'validation-error': 'Data fails HUD Data Standards validation',       │ │
│ │        │   │   │   │   │   │   │   │   │   'business-rule-error': 'Violates HUD program logic (e.g., conditional │ │
│ │        requirements)'                                                                                            │ │
│ │        │   │   │   │   │   │   │   │   }                                                                         │ │
│ │        │   │   │   │   │   │   │   }                                                                             │ │
│ │        │   │   │   │   │   │   }                                                                                 │ │
│ │        │   │   │   │   │   }                                                                                     │ │
│ │        │   │   │   │   }                                                                                         │ │
│ │        │   │   │   }                                                                                             │ │
│ │        │   │   },                                                                                                │ │
│ │        │   │   '/clientinproject': {                                                                             │ │
│ │        │   │   │   'get': {                                                                                      │ │
│ │        │   │   │   │   'operationId': 'clientListByProjectID',                                                   │ │
│ │        │   │   │   │   'summary': 'Get list of clients by project using ProjectID',                              │ │
│ │        │   │   │   │   'description': 'Returns all clients enrolled in specified project(s).\n\nSupports         │ │
│ │        multi-project qu'+104,                                                                                    │ │
│ │        │   │   │   │   'x-workflow-step': 'project-reporting',                                                   │ │
│ │        │   │   │   │   'x-required-by-policy': [                                                                 │ │
│ │        │   │   │   │   │   'CoC Program Interim Rule: Project-level data reporting requirements'                 │ │
│ │        │   │   │   │   ],                                                                                        │ │
│ │        │   │   │   │   'x-use-cases': [                                                                          │ │
│ │        │   │   │   │   │   'Annual Performance Report (APR) data extraction',                                    │ │
│ │        │   │   │   │   │   'CAPER report generation',                                                            │ │
│ │        │   │   │   │   │   'CoC competition application data'                                                    │ │
│ │        │   │   │   │   ],                                                                                        │ │
│ │        │   │   │   │   'x-effects': [                                                                            │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'effect': 'AuthorizationCheck',                                                   │ │
│ │        │   │   │   │   │   │   'handler': 'hmis:checkProjectAccess',                                             │ │
│ │        │   │   │   │   │   │   'description': 'Verifies user has read access to requested projects',             │ │
│ │        │   │   │   │   │   │   'signature': 'userID: ID, projectIDs: List[ID] â†’ AuthResult',                   │ │
│ │        │   │   │   │   │   │   'resumable': True                                                                 │ │
│ │        │   │   │   │   │   },                                                                                    │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'effect': 'DatabaseRead',                                                         │ │
│ │        │   │   │   │   │   │   'handler': 'hmis:queryClientsByProject',                                          │ │
│ │        │   │   │   │   │   │   'description': 'Queries clients enrolled in specified projects',                  │ │
│ │        │   │   │   │   │   │   'signature': 'projectIDs: List[ID] â†’ List[Client]',                             │ │
│ │        │   │   │   │   │   │   'resumable': True,                                                                │ │
│ │        │   │   │   │   │   │   'query-complexity': 'O(n) where n = number of enrollments'                        │ │
│ │        │   │   │   │   │   },                                                                                    │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'effect': 'AuditLog',                                                             │ │
│ │        │   │   │   │   │   │   'handler': 'hmis:logProjectQuery',                                                │ │
│ │        │   │   │   │   │   │   'description': 'Records project data access for compliance',                      │ │
│ │        │   │   │   │   │   │   'signature': 'event: ProjectQueryEvent â†’ Unit',                                 │ │
│ │        │   │   │   │   │   │   'resumable': False,                                                               │ │
│ │        │   │   │   │   │   │   'provenance-type': 'prov:Read'                                                    │ │
│ │        │   │   │   │   │   }                                                                                     │ │
│ │        │   │   │   │   ],                                                                                        │ │
│ │        │   │   │   │   'parameters': [                                                                           │ │
│ │        │   │   │   │   │   {                                                                                     │ │
│ │        │   │   │   │   │   │   'name': 'ProjectID',                                                              │ │
│ │        │   │   │   │   │   │   'in': 'query',                                                                    │ │
│ │        │   │   │   │   │   │   'required': False,                                                                │ │
│ │        │   │   │   │   │   │   'description': 'One or more project IDs to filter clients',                       │ │
│ │        │   │   │   │   │   │   'style': 'form',                                                                  │ │
│ │        │   │   │   │   │   │   'explode': True,                                                                  │ │
│ │        │   │   │   │   │   │   'schema': {                                                                       │ │
│ │        │   │   │   │   │   │   │   'type': 'array',                                                              │ │
│ │        │   │   │   │   │   │   │   'items': {                                                                    │ │
│ │        │   │   │   │   │   │   │   │   'type': 'string',                                                         │ │
│ │        │   │   │   │   │   │   │   │   'maxLength': 32,                                                          │ │
│ │        │   │   │   │   │   │   │   │   'x-semantic-uri': 'http://hmis.hud.gov/ontology#hasProjectID'             │ │
│ │        │   │   │   │   │   │   │   }                                                                             │ │
│ │        │   │   │   │   │   │   }                                                                                 │ │
│ │        │   │   │   │   │   }                                                                                     │ │
│ │        │   │   │   │   ],                                                                                        │ │
│ │        │   │   │   │   'responses': {                                                                            │ │
│ │        │   │   │   │   │   '200': {                                                                              │ │
│ │        │   │   │   │   │   │   'description': 'A list of clients and any unmatched project IDs',                 │ │
│ │        │   │   │   │   │   │   'content': {                                                                      │ │
│ │        │   │   │   │   │   │   │   'application/json': {                                                         │ │
│ │        │   │   │   │   │   │   │   │   'schema': {                                                               │ │
│ │        │   │   │   │   │   │   │   │   │   'type': 'object',                                                     │ │
│ │        │   │   │   │   │   │   │   │   │   'x-jsonld-type': 'hmis:ProjectClientListResponse',                    │ │
│ │        │   │   │   │   │   │   │   │   │   'properties': None                                                    │ │
│ │        │   │   │   │   │   │   │   │   }                                                                         │ │
│ │        │   │   │   │   │   │   │   }                                                                             │ │
│ │        │   │   │   │   │   │   }                                                                                 │ │
│ │        │   │   │   │   │   }                                                                                     │ │
│ │        │   │   │   │   }                                                                                         │ │
│ │        │   │   │   }                                                                                             │ │
│ │        │   │   }                                                                                                 │ │
│ │        │   }                                                                                                     │ │
│ │        }                                                                                                         │ │
│ │ self = OpenAPISpec()                                                                                             │ │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
ValidationError: 2 validation errors for OpenAPISpec
x-jsonld-context
  Field required [type=missing, input_value={'title': 'HMIS API Sandb...operties': None}}}}}}}}}, input_type=dict]
    For further information visit https://errors.pydantic.dev/2.12/v/missing
x-HMIS-Regulation
  Field required [type=missing, input_value={'title': 'HMIS API Sandb...operties': None}}}}}}}}}, input_type=dict]
    For further information visit https://errors.pydantic.dev/2.12/v/missing

C:\Users\gtuio\OneDrive\Documents\GitHub\002.GT.Data.Exchange.and.Interoperability\hmis-codegen>
```