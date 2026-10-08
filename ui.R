# ui.R ----


ui <- page_navbar(
  title = "HMIS Data Exchange Product Suite",
  id = "page",
  theme = bs_theme(bootswatch = "lumen"), #update to this? https://posit-dev.github.io/brand-yml/
  nav_panel("Home",
            page_fluid(
                cards[[1]]
              )),
  nav_panel("Explore the HMIS Data Model",
            page_fluid(
              page_sidebar(
                sidebar =list( 
                  selectizeInput(
                    inputId = "selected_elements",
                    label = "Select HMIS Data Elements",
                    choices = NULL,
                    multiple = TRUE,
                    options = list(
                      placeholder = "Search by data dictionary name, element number, or field type",
                      plugins = list("remove_button"),
                      maxItems = NULL
                    )), br(),
                  downloadButton(
                    outputId = "download_schema",
                    label = "Download JSON"
                  )
                ),
                card(
                  full_screen = FALSE,
                  card_header("Introduction"),
                  "Use this tab to explore the HMIS data elements and generate a custom JSON schema. 
                  To see the response lists for any enumerated field please generate a JSON schema."
                ),
                
                accordion(
                  open = c("Selected HMIS Data Elements"),
                  accordion_panel(
                    "Selected HMIS Data Elements",
                    navset_pill(
                      nav_panel(
                        "Data Table",
                        tableOutput("selected_table")),
                      nav_panel(
                        "Data Dictionary",
                        uiOutput("datadictionary_output")),
                      nav_panel(
                        "JSON Schema",
                        verbatimTextOutput("schema_output")
                      )
                    ))
                )
              ))),
  nav_panel("HMIS Data Exchange Scenarios", 
            page_fluid(
              page_sidebar(
                sidebar = list(
                  selectizeInput(
                    inputId = "selectScenario",
                    label = "Select Baseline Scenario:",
                    choices = c("", scenario_choices),
                    selected = NULL,
                    multiple = FALSE,
                    options = list(
                    placeholder = "Choose a scenario...",
                    allowEmptyOption = TRUE
                    )), br(),
                    downloadButton(
                      outputId = "download_OpenAPIschema",
                      label = "Download Full Schema"
                    )
                  ),
                accordion(
                  open = FALSE,
                  accordion_panel(
                    "HMIS Data Elements",
                    navset_pill(
                      nav_panel(
                        "Summary Table:",
                        tableOutput("scenarioSelected_table")),
                      nav_panel(
                        "Data Dictionary",
                        uiOutput("datadictionaryscenario_output")),
                    
                  )), 
                  br(),
                  card(
                    "JSON Schemas",
                    navset_pill_list(
                      nav_panel("Full Schema", verbatimTextOutput("openapi_output")),
                      nav_panel("Request",verbatimTextOutput("requestSchema_output") ),
                      nav_panel("Response", verbatimTextOutput("responseSchema_output")))
                    )
                ))))
)