#HMIS Enumerated fields


library(rdflib)

# Load ontology
g <- rdf_parse("Ontology Generator/output/Output_20260710_165301/hmis_ontology0710T1653_01.ttl", format = "turtle")

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

HMIS_Dictionary_Options <- clean_MetaData %>% 
  select(dataDictionaryName,dataElementNumberAndField) %>% 
  filter(dataDictionaryName != "NA")

view(get_field_definition(
  "Data Element Name", #Options here are "Data Element Name" OR "Data Element Number"
  "HouseholdType", #Query removed all spaces when pulling the name.
  clean_MetaData,
  g
))



