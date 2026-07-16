#HMIS Enumerated fields

library(rdflib)
library(yaml)
# Load ontology
g <- rdf_parse("Artifacts/Ontology/Output_v1.0.0-beta/hmis_ontologyv1.0.0-beta.ttl", format = "turtle")

### Be able to query and pull all scalar and enumerated fields from the ontology ----

query_all <- '
PREFIX hmis: <http://www.semanticweb.org/61084/ontologies/2026/2/hmis#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?property ?dataDictionaryName ?dataElementNumber ?dataElementFieldNumber ?CSVExportTable ?domain ?range ?scheme
WHERE {

  ?property a ?type .

  FILTER(
      STRENDS(STR(?type), "ObjectProperty") ||
      STRENDS(STR(?type), "DatatypeProperty")
  )


  OPTIONAL { ?property hmis:dataDictionaryName ?dataDictionaryName . }
  OPTIONAL { ?property hmis:dataElementNumber ?dataElementNumber . }
  OPTIONAL { ?property hmis:dataElementFieldNumber ?dataElementFieldNumber . }
  OPTIONAL { ?property hmis:CSVExportTable ?CSVExportTable . }
  OPTIONAL { ?property rdfs:domain ?domain . }
  OPTIONAL { ?property rdfs:range ?range . }
  OPTIONAL { ?property hmis:linkedVocabulary ?scheme . }
}
'
results <- rdf_query(g, query_all)

metadata <- results %>%
  mutate(
    field_type = case_when(
      !is.na(scheme) ~ "Enumeration",
      str_detect(range, "date") ~ "Date",
      str_detect(range, "dateTime") ~ "DateTime",
      str_detect(range, "integer") ~ "Integer",
      str_detect(range, "decimal") ~ "Decimal",
      str_detect(range, "boolean") ~ "Boolean",
      str_detect(range, "string") ~ "String",
      TRUE ~ "Unknown"),
    dataElementNumberAndField = paste0(dataElementNumber,".",dataElementFieldNumber)
  )

clean_MetaData <- metadata %>%
  mutate(
    property = str_replace(property, "^.*[#/]", ""),
    domain   = str_replace(domain, "^.*[#/]", ""),
    range    = str_replace(range, "^.*[#/]", ""),
    #scheme   = str_replace(scheme, "^.*[#/]", ""),
    field_type = str_replace(field_type, "^.*[#/]", "")
  )




field <- clean_MetaData %>%
  filter(property == "LivingSituation")

enum_vals <- vocab_values %>%
  filter(scheme == field$scheme[1]) %>% 
  pull(concept)

schema <- list(
  type = "string",
  enum = enum_vals,
  `x-hmis-vocabulary` = field$dataElementNumberAndField[1]
)

field_yaml <- list(
  CurrentEdStatus = schema
)

cat(as.yaml(schema))



HMIS_Dictionary_Options <- clean_MetaData %>% 
  select(dataDictionaryName,dataElementNumberAndField) %>% 
  filter(dataDictionaryName != "NA")

view(get_field_definition(
  "Data Element Name", #Options here are "Data Element Name" OR "Data Element Number"
  "LivingSituation", #Query removed all spaces when pulling the name.
  clean_MetaData,
  g
))


jsonld_context <- clean_MetaData %>%
  transmute(
    term = property,
    iri = paste0("hmis:", property)
  )


resources <- clean_MetaData %>%
  group_by(domain)

## YAML file generation
query_vocab <- '
PREFIX hmis: <http://www.semanticweb.org/61084/ontologies/2026/2/hmis#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?scheme ?concept ?label ?notation
WHERE {

  ?concept skos:inScheme ?scheme .

  OPTIONAL { ?concept skos:prefLabel ?label . }
  OPTIONAL { ?concept skos:notation ?notation . }
}
'

vocab_values <- rdf_query(g, query_vocab) %>%
  mutate(
    #scheme = str_replace(scheme, "^.*[#/]", ""),
    concept = str_replace(concept, "^.*[#/]", "")
  )

enrollment_schema <- build_resource_schema(
  fields = c(
    "HouseholdID",
    "CurrentEdStatus",
    "VeteranStatus"
  ),
  metadata = clean_MetaData,
  vocab_values = vocab_values
)

openapi_object <- list(
  components = list(
    schemas = list(
      Enrollment = enrollment_schema
    )
  )
)

cat(as.yaml(openapi_object))







