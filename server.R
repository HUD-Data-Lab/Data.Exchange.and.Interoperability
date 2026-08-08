# server.R ----

server <- function(input, output, session) {
  
  # Load selectize choices after app starts.
  # This works better than putting all choices directly in ui.R,
  # especially if your ontology has many data elements.
  
  updateSelectizeInput(
    session = session,
    inputId = "selected_elements",
    choices = hmis_element_choices,
    server = TRUE
  )
  
  
  # Reactive table of selected HMIS elements
  
  selected_metadata <- reactive({
    
    req(input$selected_elements)
    
    clean_MetaData %>%
      dplyr::filter(
        dataDictionaryName %in% input$selected_elements |
          dataElementNumberAndField %in% input$selected_elements
      ) %>%
      dplyr::select(
        dataDictionaryName,
        dataElementNumberAndField,
        CSVExportTable,
        field_type
      ) %>%
      dplyr::distinct()
  })
  
  
  output$selected_table <- renderTable({
    
    req(input$selected_elements)
    
    selected_metadata()
    
  })
  
  
  # Build schema only when button is clicked
  
  generated_schema <- eventReactive(input$build_schema, {
    
    req(input$selected_elements)
    
    build_object_schema(
      fields = input$selected_elements,
      metadata = clean_MetaData,
      vocab_values = clean_vocab_values
    )
    
  })
  
  
  # Render JSON in the app
  
  output$schema_output <- renderText({
    
    req(generated_schema())
    
    jsonlite::toJSON(
      generated_schema(),
      pretty = TRUE,
      auto_unbox = TRUE,
      null = "null"
    )
    
  })
  
  
  # Download JSON file
  
  output$download_schema <- downloadHandler(
    
    filename = function() {
      paste0(
        "hmis_schema_",
        Sys.Date(),
        ".json"
      )
    },
    
    content = function(file) {
      
      schema_json <- jsonlite::toJSON(
        generated_schema(),
        pretty = TRUE,
        auto_unbox = TRUE,
        null = "null"
      )
      
      writeLines(
        schema_json,
        con = file
      )
    }
  )
}