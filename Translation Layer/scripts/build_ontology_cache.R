
# scripts/build_ontology_cache.R
source("Foundation Layer/Ontology Generator/scripts/Ontology_functions.R")
source("Translation Layer/scripts/SPARQL_functions.R")
source("Translation Layer/scripts/hmis_dataExchange_ontology_generator.R")

# Set the paths ----
ontology_path <- "Artifacts/Ontology/Output_v1.3.0-beta/hmisDataExchange_ontologyv1.3.0-beta.ttl"
cache_path <- "Artifacts/Ontology/Output_v1.3.0-beta/hmis_ontology_cache_v1.3.0-beta.rds"

dir.create(dirname(cache_path), recursive = TRUE, showWarnings = FALSE)

# Load the ontology ----
g <- rdf_parse(ontology_path, format = "turtle")

# Run the SPARQL over the ontology ----

# pulls the data elements and annotations (metadata)
results <- rdf_query(g, query_all)

#Pull the lists for the enumerated values
vocab_values <- rdf_query(g, query_vocab)

# Pull the data needed to build Data Exchange Scenarios
Scenarios <- rdf_query(g, query_deScenarios)

# Clean up the query tables ----

results_clean <- results |>
  mutate(
    across(everything(), as.character),
    dataDictionaryName_key = tolower(trimws(dataDictionaryName)),
    dataElementNumber_key = trimws(dataElementNumber),
    property_id = sub("^.*[/#]", "", property),
    domain_id = sub("^.*[/#]", "", domain),
    range_id = sub("^.*[/#]", "", range),
    scheme_id = sub("^.*[/#]", "", scheme)
  )

vocab_values_clean <- vocab_values |>
  mutate(
    across(everything(), as.character),
    scheme_id = sub("^.*[/#]", "", scheme),
    concept_id = sub("^.*[/#]", "", concept),
    notation_key = trimws(notation),
    preflabel_key = tolower(trimws(preflabel))
  )


scenarios_clean <- Scenarios |>
  mutate(
    across(everything(), as.character),
    scenario_id = sub("^.*[/#]", "", scenario),
    requestElement_id  = sub("^.*[/#]", "", requestElement),
    responseElement_id = sub("^.*[/#]", "", responseElement)
  )


# Save the ontology files as a RDS cache ----

ontology_info <- file.info(ontology_path)

saveRDS(
  list(
    ontology_path = ontology_path,
    ontology_mtime = ontology_info$mtime,
    ontology_size = ontology_info$size,
    built_at = Sys.time(),
    properties = results_clean,
    vocab_values = vocab_values_clean,
    de_scenarios = scenarios_clean
  ),
  cache_path
)

message("\nSaved ontology cache to: ", cache_path)
message("Property rows: ", nrow(results_clean))
message("Vocabulary rows: ", nrow(vocab_values_clean))
message("Scenario rows: ", nrow(scenarios_clean))
