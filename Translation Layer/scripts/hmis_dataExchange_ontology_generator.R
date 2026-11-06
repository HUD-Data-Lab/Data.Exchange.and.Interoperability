# Data Exchange Scenarios

library(readxl)
library(rdflib)
library(readxl)
library(dplyr)
library(stringr)

# Build the core HMIS ontology first. This also loads the helper functions
# (ttl_lit, ttl_local), the HMIS namespace, ontology_version and Final_Ontology.
source("Foundation Layer/Ontology Generator/scripts/hmis_ontology_generator.R")

# Set up ----

input_file <- paste0("Translation Layer/datasource/", "DataExchangeScenarioOntology.xlsx")
output_file <- paste0("Translation Layer/outputs/", "DataExchangeOntology_", ontology_version, ".ttl")
dir.create("Translation Layer/outputs", recursive = TRUE, showWarnings = FALSE)

# Namespace IRI ----
# This must match the namespace used by the core HMIS ontology.
dtaexchng_namespace <- "urn:hud:hmis:de#"
hmis_namespace <- HMIS
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
  "@prefix dct: <http://purl.org/dc/terms/> .",
  paste0("@prefix de: <", dtaexchng_namespace, "> ."),
  "",
  # The data exchange module imports the core ontology rather than copying it,
  # so the two files cannot drift apart.
  "<urn:hud:hmis:de> rdf:type owl:Ontology ;",
  paste0("  owl:imports <", version_iri("hmis_ontology", ontology_version), "> ;"),
  paste0("  owl:versionIRI <", version_iri("hmisDataExchange_ontology", ontology_version), "> ;"),
  paste0("  owl:priorVersion <", version_iri("hmisDataExchange_ontology", prior_version), "> ;"),
  paste0("  owl:versionInfo \"", ontology_version, "\" ;"),
  "  dct:title \"HMIS Data Exchange Scenarios\"@en ;",
  "  dct:description \"Data exchange test scenarios that reference the HMIS Ontology data elements.\"@en ."
)

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
    "  rdf:type owl:AnnotationProperty ;",
    "  rdfs:label \"HTTP method\"@en .",
    "",
    "de:requestElement",
    "  rdf:type owl:AnnotationProperty ;",
    "  rdfs:label \"request element\"@en ;",
    "  rdfs:comment \"An HMIS data element sent in the scenario's request.\"@en .",
    "",
    "de:responseElement",
    "  rdf:type owl:AnnotationProperty ;",
    "  rdfs:label \"response element\"@en ;",
    "  rdfs:comment \"An HMIS data element returned in the scenario's response.\"@en .",
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
    
    selected_elements <- function(column) {
      if (!column %in% names(ElementMapping)) {
        warning("Scenario '", scenario_name, "' has no column '", column, "' in ElementMapping")
        return(character(0))
      }
      ElementMapping %>%
        filter(vapply(.data[[column]], is_selected, logical(1))) %>%
        pull(dataExchangeOntologyName) %>%
        unique()
    }

    element_group <- function(predicate, elements) {
      if (length(elements) == 0) return(NULL)
      paste0(
        "    ", predicate, "\n",
        paste0("        hmis:", ttl_local(elements), collapse = " ,\n")
      )
    }

    groups <- c(
      "    rdf:type owl:Class",
      "    rdfs:subClassOf de:Scenario",
      paste0("    de:httpMethod ", ttl_lit(scenario_method)),
      element_group("de:requestElement", selected_elements(request_column)),
      element_group("de:responseElement", selected_elements(response_column))
    )

    lines <- c(
      scenario_class,
      paste0(paste(groups, collapse = " ;\n"), " .")
    )

    c(lines, "")
  }
) %>%
  unlist(use.names = FALSE)

## Save as a turtle file ----
writeLines(c(ttl_header_DataExchange,deCoreClasses,deAnnotProp,ScenarioSubClasses),
           file.path(output_file),useBytes = TRUE) 

## The scenarios are no longer published in Artifacts/Ontology ----
# API test scenarios describe service behavior, not the meaning of HMIS data, so they
# are kept out of the ontology release. The module above stays in Translation Layer/outputs
# as working material until the scenarios move to OpenAPI + JSON-LD (see
# Artifacts/Ontology/Output_v1.4.0-beta/RECOMMENDATIONS.md).
