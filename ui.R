# ui.R ----


ui <- page_navbar(
  title = "HMIS API Product Suite",
  id = "page",
  theme = bs_theme(bootswatch = "lumen"), #update to this? https://posit-dev.github.io/brand-yml/
  nav_panel("Home", 
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
                    "HMIS Data Elements Used in this Scenario:",
                    tableOutput("scenarioSelected_table")
                  ), br(),
                  card(
                    "JSON Schemas",
                    navset_pill_list(
                      nav_panel("Full Schema", verbatimTextOutput("openapi_output")),
                      nav_panel("Request",verbatimTextOutput("requestSchema_output") ),
                      nav_panel("Response", verbatimTextOutput("responseSchema_output")))
                    )
                )))),
  nav_panel("JSON Schema Builder",
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
                actionButton(
                  inputId = "build_schema",
                  label = "Build JSON Schema",
                  class = "btn-primary"
                ),
                downloadButton(
                  outputId = "download_schema",
                  label = "Download JSON"
                )
              ),
              accordion(
                open = c("Selected HMIS Data Elements","Generated JSON Schema"),
                accordion_panel(
                  "Selected HMIS Data Elements",
                    tableOutput("selected_table")
                  ),
                br(),
                accordion_panel(
                  "Generated JSON Schema",
                    verbatimTextOutput("schema_output")
                  )
                )
                ))),
  nav_panel("Example", 
            page_fluid(
              page_sidebar(
                sidebar = 
                  selectInput(
                    "selectScenario",
                    "Select Baseline Scenario:",
                    scenario_choices,
                    multiple = FALSE
                  ),
                cards[[1]],
                layout_columns(cards[[2]],cards[[3]])
              )))
)