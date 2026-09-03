# server.R ----

server <- function(input, output, session) {

#Observers for testing
  observe({
    cat("\nselected_elements:\n")
    dput(input$selected_elements)
  })
  
  observe({
    cat("\nselectScenario:\n")
    dput(input$selectScenario)
  })
  
# Home Page ----  
  
  # Set the main table with filter
  updateSelectizeInput(
    session = session,
    inputId = "selectScenario"
  )
  
  scenarioSelected_metadata <- reactive({
    
    req(input$selectScenario)
    
    #Select the elements used in the scenario
    selected_elements <- scenarios_temp |>
      filter(Label == input$selectScenario) |>
      select(requestElement_id, responseElement_id) |>
      unlist(use.names = FALSE) |>
      unique()
    selected_elements <- selected_elements[!is.na(selected_elements)]
      
    #Build the table the shows the data elements used in the table  
    clean_MetaData %>%
      dplyr::filter(
        dataDictionaryName %in% selected_elements  |
          dataElementNumberAndField %in% selected_elements) %>%
      dplyr::select(
        dataDictionaryName,
        dataElementNumberAndField,
        field_type
      ) %>%
      dplyr::distinct() |> 
      arrange(dataElementNumberAndField)
  })
  
  output$scenarioSelected_table <- renderTable({
    req(input$selectScenario)
    scenarioSelected_metadata()
  })
  
  # Build the JSON Schemas
  openapi_object <- reactive({
    
    req(input$selectScenario)
    
    scenario_data <- scenarios_temp |>
      filter(Label == input$selectScenario)
    
    requestElements <- scenario_data |>
      pull(requestElement_id) |>
      unique()
    
    requestElements <- requestElements[!is.na(requestElements)]
    
    responseElements <- scenario_data |>
      pull(responseElement_id) |>
      unique()
    
    responseElements <- responseElements[!is.na(responseElements)]
    
    request_schema <- build_object_schema(
      fields = requestElements,
      metadata = clean_MetaData,
      vocab_values = clean_vocab_values
    )
    
    response_schema <- build_object_schema(
      fields = responseElements,
      metadata = clean_MetaData,
      vocab_values = clean_vocab_values
    )
    
    list(
      operationId = gsub("\\s+", "", input$selectScenario),
      requestBody = list(
        required = TRUE,
        content = list(
          `application/json` = list(
            schema = request_schema
          )
        )
      ),
      responses = list(
        `200` = list(
          description = "Successful response",
          content = list(
            `application/json` = list(
              schema = response_schema
            )
          )
        )
      )
    )
    
  })  

  # Render the outputs
  output$requestSchema_output <- renderText({
    
    req(openapi_object())
    
    jsonlite::toJSON(
      openapi_object()$requestBody,
      pretty = TRUE,
      auto_unbox = TRUE
    )
    
  })
  
  output$responseSchema_output <- renderText({
    
    req(openapi_object())
    
    jsonlite::toJSON(
      openapi_object()$responses$`200`,
      pretty = TRUE,
      auto_unbox = TRUE
    )
    
  })
  
  output$openapi_output <- renderText({
    
    req(openapi_object())
    
    jsonlite::toJSON(
      openapi_object(),
      pretty = TRUE,
      auto_unbox = TRUE
    )
    
  })
  
  #Download the OpenAPI JSON Script
  output$download_OpenAPIschema <- downloadHandler(
    
    filename = function() {
      paste0(
        "hmis_Fullschema_",
        Sys.Date(),
        ".json"
      )
    },
    
    content = function(file) {
      req(openapi_object())
      
      schema_json <- jsonlite::toJSON(
        openapi_object(),
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
  
  
# JSON Schema Builder Page ----
  
  updateSelectizeInput(
    session = session,
    inputId = "selected_elements",
    choices = hmis_element_choices,
    server = TRUE
  )
  
  #Reactive table of selected HMIS elements
  
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
  
  #Build Data Dictionary based on selected elements

  
  DataDictionary <- reactive({
    
    if (is.null(input$selected_elements) ||
        length(input$selected_elements) == 0) {
      
      return(NULL)
      
    }
    
    selected_dataelements <- clean_MetaData %>%
      dplyr::filter(
        dataDictionaryName %in% input$selected_elements |
          dataElementNumberAndField %in% input$selected_elements
      ) %>%
      pull(dataElementNumber) %>%
      unique()
    
    DataDictionaryText %>%
    filter(`Element Identifier` %in% selected_dataelements) %>%
    split(.$`Element Identifier`)
    
  })
  
  output$datadictionary_output <- renderUI({
    
    if (is.null(input$selected_elements) ||
        length(input$selected_elements) == 0) {
      
      return(
        div(
          class = "alert alert-info",
          "Select one or more HMIS Data Elements."
        )
      )
    }
    
    div(
      style = "
      max-height:700px;
      overflow-y:auto;
      padding:20px;
      border:1px solid #ddd;
      background:white;
    ",
      
      lapply(DataDictionary(), build_element_html)
      
    )
    
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
      null = "null")
    
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



