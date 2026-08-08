library(yaml)

# To be OpenAPI compliant we need the path


# Step 1: Define the  ----


# Blank Template ----

library(yaml)

openapi_template <- list(
  
  openapi = "3.1.1",
  info = list( # Info section ----
    title = "HMIS API Specifications", #Allow custom input?
    version = "1.0.0",
    license = list(
        name = "The MIT License (MIT)",
        url = "https://mit-license.org/"
    ),
    description = "This is a generated API specification to define the expected request and response schemas needed for a data exchange project"
  ),
  servers = list(
    list(
      url = "http://urldemo",
      description = "Please reach out to your HMIS vendor for this item" 
    )
  ),
  paths = list(
    
  ),
  
  components = list(
    schemas = list(),
    parameters = list(),
    requestBodies = list(),
    responses = list(),
    securitySchemes = list(
      BasicAuth = list(
        type = "http",
        scheme = "basic"
      )
    )
    
  ),
  
  security = list(
    list(
      BasicAuth = list()
    )
  )
)


cat(as.yaml(openapi_template))

write_yaml(
  openapi_template,
  "openapi.yaml"
)