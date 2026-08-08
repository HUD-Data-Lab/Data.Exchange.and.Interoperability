# global.R ----

library(shiny)
library(tidyverse)
library(rdflib)
library(yaml)
library(here)
library(glue)
library(jsonlite)

build_field_schema <- function(value,
                               metadata,
                               vocab_values) {
  
  value <- as.character(value)
  
  field <- metadata %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::everything(),
        as.character
      )
    ) %>%
    dplyr::filter(
      dataDictionaryName == value |
        dataElementNumberAndField == value
    )
  
  if (nrow(field) == 0) {
    stop(
      paste(
        "Field not found:",
        value
      )
    )
  }
  
  field <- field[1, ]
  
  field_type <- field$field_type[1]
  
  # Enumerated field
  if (field_type == "Enumeration") {
    
    vals <- vocab_values %>%
      dplyr::filter(
        scheme == field$scheme[1]
      )
    
    return(
      list(
        DataDictionaryName = field$dataDictionaryName[1],
        type = "string",
        
        enum = vals$preflabel,
        
        `x-hmis-vocabulary` =
          field$dataElementNumberAndField[1],
        
        `x-hmis-values` =
          purrr::pmap(
            list(
              vals$notation,
              vals$preflabel
            ),
            function(notation, preflabel) {
              list(
                notation = notation,
                preflabel = preflabel
              )
            }
          )
      )
    )
  }
  
  # Scalar fields
  type_map <- c(
    String = "string",
    Integer = "integer",
    Decimal = "number",
    Boolean = "boolean",
    Date = "string",
    DateTime = "string"
  )
  
  schema_type <- type_map[field_type]
  
  if (is.na(schema_type)) {
    schema_type <- "string"
  }
  
  schema <- list(
    DataDictionaryName = field$dataDictionaryName[1],
    type = schema_type,
    `x-hmis-vocabulary` = field$dataElementNumberAndField[1]
  )
  
  if (field_type == "Date") {
    schema$format <- "date"
  }
  
  if (field_type == "DateTime") {
    schema$format <- "date-time"
  }
  
  schema
}

find_field <- function(field_id, metadata) {
  
  field_id <- as.character(field_id)
  
  metadata_clean <- metadata %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::everything(),
        as.character
      )
    )
  
  field <- metadata_clean %>%
    dplyr::filter(
      dataDictionaryName == field_id |
        dataElementNumberAndField == field_id
    )
  
  if (nrow(field) == 0) {
    stop(
      paste(
        "Field not found:",
        field_id
      )
    )
  }
  
  field[1, ]
}

build_object_schema <- function(fields,
                                metadata,
                                vocab_values) {
  
  properties <- lapply(
    fields,
    build_field_schema,
    metadata = metadata,
    vocab_values = vocab_values
  )
  
  property_names <- purrr::map_chr(
    fields,
    function(field_id) {
      
      field <- find_field(
        field_id,
        metadata
      )
      
      field$dataDictionaryName[1]
    }
  )
  
  names(properties) <- property_names
  
  list(
    type = "object",
    properties = properties
  )
}

g <- rdf_parse(
  "Artifacts/Ontology/Output_v1.0.0-beta/hmis_ontologyv1.0.0-beta.ttl",
  format = "turtle"
)


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

results <- rdf_query(g, query_all)
vocab_values <- rdf_query(g, query_vocab)


metadata <- results %>%
  dplyr::mutate(
    field_type = dplyr::case_when(
      !is.na(scheme) ~ "Enumeration",
      stringr::str_detect(range, "dateTime") ~ "DateTime",
      stringr::str_detect(range, "date") ~ "Date",
      stringr::str_detect(range, "integer") ~ "Integer",
      stringr::str_detect(range, "decimal") ~ "Decimal",
      stringr::str_detect(range, "boolean") ~ "Boolean",
      stringr::str_detect(range, "string") ~ "String",
      TRUE ~ "Unknown"
    ),
    dataElementNumberAndField = paste0(
      dataElementNumber,
      ".",
      dataElementFieldNumber
    )
  )


clean_MetaData <- metadata %>%
  dplyr::mutate(
    property = stringr::str_replace(property, "^.*[#/]", ""),
    domain = stringr::str_replace(domain, "^.*[#/]", ""),
    range = stringr::str_replace(range, "^.*[#/]", ""),
    field_type = stringr::str_replace(field_type, "^.*[#/]", "")
  )


clean_vocab_values <- vocab_values %>%
  dplyr::mutate(
    concept = stringr::str_replace(concept, "^.*[#/]", "")
  )

hmis_elements <- clean_MetaData %>%
  dplyr::select(
    dataDictionaryName,
    dataElementNumberAndField,
    CSVExportTable,
    field_type
  ) %>%
  dplyr::filter(
    !is.na(dataDictionaryName),
    dataDictionaryName != "NA",
    dataDictionaryName != ""
  ) %>%
  dplyr::distinct(
    dataDictionaryName,
    dataElementNumberAndField,
    .keep_all = TRUE
  ) %>%
  dplyr::arrange(
    dataElementNumberAndField,
    dataDictionaryName
  ) %>%
  dplyr::mutate(
    selector_label = paste0(
      dataDictionaryName,
      " | ",
      dataElementNumberAndField,
      " | ",
      field_type
    )
  )


# Named vector for selectizeInput
# Value returned to server = dataDictionaryName
# Searchable label shown to user = name, number.field, and type

hmis_element_choices <- hmis_elements$dataDictionaryName
names(hmis_element_choices) <- hmis_elements$selector_label