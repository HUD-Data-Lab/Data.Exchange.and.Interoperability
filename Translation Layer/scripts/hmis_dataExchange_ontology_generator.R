# Data Exchange Scenarios

library(readxl)
library(rdflib)
library(readxl)
library(dplyr)
library(stringr)

# Set up ----

input_file <- paste0("Translation Layer/datasource/", "DataExchangeScenarioOntology.xlsx")
output_file <- paste0("Translation Layer/outputs/", "DataExchangeOntology_v9.0.0.ttl")

# Namespace IRI ----
# This must match the namespace used by the core HMIS ontology.
dtaexchng_namespace <- paste0("http://www.semanticweb.org/","ontologies/hmis/de#")
hmis_namespace <- paste0( "http://www.semanticweb.org/","ontologies/hmis#")
rdf_namespace <- paste0("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
rdfs_namespace <- paste0("http://www.w3.org/2000/01/rdf-schema#")
owl_namespace <- paste0("http://www.w3.org/2002/07/owl#")
xsd_namespace <- paste0("http://www.w3.org/2001/XMLSchema#")

# Helper Functions ----
#These are in place to support the loop when referencing an object property that should be "api:" or "rdf:"
DE <- function(term) {paste0(dtaexchng_namespace, term)}
HMIS <- function(term) {paste0(hmis_namespace, term)}
RDF <- function(term) {paste0(rdf_namespace, term)}
RDFS <- function(term) {paste0(rdfs_namespace, term)}
OWL <- function(term) {paste0(owl_namespace, term)}
XSD <- function(term) {paste0(xsd_namespace, term)}


# This removes spaces in a name. No spaces are allowed in naming conventions for the ontology
make_local_name <- function(value) {
  value <- trimws(as.character(value))
  value <- gsub(
    pattern = "[^A-Za-z0-9_]",
    replacement = "",
    x = value
  )
  value
}

#Normalizes the selection indicator in the spreadsheet to allow different values.
is_selected <- function(value) {
  if (length(value) == 0 || is.na(value)) {
    return(FALSE)
  }
  normalized_value <- tolower(
    trimws(as.character(value))
  )
  normalized_value %in% c(
    "x",
    "yes",
    "true",
    "1"
  )
}

# NEED DESCRIPTION
add_scenario_element <- function(
    graph,
    scenario_iri,
    predicate_iri,
    element_name
) {
  add_uri_triple(
    graph = graph,
    subject = scenario_iri,
    predicate = predicate_iri,
    object = HMIS(element_name)
  )}

# Create the ontology for data exchange scenarios ----
# Read the excel workbook
ScenarioData <- read_excel(input_file, 1)
ElementMapping <- read_excel(input_file, 2)

#Set the header
ttl_header_DataExchange <- c(
  paste0("@prefix hmis: <", hmis_namespace, "> ."),
  "@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .",
  "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .",
  "@prefix owl:  <http://www.w3.org/2002/07/owl#> .",
  paste0("@prefix de: <", dtaexchng_namespace, "> .")
)

ttl_headerDataExchangePrefix <- paste0("@prefix de: <", dtaexchng_namespace, "> .")

#Set the core classes
deCoreClasses <- c(
  "",
  "de:Scenario a owl:Class ;",
  paste0("  rdfs:label ", ttl_lit("Test scenario for Data Exchange Scenarios"), "@en ."),
  "")

#Define the Annotation properties
deAnnotProp <- 
  c(
    "de:httpMethod",
    paste0("  rdf:type owl:AnnotationProperty ."),
    "",
    "de:requestElement",
    paste0("  rdf:type owl:AnnotationProperty ."),
    "",
    "de:responseElement",
    paste0("  rdf:type owl:AnnotationProperty ."),
    ""
    )

# Set the Scenario Subclasses
ScenarioSubClasses <- lapply(
  seq_len(nrow(ScenarioData)),
  function(i) {
    scenario_name <- trimws(
      as.character(ScenarioData$ScenarioName[i])
    )
    
    scenario_method <- trimws(
      as.character(ScenarioData$Method[i])
    )
    
    scenario_class <- paste0(
      "de:",
      ttl_local(scenario_name),
      "Scenario"
    )
    
    request_column <- paste0(
      scenario_name,
      "Request"
    )
    
    response_column <- paste0(
      scenario_name,
      "Response"
    )
    
    lines <- c(
      scenario_class,
      "    rdf:type owl:Class ;",
      "    rdfs:subClassOf de:Scenario ;",
      paste0(
        "    de:httpMethod ",
        ttl_lit(scenario_method),
        " ;"
      )
    )
    
    # Request elements
    if (request_column %in% names(ElementMapping)) {
      
      request_elements <- ElementMapping %>%
        filter(
          vapply(
            .data[[request_column]],
            is_selected,
            logical(1)
          )
        ) %>%
        pull(dataExchangeOntologyName) %>%
        unique()
      
      if (length(request_elements) > 0) {
        
        lines <- c(
          lines,
          "    de:requestElement"
        )
        
        for (j in seq_along(request_elements)) {
          
          suffix <- ifelse(
            j == length(request_elements),
            " ;",
            " ,"
          )
          
          lines <- c(
            lines,
            paste0(
              "        hmis:",
              ttl_local(request_elements[j]),
              suffix
            )
          )
        }
      }
    }
    
    # Response elements
    if (response_column %in% names(ElementMapping)) {
      
      response_elements <- ElementMapping %>%
        filter(
          vapply(
            .data[[response_column]],
            is_selected,
            logical(1)
          )
        ) %>%
        pull(dataExchangeOntologyName) %>%
        unique()
      
      if (length(response_elements) > 0) {
        
        lines <- c(
          lines,
          "    de:responseElement"
        )
        
        for (j in seq_along(response_elements)) {
          
          suffix <- ifelse(
            j == length(response_elements),
            " .",
            " ,"
          )
          
          lines <- c(
            lines,
            paste0(
              "        hmis:",
              ttl_local(response_elements[j]),
              suffix
            )
          )
        }
      }
    }
    
    c(lines, "")
  }
) %>%
  unlist(use.names = FALSE)

## Save as a turtle file ----
writeLines(c(ttl_header_DataExchange,deCoreClasses,deAnnotProp,ScenarioSubClasses),
           file.path(output_file),useBytes = TRUE) 

## Combine with the main ontology turtle file ----
source("Foundation Layer/Ontology Generator/scripts/hmis_ontology_generator.R")

writeLines(c(ttl_header,ttl_headerDataExchangePrefix, classes,coreClassObjProps, skosConceptScheme,skosConcept,dataProp,objProp,
             deCoreClasses,deAnnotProp,ScenarioSubClasses),
           file.path(Final_Ontology,paste0("hmisDataExchange_ontology",ontology_version,".ttl")), useBytes = TRUE)




