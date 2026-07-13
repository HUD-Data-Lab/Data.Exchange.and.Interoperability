library(tidyverse)
library(readxl)
library(stringr)
library(yaml)
library(purrr)
library(glue)

# Functions to clean up text
nb2sp <- function(x) gsub("\u00A0", " ", x, fixed = TRUE) #non-breaking to space

# For IRI and local names (object property names, class names, individual names)
ttl_local <- function(x) {
  x <- nb2sp(trimws(as.character(x)))
  x[is.na(x) | x == ""] <- "unnamed"
  
  # Normalize Unicode punctuation → ASCII
  x <- iconv(x, from = "", to = "ASCII//TRANSLIT")
  
  # Replace anything not allowed in PN_LOCAL with "_"
  x <- gsub("[^A-Za-z0-9_]", "_", x)
  
  # Collapse repeated underscores
  x <- gsub("_+", "_", x)
  
  # Trim leading/trailing underscores
  x <- gsub("^_|_$", "", x)
  
  # Turtle QName rule: must NOT start with a digit
  starts_bad <- grepl("^[0-9]", x)
  
  x[starts_bad] <- paste0("_", x[starts_bad])
  
  x
}

# For literals (annotations such as prefLabel)

ttl_lit <- function(x) {
  x <- nb2sp(as.character(x))
  x[is.na(x)] <- ""
  x <- trimws(x)
  
  # Escape Turtle-sensitive characters
  x <- gsub("\\\\", "\\\\\\\\", x)   # backslash
  x <- gsub("\"", "\\\\\"", x)       # quotes
  x <- gsub("\n", "\\\\n", x)        # newlines
  x <- gsub("\r", "\\\\r", x)
  
  paste0("\"", x, "\"")
}


is_blank <- function(x) {
  x <- nb2sp(as.character(x))
  is.na(x) | trimws(x) == ""
}

clean_iri <- function(x) {
  x <- nb2sp(as.character(x))
  x <- trimws(x)
  x <- gsub("\\s+", "", x)              # remove any remaining whitespace
  x
}

# Functions for generating the Yaml file ----

# Read TTL file
read_ttl <- function(path) {
  txt <- readLines(path)
  
  # Remove comments + empty lines
  txt <- txt[!str_detect(txt, "^\\s*#")]
  txt <- txt[txt != ""]
  
  paste(txt, collapse = "\n")
}

# Extract classes
extract_classes <- function(ttl) {
  class_blocks <- str_extract_all(ttl, "([a-zA-Z0-9:]+)\\s+a\\s+owl:Class\\s*;[^.]*\\.")[[1]]
  
  data.frame(
    class_raw = str_extract(class_blocks, "^[^\\s]+"),
    name = str_replace(str_extract(class_blocks, "rdfs:label\\s+\"[^\"]+\""), "rdfs:label\\s+\"|\"", ""),
    stringsAsFactors = FALSE
  )
}

# Extract properties
extract_properties <- function(ttl) {
  prop_blocks <- str_extract_all(ttl, "([a-zA-Z0-9:]+)\\s+a\\s+owl:(DatatypeProperty|ObjectProperty)[^.]*\\.")[[1]]
  
  data.frame(
    prop = str_extract(prop_blocks, "^[^\\s]+"),
    label = str_replace(str_extract(prop_blocks, "rdfs:label\\s+\"[^\"]+\""), "rdfs:label\\s+\"|\"", ""),
    domain = str_extract(prop_blocks, "rdfs:domain\\s+[a-zA-Z0-9:]+") |> str_replace("rdfs:domain\\s+", ""),
    range = str_extract(prop_blocks, "rdfs:range\\s+[a-zA-Z0-9:]+") |> str_replace("rdfs:range\\s+", ""),
    stringsAsFactors = FALSE
  )
}

# Map XSD → OpenAPI types
map_type <- function(range) {
  case_when(
    str_detect(range, "xsd:string") ~ list(type = "string"),
    str_detect(range, "xsd:date") ~ list(type = "string", format = "date"),
    str_detect(range, "xsd:integer") ~ list(type = "integer"),
    TRUE ~ list(type = "string")
  )
}

# Build OpenAPI
build_openapi <- function(classes, props) {
  schemas <- list()
  paths <- list()
  
  for (i in seq_len(nrow(classes))) {
    class_name <- classes$name[i]
    class_uri <- classes$class_raw[i]
    
    # Properties for this class
    cls_props <- props %>% filter(domain == class_uri)
    
    properties <- list()
    
    for (j in seq_len(nrow(cls_props))) {
      prop <- cls_props[j, ]
      
      if (prop$range %in% classes$class_raw) {
        properties[[prop$label]] <- list(
          "$ref" = paste0("#/components/schemas/", classes$name[classes$class_raw == prop$range])
        )
      } else {
        properties[[prop$label]] <- map_type(prop$range)
      }
    }
    
    schemas[[class_name]] <- list(
      type = "object",
      properties = properties
    )
    
    # Create REST paths
    plural <- tolower(paste0(class_name, "s"))
    
    paths[[paste0("/", plural)]] <- list(
      get = list(
        summary = paste("List", class_name),
        responses = list(
          "200" = list(
            description = "Success",
            content = list(
              "application/json" = list(
                schema = list(
                  type = "array",
                  items = list("$ref" = paste0("#/components/schemas/", class_name))
                )
              )
            )
          )
        )
      )
    )
  }
  
  list(
    openapi = "3.0.3",
    info = list(
      title = "Ontology API",
      version = "0.1.0"
    ),
    paths = paths,
    components = list(schemas = schemas)
  )
}

# Run generator
generate_openapi <- function(ttl_file, output_file) {
  ttl <- read_ttl(ttl_file)
  
  classes <- extract_classes(ttl)
  props <- extract_properties(ttl)
  
  spec <- build_openapi(classes, props)
  
  write_yaml(spec, output_file)
  
  message("OpenAPI YAML generated: ", output_file)
}

# Example usage
#generate_openapi("output/Output_20260604_150242/hmis_ontology0604T1502_42.ttl", "generated_openapi.yaml")



generate_shape <- function(property,
                           domain,
                           scheme,
                           de = NA,
                           field = NA) {
  
  glue(
    '
hmis:{property}Shape
    a sh:NodeShape ;
    sh:targetClass hmis:{domain} ;

    sh:property [
        sh:path hmis:{property} ;

        sh:nodeKind sh:IRI ;
        sh:class skos:Concept ;

        sh:node [
            sh:property [
                sh:path skos:inScheme ;
                sh:hasValue hmis:{scheme} ;
            ]
        ] ;

        sh:message "{property} must be a valid value from the {scheme} vocabulary." ;
    ] .

'
  )
}


get_field_definition <- function(
    search_by,
    field_name,
    metadata,
    graph) {
  
  row <- if (search_by == "Data Element Name"){
    metadata %>%
      filter(dataDictionaryName == field_name)
  } else if (search_by == "Data Element Number") {
    metadata %>%
      filter(dataElementNumberAndField == field_name)
  }
  
  if(nrow(row) == 0)
    stop("Field not found")
  
  if(row$field_type[1] == "Enumeration") {
    
    scheme <- row$scheme[1]
    
    query <- glue::glue('
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?concept ?notation ?label
WHERE {{

  ?concept skos:inScheme <{scheme}> .

  OPTIONAL {{ ?concept skos:notation ?notation }}
  OPTIONAL {{ ?concept skos:prefLabel ?label }}

}}
')
     
    values <- rdf_query(graph, query)
    
    return(values)
    
  } else {
    
    return(
      tibble::tibble(
        datatype = row$range[1]
      )
    )
    
  }
}





