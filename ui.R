# ui.R ----

ui <- fluidPage(
  
  titlePanel("HMIS Ontology JSON Schema Builder"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectizeInput(
        inputId = "selected_elements",
        label = "Select HMIS Data Elements",
        choices = NULL,
        multiple = TRUE,
        options = list(
          placeholder = "Search by data dictionary name, element number, or field type",
          plugins = list("remove_button"),
          maxItems = NULL
        )
      ),
      
      br(),
      
      actionButton(
        inputId = "build_schema",
        label = "Build JSON Schema",
        class = "btn-primary"
      ),
      
      br(),
      br(),
      
      downloadButton(
        outputId = "download_schema",
        label = "Download JSON"
      )
    ),
    
    mainPanel(
      
      h4("Selected HMIS Data Elements"),
      
      tableOutput("selected_table"),
      
      br(),
      
      h4("Generated JSON Schema"),
      
      verbatimTextOutput("schema_output")
    )
  )
)