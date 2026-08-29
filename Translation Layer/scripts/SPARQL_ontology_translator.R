# HMIS Translator: ontology properties --> tabular element definitions
### Goal Be able to query and pull all scalar and enumerated fields from the ontology

# Setup ---- 
## Packages
library(tidyverse)
library(rdflib)
library(yaml)
library(here)
library(glue)
library(jsonlite)

## Custom Functions
source(paste0(here(),"/Translation Layer/scripts/SPARQL_functions.R"))

# Load ontology ----

## Pull in graph
g <- rdf_parse("Artifacts/Ontology/Output_v1.1.0-beta/hmis_ontologyv1.1.0-beta.ttl", format = "turtle")


# Extract graph objects ----

## SPARQL body to extract ontology DATA PROPERTIES
query_all <- '
PREFIX hmis: <http://www.semanticweb.org/ontologies/hmis#> 
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
## SPARQL body to extract ontology VOCABULARIES
query_vocab <- '
PREFIX hmis: <http://www.semanticweb.org/61084/ontologies/2026/2/hmis#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?scheme ?concept ?preflabel ?notation ?altlabel
WHERE {

  ?concept skos:inScheme ?scheme .

  OPTIONAL { ?concept skos:prefLabel ?preflabel . }
  OPTIONAL { ?concept skos:notation ?notation . }
  OPTIONAL { ?concept skos:altLabel ?altlabel . }
}
'

## Execute SPARQL queries on graph
results <- rdf_query(g, query_all)
vocab_values <- rdf_query(g, query_vocab)




# Transform ----

## Add field type
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

## Extract property names from IRIs
  # >>> Strips out everything until the last '#' or '/' character
clean_MetaData <- metadata %>%
  mutate(
    property = str_replace(property, "^.*[#/]", ""),
    domain   = str_replace(domain, "^.*[#/]", ""),
    range    = str_replace(range, "^.*[#/]", ""),
    #scheme   = str_replace(scheme, "^.*[#/]", ""),
    field_type = str_replace(field_type, "^.*[#/]", "")
  )

# Remove relationship object properties
hmis_elements <- clean_MetaData %>% 
  select(dataDictionaryName,dataElementNumberAndField) %>% 
  filter(dataDictionaryName != "NA")


## Vocabulary cleaning

clean_vocab_values <- vocab_values %>%
  mutate(
    #scheme = str_replace(scheme, "^.*[#/]", ""),
    concept = str_replace(concept, "^.*[#/]", "")
  )


# Quality Assurance Checks ----

## Confirm SKOS vocabulary does not apply multiple notations to same skos:Concept.
## If it does, offer to return the detailed list.
  ## Note: For ShinyApp that allows for extension of ontology, should add
  ## in a STOP that prevents folks from re-using labels.

check_skos_notation_integrity(clean_vocab_values)


# DEV REFERENCE ITEMS ----

## Field Testing and JSON schema generation ----

### Manual and automated process of drilling down on a single field

#Options hmis_elements


field <- clean_MetaData %>%
  filter(property == "TimesHomelessPastThreeYears")

enum_vals <- vocab_values %>% # FLAG - depends on items defined below
  filter(scheme == field$scheme[1]) %>% 
  pull(concept)

schema <- list(
  type = "string",
  enum = enum_vals,
  `x-hmis-vocabulary` = field$dataElementNumberAndField[1]
)

#This pulls a single data elements information into a table
get_field_definition("ReceivesReferrals",
                     clean_MetaData,
                     g)

#This pulls the data element into a schema for parsing into JSON. Can be more than one data element
build_field_schema("ReceivesReferrals",
                   clean_MetaData,
                   clean_vocab_values)

Generatedschema <- build_object_schema(
  fields = c(
    "FirstName",
    "LastName",
    "ReceivesReferrals"
  ),
  clean_MetaData,
  clean_vocab_values
)


jsonlite::toJSON(
  Generatedschema,
  pretty = TRUE,
  auto_unbox = TRUE
)

### Exploration of vocabulary

single_row_schema_map <- clean_vocab_values %>% 
  mutate(scheme_name = str_replace(scheme, "^.*[#/]", "")) %>%
  group_by(concept, notation) %>% 
  summarize(
    count_scheme_matches = n() ,
    count_distinct_scheme = n_distinct(scheme_name),
    list_scheme = toString(unique(scheme_name))
  )

multi_notation <- clean_vocab_values %>% 
  select(c("concept", "notation")) %>% 
  unique(.) %>%
  count(concept) %>% 
  filter(n > 1)

vocab_w_multi_notation <- clean_vocab_values %>% 
  filter(concept %in% multi_notation$concept) %>% 
  mutate(scheme_name = str_replace(scheme, "^.*[#/]", "")) %>%
  group_by(concept, notation) %>% 
  summarize(
    count_scheme = n() ,
    list_scheme = toString(scheme_name),
  ) %>% 
  group_by(concept, count_scheme, list_scheme) %>%
  summarize(
    count_notation = n(),
    list_notation = toString(unique(notation))
  )

qa_destination <- paste0(here(),"/Translation Layer")
write.csv(vocab_w_multi_notation, file = paste0(qa_destination,"/vocab_w_multi_notation.csv"))

### Test of 'get_field_definition' function

view(get_field_definition(
  "Data Element Name", #Options here are "Data Element Name" OR "Data Element Number"
  "LivingSituation", #Query removed all spaces when pulling the name.
  clean_MetaData,
  g
))




## YAML translation snippets ----


# In a YAML file, we can flag something 
# as JSON-LD, which would be the IRI 
# that acts as prefix for the YAML
# >>> Results in a table that maps each element
# >>>> to a JSON-LD prefixed reference.
# *** We think this may be more easily done using built-in
# *** features of rdflib package.

# jsonld_context <- clean_MetaData %>%
#   transmute(
#     term = property,
#     iri = paste0("hmis:", property)
#   )

# This cam out of the idea of "Resources"
# in the API sense. These are ideally 
# supposed to be analogous to classes (entities).
# Endpoints are built around resources.

# Resources specify what's possible.
# Encountered design pattern where 
# Separate functional ontology
# developed with SPARQL endpoints 
# packaged as classes. (API-tuned 
# ontology interface)

# resources <- clean_MetaData %>%
#   group_by(domain)

## YAML file generation

# Grant thought the yaml package might be a helpful 
# thing for creating the YAML files.

# YAML would be second step of process
# after mapping the data elements
# YAML file knits together 
# selected pieces of ontology 
# into end-point based on their
# annotations and relationships
# If someone cares about dependencies
# allows pulling based on relationships.
# 
# field_yaml <- list(
#   CurrentEdStatus = schema
# )
# 
# cat(as.yaml(schema))
# 
# 
# 
# enrollment_schema <- build_resource_schema(
#   fields = c(
#     "HouseholdID",
#     "CurrentEdStatus",
#     "VeteranStatus"
#   ),
#   metadata = clean_MetaData,
#   vocab_values = vocab_values
# )
# 
# openapi_object <- list(
#   components = list(
#     schemas = list(
#       Enrollment = enrollment_schema
#     )
#   )
# )
# 
# cat(as.yaml(openapi_object))


{
  #Set the core classes
  writeLines(, 
             file.path(dated_dir,paste0("hmis_coreClasses",date_Filetag,".ttl")),useBytes = TRUE) 
}






