# =============================================================================
# HMIS Data Exchange Scenario Ontology Generator
#
# Expected Excel structure:
#
# Sheet 1:
# ScenarioName | Method
# ClientSearch | GET
# NewClient    | POST
#
# Sheet 2:
# dataExchangeOntologyName | ClientSearchRequest | ClientSearchResponse |
#                           NewClientRequest      | NewClientResponse
#
# Selected cells may contain: x, yes, true, or 1
# =============================================================================

library(readxl)
library(rdflib)


# =============================================================================
# Configuration
# =============================================================================

input_file <- paste0(
  "Translation Layer/datasource/",
  "DataExchangeScenarioOntology.xlsx"
)

output_file <- paste0(
  "Translation Layer/outputs/",
  "DataExchangeOntology_v6.0.0.ttl"
)

scenario_sheet <- 1
mapping_sheet <- 2


# =============================================================================
# Namespace IRIs
# =============================================================================

# This must match the namespace used by the core HMIS ontology.
api_namespace <- paste0(
  "http://www.semanticweb.org/",
  "ontologies/hmis/api#"
)

hmis_namespace <- paste0(
  "http://www.semanticweb.org/",
  "ontologies/hmis#"
)

rdf_namespace <- paste0(
  "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
)

rdfs_namespace <- paste0(
  "http://www.w3.org/2000/01/rdf-schema#"
)

owl_namespace <- paste0(
  "http://www.w3.org/2002/07/owl#"
)

xsd_namespace <- paste0(
  "http://www.w3.org/2001/XMLSchema#"
)


# =============================================================================
# Full-IRI helper functions
# =============================================================================

API <- function(term) {
  paste0(api_namespace, term)
}

HMIS <- function(term) {
  paste0(hmis_namespace, term)
}

RDF <- function(term) {
  paste0(rdf_namespace, term)
}

RDFS <- function(term) {
  paste0(rdfs_namespace, term)
}

OWL <- function(term) {
  paste0(owl_namespace, term)
}

XSD <- function(term) {
  paste0(xsd_namespace, term)
}


# =============================================================================
# General helper functions
# =============================================================================

# Convert a scenario or element name into a safe local IRI name.
#
# Examples:
# "Client Search"       -> "ClientSearch"
# "Client-Search"       -> "ClientSearch"
# "has Personal ID"     -> "hasPersonalID"

make_local_name <- function(value) {
  
  value <- trimws(as.character(value))
  
  value <- gsub(
    pattern = "[^A-Za-z0-9_]",
    replacement = "",
    x = value
  )
  
  value
}


# Determine whether an Excel mapping cell is selected.

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


# Add an IRI-to-IRI RDF triple.

add_uri_triple <- function(
    graph,
    subject,
    predicate,
    object
) {
  
  rdf_add(
    graph,
    subject = subject,
    predicate = predicate,
    object = object,
    subjectType = "uri",
    objectType = "uri"
  )
}


# Add an IRI-to-literal RDF triple.

add_literal_triple <- function(
    graph,
    subject,
    predicate,
    object
) {
  
  rdf_add(
    graph,
    subject = subject,
    predicate = predicate,
    object = as.character(object),
    subjectType = "uri",
    objectType = "literal"
  )
}


# Add one selected HMIS element to a scenario.

add_scenario_element <- function(
    graph,
    scenario_iri,
    predicate_iri,
    element_name
) {
  
  if (
    length(element_name) == 0 ||
    is.na(element_name)
  ) {
    return(invisible(NULL))
  }
  
  element_name <- make_local_name(element_name)
  
  if (element_name == "") {
    return(invisible(NULL))
  }
  
  add_uri_triple(
    graph = graph,
    subject = scenario_iri,
    predicate = predicate_iri,
    object = HMIS(element_name)
  )
  
  invisible(NULL)
}


# =============================================================================
# Validate input and output paths
# =============================================================================

if (!file.exists(input_file)) {
  
  stop(
    paste0(
      "The Excel input file was not found: ",
      input_file
    )
  )
}


output_directory <- dirname(output_file)

if (!dir.exists(output_directory)) {
  
  dir.create(
    output_directory,
    recursive = TRUE
  )
}


# =============================================================================
# Read Excel workbook
# =============================================================================

ScenarioData <- read_excel(
  path = input_file,
  sheet = scenario_sheet,
  .name_repair = "minimal"
)

ElementMapping <- read_excel(
  path = input_file,
  sheet = mapping_sheet,
  .name_repair = "minimal"
)


# Remove leading or trailing spaces from column names.

names(ScenarioData) <- trimws(
  names(ScenarioData)
)

names(ElementMapping) <- trimws(
  names(ElementMapping)
)


# =============================================================================
# Validate workbook columns
# =============================================================================

required_scenario_columns <- c(
  "ScenarioName",
  "Method"
)

missing_scenario_columns <- setdiff(
  required_scenario_columns,
  names(ScenarioData)
)

if (length(missing_scenario_columns) > 0) {
  
  stop(
    paste0(
      "Sheet 1 is missing the following required column(s): ",
      paste(
        missing_scenario_columns,
        collapse = ", "
      )
    )
  )
}


element_name_column <- "dataExchangeOntologyName"

if (!element_name_column %in% names(ElementMapping)) {
  
  stop(
    paste0(
      "Sheet 2 must contain a column named '",
      element_name_column,
      "'."
    )
  )
}


# Remove blank scenario rows.

scenario_is_present <- (
  !is.na(ScenarioData$ScenarioName) &
    trimws(
      as.character(ScenarioData$ScenarioName)
    ) != ""
)

ScenarioData <- ScenarioData[
  scenario_is_present,
  ,
  drop = FALSE
]


# Remove blank element rows.

element_is_present <- (
  !is.na(
    ElementMapping[[element_name_column]]
  ) &
    trimws(
      as.character(
        ElementMapping[[element_name_column]]
      )
    ) != ""
)

ElementMapping <- ElementMapping[
  element_is_present,
  ,
  drop = FALSE
]


# Prevent duplicate scenario definitions.

normalized_scenario_names <- vapply(
  ScenarioData$ScenarioName,
  make_local_name,
  character(1)
)

duplicate_scenarios <- unique(
  normalized_scenario_names[
    duplicated(normalized_scenario_names)
  ]
)

if (length(duplicate_scenarios) > 0) {
  
  stop(
    paste0(
      "Sheet 1 contains duplicate scenario names: ",
      paste(
        duplicate_scenarios,
        collapse = ", "
      )
    )
  )
}


# =============================================================================
# Initialize RDF graph
# =============================================================================

g <- rdf()


# =============================================================================
# Declare ontology
# =============================================================================

ontology_iri <- API("DataExchangeOntology")

add_uri_triple(
  graph = g,
  subject = ontology_iri,
  predicate = RDF("type"),
  object = OWL("Ontology")
)

add_literal_triple(
  graph = g,
  subject = ontology_iri,
  predicate = RDFS("label"),
  object = "HMIS Data Exchange Ontology"
)


# Optional import statement.
#
# Uncomment this section only if hmis_namespace is also the ontology IRI
# for the published core HMIS ontology. If the ontology IRI differs from
# the entity namespace, replace hmis_namespace with the exact ontology IRI.
#
# add_uri_triple(
#   graph = g,
#   subject = ontology_iri,
#   predicate = OWL("imports"),
#   object = "EXACT_CORE_HMIS_ONTOLOGY_IRI"
# )


# =============================================================================
# Declare core Scenario class
# =============================================================================

scenario_class_iri <- API("Scenario")

add_uri_triple(
  graph = g,
  subject = scenario_class_iri,
  predicate = RDF("type"),
  object = OWL("Class")
)

add_literal_triple(
  graph = g,
  subject = scenario_class_iri,
  predicate = RDFS("label"),
  object = "Data Exchange Scenario"
)


# =============================================================================
# Declare annotation properties
#
# These are annotation properties because their subjects are scenario classes.
# This allows the scenario mappings to appear in the Annotations panel for
# each scenario class in Protege.
# =============================================================================

annotation_properties <- c(
  requestElement = "request element",
  responseElement = "response element",
  httpMethod = "HTTP method"
)

for (
  property_local_name in names(
    annotation_properties
  )
) {
  
  property_iri <- API(
    property_local_name
  )
  
  add_uri_triple(
    graph = g,
    subject = property_iri,
    predicate = RDF("type"),
    object = OWL("AnnotationProperty")
  )
  
  add_literal_triple(
    graph = g,
    subject = property_iri,
    predicate = RDFS("label"),
    object = annotation_properties[[property_local_name]])
}


# =============================================================================
# Generate scenario subclasses and mappings
# =============================================================================

for (i in seq_len(nrow(ScenarioData))) {
  
  # ---------------------------------------------------------------------------
  # Read scenario metadata
  # ---------------------------------------------------------------------------
  
  scenario_name_raw <- trimws(
    as.character(
      ScenarioData$ScenarioName[i]
    )
  )
  
  scenario_method <- toupper(
    trimws(
      as.character(
        ScenarioData$Method[i]
      )
    )
  )
  
  scenario_base_name <- make_local_name(
    scenario_name_raw
  )
  
  if (scenario_base_name == "") {
    
    warning(
      paste0(
        "Skipping row ",
        i,
        " because ScenarioName did not produce a valid local name."
      )
    )
    
    next
  }
  
  
  # ScenarioName in Sheet 1 should normally be ClientSearch or NewClient.
  # Add "Scenario" to the generated OWL class name when needed.
  
  if (
    grepl(
      pattern = "Scenario$",
      x = scenario_base_name
    )
  ) {
    
    scenario_class_name <- scenario_base_name
    
    mapping_base_name <- sub(
      pattern = "Scenario$",
      replacement = "",
      x = scenario_base_name
    )
    
  } else {
    
    scenario_class_name <- paste0(
      scenario_base_name,
      "Scenario"
    )
    
    mapping_base_name <- scenario_base_name
  }
  
  
  scenario_iri <- API(
    scenario_class_name
  )
  
  
  # Expected Sheet 2 headers:
  # ClientSearchRequest
  # ClientSearchResponse
  
  request_column <- paste0(
    mapping_base_name,
    "Request"
  )
  
  response_column <- paste0(
    mapping_base_name,
    "Response"
  )
  
  
  # ---------------------------------------------------------------------------
  # Create scenario subclass
  # ---------------------------------------------------------------------------
  
  add_uri_triple(
    graph = g,
    subject = scenario_iri,
    predicate = RDF("type"),
    object = OWL("Class")
  )
  
  add_uri_triple(
    graph = g,
    subject = scenario_iri,
    predicate = RDFS("subClassOf"),
    object = scenario_class_iri
  )
  
  add_literal_triple(
    graph = g,
    subject = scenario_iri,
    predicate = RDFS("label"),
    object = scenario_name_raw
  )

  
  # ---------------------------------------------------------------------------
  # Add HTTP method annotation
  # ---------------------------------------------------------------------------
  
  if (
    !is.na(scenario_method) &&
    scenario_method != ""
  ) {
    
    add_literal_triple(
      graph = g,
      subject = scenario_iri,
      predicate = API("httpMethod"),
      object = scenario_method
    )
  }
  
  
  # ---------------------------------------------------------------------------
  # Add request elements
  # ---------------------------------------------------------------------------
  
  if (request_column %in% names(ElementMapping)) {
    
    request_selected <- vapply(
      ElementMapping[[request_column]],
      is_selected,
      logical(1)
    )
    
    request_rows <- which(
      request_selected
    )
    
    if (length(request_rows) > 0) {
      
      for (row_number in request_rows) {
        
        element_name <- ElementMapping[[element_name_column]][row_number]
        
        add_scenario_element(
          graph = g,
          scenario_iri = scenario_iri,
          predicate_iri = API(
            "requestElement"
          ),
          element_name = element_name
        )
      }
    }
    
  } else {
    
    warning(
      paste0(
        "No request mapping column found for '",
        scenario_name_raw,
        "'. Expected Sheet 2 column: ",
        request_column
      )
    )
  }
  
  
  # ---------------------------------------------------------------------------
  # Add response elements
  # ---------------------------------------------------------------------------
  
  if (response_column %in% names(ElementMapping)) {
    
    response_selected <- vapply(
      ElementMapping[[response_column]],
      is_selected,
      logical(1)
    )
    
    response_rows <- which(response_selected)
    
    if (length(response_rows) > 0) {
      for (row_number in response_rows) {
        
        element_name <- ElementMapping[[element_name_column]][row_number]
        
        add_scenario_element(
          graph = g,
          scenario_iri = scenario_iri,
          predicate_iri = API("responseElement"),
          element_name = element_name
        )
      }
    }
  } 