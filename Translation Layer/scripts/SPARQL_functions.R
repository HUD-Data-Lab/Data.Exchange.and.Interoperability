library(rdflib)
library(dplyr)


# SPARQL Queries used in build_ontology_cache ----
# Use these to model sparql queries to put the ontology into table format

# This pulls all the data element names and related annotations (metadata such as associated CSV tables)
query_all <- '
PREFIX hmis: <http://www.semanticweb.org/ontologies/hmis#> #This needs to match the ontology IRI exactly
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl:  <http://www.w3.org/2002/07/owl#>

SELECT ?property ?dataDictionaryName ?dataElementNumber ?dataElementFieldNumber 
?CSVExportTable ?domain ?range ?scheme
WHERE {

  {
    ?property a owl:ObjectProperty .
  }
  UNION
  {
    ?property a owl:DatatypeProperty .
  }

  OPTIONAL { ?property hmis:dataDictionaryName ?dataDictionaryName . }
  OPTIONAL { ?property hmis:dataElementNumber ?dataElementNumber . }
  OPTIONAL { ?property hmis:dataElementFieldNumber ?dataElementFieldNumber . }
  OPTIONAL { ?property hmis:CSVExportTable ?CSVExportTable . }
  OPTIONAL { ?property rdfs:domain ?domain . }
  OPTIONAL { ?property rdfs:range ?range . }
  OPTIONAL { ?property hmis:linkedVocabulary ?scheme . }
}
'
# This pulls all of the list values 
query_vocab <- '
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?scheme ?concept ?preflabel ?notation ?altlabel
WHERE {

  ?concept skos:inScheme ?scheme .

  OPTIONAL { ?concept skos:prefLabel ?preflabel . }
  OPTIONAL { ?concept skos:notation ?notation . }
  OPTIONAL { ?concept skos:altLabel ?altlabel . }
}
'
#This pulls the scenarios and groups data element names into two categories (request and response)
query_deScenarios <- '
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX de:   <http://www.semanticweb.org/ontologies/hmis/de#>

SELECT ?scenario ?httpMethod ?requestElement ?responseElement
WHERE {

  ?scenario rdfs:subClassOf de:Scenario .

  OPTIONAL { ?scenario de:httpMethod ?httpMethod . }
  OPTIONAL { ?scenario de:requestElement ?requestElement . }
  OPTIONAL { ?scenario de:responseElement ?responseElement . }

}
ORDER BY ?scenario ?requestElement ?responseElement

'


# Shape function (NOT COMPLETE) ----

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
    field_name,
    metadata,
    graph) {

  field <- metadata %>%
    filter(
      dataDictionaryName == field_name |
        dataElementNumberAndField == field_name
    )
  
  if (nrow(field) == 0) {
    stop(
      paste(
        "Field not found:",
        field_name
      )
    )
  }
  
  if(field$field_type[1] == "Enumeration") {
    
    scheme <- field$scheme[1]
    
    query <- glue::glue('
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?concept ?notation ?altlabel
WHERE {{

  ?concept skos:inScheme <{scheme}> .

  OPTIONAL {{ ?concept skos:notation ?notation }}
  OPTIONAL {{ ?concept skos:altLabel ?altlabel }}

}}
')
    
    values <- rdf_query(graph, query)
    
    return(values)
    
  } else {
    
    return(
      tibble::tibble(
        datatype = field$range[1]
      )
    )
    
  }
}


build_field_schema <- function(value,
                               metadata,
                               vocab_values) {
  
  field <- metadata %>%
    filter(
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
  
  field_type <- field$field_type[1]
  
  # Enumerated field
  if (field_type == "Enumeration") {
    
    
    vals <- vocab_values %>%
      filter(scheme == field$scheme[1])
    
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





# Build JSON/YAML Schemas ----

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

#For reference

# build_object_schema <- function(
#     fields,
#     metadata,
#     vocab_values
# ) {
#   
#   properties <- purrr::set_names(
#     lapply(
#       fields,
#       build_field_schema,
#       metadata = metadata,
#       vocab_values = vocab_values
#     ),
#     fields
#   )
#   
#   list(
#     type = "object",
#     properties = properties
#   )
# }

build_object_schema <- function(
    fields,
    metadata,
    vocab_values
) {
  
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




## Added to perform a quick QA check in translator.
## Definitely more verbose than it needs to be, but it works!

check_skos_notation_integrity <- function(df) {
  
    multi_notation <- clean_vocab_values %>% 
      select(c("concept", "notation")) %>% 
      unique(.) %>%
      count(concept) %>% 
      filter(n > 1)
    
    ct_multi_notation <- nrow(multi_notation) 
    
    if( ct_multi_notation == 0) {
      message("All concepts have only one notation")
    } else {
      
      message(glue("{ct_multi_notation} concepts have multiple associated notations")) 
      
      choices <- c("Yes", "No") 
      ans <- menu(choices, title = "Save and view details?")
      print(choices[ans]) 
      
      if (choices[ans] == "Yes") {
      vocab_w_multi_notation <<- clean_vocab_values %>% 
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
      view(vocab_w_multi_notation)
      }
      
    } 
}




