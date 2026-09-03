# global.R ----

library(shiny)
library(tidyverse)
library(dplyr)
library(jsonlite)
library(bslib)
library(rdflib)
library(readxl)

## source required files
source("html_text_blocks.R")

## Functions ----
time_step <- function(label, expr) {
  message("\n--- START: ", label, " ---")
  start <- Sys.time()
  result <- force(expr)
  end <- Sys.time()
  message("--- END: ", label, " | ",
          round(as.numeric(end - start, units = "secs"), 2),
          " sec ---")
  result
}

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

## Step 1: Prep the ontology files ----

cache_path <- "Artifacts/Ontology/Output_v1.3.0-beta/hmis_ontology_cache_v1.3.0-beta.rds"
ontology_path <- "Artifacts/Ontology/Output_v1.3.0-beta/hmis_ontologyv1.3.0-beta.ttl"

if (!file.exists(cache_path)) {
  stop(
    "Ontology cache not found. Run scripts/build_ontology_cache.R before launching the Shiny app."
  )
}

#Intention of this section is to make sure we are using the most recent ontology file. 
ontology_cache <- time_step("Load ontology cache", {
  readRDS(cache_path)
})

if (file.exists(ontology_path) && !is.null(ontology_cache$ontology_mtime)) {
  current_info <- file.info(ontology_path)
  
  if (!isTRUE(all.equal(current_info$mtime, ontology_cache$ontology_mtime))) {
    warning(
      "Ontology cache may be stale. Re-run scripts/build_ontology_cache.R because the TTL file has changed."
    )
  }
}


results <- ontology_cache$properties
vocab_values <- ontology_cache$vocab_values
scenarios <- ontology_cache$de_scenarios


# ADD THIS TO ONTOLOGY AND DELETE ----
#Add the label to the ontology. This was kept here to troubleshoot different UI approaches.
input_file <- paste0("Translation Layer/datasource/", "DataExchangeScenarioOntology.xlsx")
ScenarioData <- read_excel(input_file, 1)

scenarios_temp <- ScenarioData |>
  mutate(ScenarioName_id = paste0(ScenarioName,"Scenario")) |> 
  select(ScenarioName_id,Label) |> 
  right_join(scenarios,
             by= c("ScenarioName_id"="scenario_id" ))


message("Loaded ", nrow(results), " ontology property rows.")
message("Loaded ", nrow(vocab_values), " vocabulary rows.")
message("Loaded ", nrow(scenarios), " data exchange scenarios.")


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


# UI specific functions and objects ----

#Lists to for multi-select options

hmis_element_choices <- hmis_elements$dataDictionaryName
names(hmis_element_choices) <- hmis_elements$selector_label
scenario_choices <- unique(scenarios_temp$Label) #UPDATE once "label" is in the Data Exchange Scenario ontology
RequestResponse_choices <- c("Full Schema", "Request Schema", "Response Schema")

# Build data dictionary text ----
DataDictionaryText <- read_excel("Foundation Layer/Ontology Generator/datasource/DataDictionaryAnnotations.xlsx", 1)

build_element_html <- function(df) {
  
  div(
    
    h2(
      paste(
        unique(df$`Element Identifier`),
        unique(df$`Element Name`)
      ),
      style = "color:#1f4e79;"
    ),
    
    lapply(
      c(
        "Element Type",
        "Funder: Program-Component",
        "Project Type Applicability",
        "Data Collected About",
        "Collection Point",
        "System Logic and Other System Issues",
        "CSV"
      ),
      function(field) {
        
        value <- df[[field]][1]
        
        if (!is.na(value) && nzchar(value)) {
          
          tagList(
            
            tags$h4(
              field,
              style = "margin-top:15px;margin-bottom:5px;"
            ),
            
            tags$p(
              value,
              style = "margin-bottom:10px;"
            )
            
          )
          
        }
        
      }
    ),
    
    tags$hr()
  )
}


#Function to build tables
# Build individual tables
build_dictionary_tables <- function(ids, dictionary){
  
  lapply(ids, function(id){
    
    x <- dictionary |>
      dplyr::filter(
        `Element Identifier` %in% id
      )
    
    list(
      title = paste0(
        x$`Element Identifier`,
        " ",
        x$`Element Name`
      ),
      tibble::tibble(
        Header = c(
          "Element Type",
          "Funder: Program-Component",
          "Project Type Applicability",
          "Data Collected About",
          "Collection Point",
          "System Logic & Other System Issues",
          "CSV"
        ),
        
        Instruction = c(
          x$`Element Type`,
          x$`Funder: Program-Component`,
          x$`Project Type Applicability`,
          x$`Data Collected About`,
          x$`Collection Point`,
          x$`System Logic and Other System Issues`,
          x$CSV
        )
      )
    )
  }) |>
    stats::setNames(ids)
  
}

# Preset card formats
cards <- list(
  card(
    full_screen = TRUE,
    card_header("Overview"),
    HomePage_overview
  ),
  card(
    full_screen = TRUE,
    card_header("Privacy and Security"),
    "Coming soon"
  ),
  card(
    full_screen = TRUE,
    card_header("Guides and Resources"),
    "Coming Soon"
  )
)



