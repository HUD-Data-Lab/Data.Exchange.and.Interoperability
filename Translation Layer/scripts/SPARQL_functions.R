

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



build_field_schema <- function(field_name,
                               metadata,
                               vocab_values) {
  
  field <- metadata %>%
    filter(property == field_name)
  
  if (nrow(field) == 0) {
    stop(paste("Field not found:", field_name))
  }
  
  field_type <- field$field_type[1]
  
  # Enumerated field
  if (field_type == "Enumeration") {
    
    
    vals <- vocab_values %>%
      filter(scheme == field$scheme[1])
    
    return(
      list(
        type = "string",
        
        enum = vals$label,
        
        `x-hmis-vocabulary` =
          field$dataElementNumberAndField[1],
        
        `x-hmis-values` =
          purrr::pmap(
            list(
              vals$notation,
              vals$label
            ),
            function(notation, label) {
              list(
                notation = notation,
                label = label
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
    type = schema_type
  )
  
  if (field_type == "Date") {
    schema$format <- "date"
  }
  
  if (field_type == "DateTime") {
    schema$format <- "date-time"
  }
  
  schema
}

build_resource_schema <- function(fields,
                                  metadata,
                                  vocab_values) {
  
  properties <- purrr::map(
    fields,
    build_field_schema,
    metadata = metadata,
    vocab_values = vocab_values
  )
  
  names(properties) <- fields
  
  list(
    type = "object",
    properties = properties
  )
}



