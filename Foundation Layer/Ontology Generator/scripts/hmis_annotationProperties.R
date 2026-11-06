# Declarations for the HMIS annotation properties used throughout the generated ontology.
# Without these, validators and reasoners treat the properties as undeclared.
annotation_property_defs <- tribble(
  ~Name,                    ~Label,                       ~Comment,
  "csvList",                "CSV list ID",                "References the list identifier in the HMIS CSV Specifications.",
  "dataElementNumber",      "data element number",        "The HMIS Data Dictionary data element number, e.g. 3.12.",
  "dataElementFieldNumber", "data element field number",  "The field number within the HMIS data element.",
  "dataDictionaryName",     "data dictionary name",       "The field name as it appears in the HMIS Data Dictionary and CSV Specifications.",
  "CSVExportTable",         "CSV export table",           "The HMIS CSV export file (table) in which this field appears.",
  "linkedVocabulary",       "linked vocabulary",          "The SKOS concept scheme that holds the allowed values for this data element."
)

annotationProps <- annotation_property_defs %>%
  rowwise() %>%
  mutate(block = paste0(
    "hmis:", ttl_local(Name), " a owl:AnnotationProperty ;\n",
    "  rdfs:label ", ttl_lit(Label), "@en ;\n",
    "  rdfs:comment ", ttl_lit(Comment), "@en .\n"
  )) %>%
  ungroup() %>%
  pull(block)
