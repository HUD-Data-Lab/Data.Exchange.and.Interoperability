# build_cache.R ----
#
# Builds data/hmis_ontology_cache.rds, the tables the Shiny app reads at
# startup, from two files at the repository root:
#
#   FY26_HMIS_Logic_Model.ttl        the ontology: properties and code lists
#   api/DataExchangeScenarioList.md  the scenarios and the fields each uses
#
# Run it from the repository root whenever either file changes:
#
#   Rscript app/shiny/build_cache.R
#
# It also works from inside app/shiny. The app warns at startup when the
# ontology file's contents no longer match the cache.

suppressPackageStartupMessages({
  library(rdflib)
  library(dplyr)
})

root <- if (file.exists("FY26_HMIS_Logic_Model.ttl")) "." else file.path("..", "..")
ontology_path <- file.path(root, "FY26_HMIS_Logic_Model.ttl")
scenario_path <- file.path(root, "api", "DataExchangeScenarioList.md")
cache_path <- file.path(root, "app", "shiny", "data", "hmis_ontology_cache.rds")

RDF_TYPE <- "http://www.w3.org/1999/02/22-rdf-syntax-ns#type"
RDFS <- "http://www.w3.org/2000/01/rdf-schema#"
OWL <- "http://www.w3.org/2002/07/owl#"
SKOS <- "http://www.w3.org/2004/02/skos/core#"
DCTERMS_IDENTIFIER <- "http://purl.org/dc/terms/identifier"
HMIS <- "urn:hud:hmis:owl#"

local_name <- function(iri) sub("^.*[/#]", "", iri)

# Load every triple once. rdflib's SPARQL engine is slow with many OPTIONAL
# clauses, so the joins below are done in dplyr instead.
graph <- rdf_parse(ontology_path, format = "turtle")
triples <- rdf_query(graph, "SELECT ?s ?p ?o WHERE { ?s ?p ?o }") |>
  mutate(across(everything(), as.character))

objects_of <- function(predicate, name) {
  triples |>
    filter(p == predicate) |>
    distinct(s, o) |>
    rename(!!name := o)
}

# Properties ----

property_iris <- triples |>
  filter(p == RDF_TYPE, o %in% paste0(OWL, c("DatatypeProperty", "ObjectProperty"))) |>
  distinct(property = s)

datatype_properties <- triples |>
  filter(p == RDF_TYPE, o == paste0(OWL, "DatatypeProperty")) |>
  pull(s)

# A property is an HMIS data element field when its range is a datatype or a
# code list (skos:Concept), or when it is a datatype property with no range
# (the app shows those as type "Unknown" and treats them as strings).
# Object properties whose range is a class or missing (hasExit,
# enrollmentOfClient, partOf, ...) only link records together; like the
# structural properties in the old cache, they get no dataDictionaryName.
classes <- triples |>
  filter(p == RDF_TYPE, o == paste0(OWL, "Class")) |>
  distinct(s) |>
  pull(s)

# Identifiers such as "3.08" next to "3.08.1" name the element and the field;
# keep only the most specific ones.
identifiers <- objects_of(DCTERMS_IDENTIFIER, "identifier") |>
  rename(property = s) |>
  group_by(property) |>
  filter(!sapply(identifier, function(id) any(startsWith(identifier, paste0(id, "."))))) |>
  ungroup()

# The CSV table is recorded on the class (:CSVTableReference), so it is found
# through the property's rdfs:domain.
csv_tables <- objects_of(paste0(RDFS, "domain"), "domain") |>
  inner_join(objects_of(paste0(HMIS, "CSVTableReference"), "CSVExportTable"),
             by = c("domain" = "s")) |>
  group_by(property = s) |>
  summarise(CSVExportTable = paste(sort(unique(CSVExportTable)), collapse = ", "),
            .groups = "drop")

domains <- objects_of(paste0(RDFS, "domain"), "domain") |>
  group_by(property = s) |>
  summarise(domain = paste(sort(unique(domain)), collapse = ", "), .groups = "drop")

ranges <- objects_of(paste0(RDFS, "range"), "range") |>
  rename(property = s)

schemes <- objects_of(paste0(HMIS, "linkedVocabulary"), "scheme") |>
  rename(property = s)

properties <- property_iris |>
  left_join(identifiers, by = "property") |>
  left_join(domains, by = "property") |>
  left_join(ranges, by = "property") |>
  left_join(schemes, by = "property", relationship = "many-to-many") |>
  left_join(csv_tables, by = "property") |>
  mutate(
    is_field = !(range %in% classes) & (!is.na(range) | property %in% datatype_properties),
    dataDictionaryName = ifelse(is_field, local_name(property), NA_character_),
    # "4.02.N" -> element "4.02", field "N"; "V7.B" -> "V7", "B";
    # "3.917.2A" -> "3.917", "2A"; "FW.5" -> "FW", "5".
    dataElementNumber = sub("^([0-9]+\\.[0-9]+|[A-Z]+[0-9]*).*$", "\\1", identifier),
    dataElementFieldNumber = sub("^\\.", "",
                                 substring(identifier, nchar(dataElementNumber) + 1)),
    dataElementFieldNumber = ifelse(nzchar(dataElementFieldNumber), dataElementFieldNumber, NA),
    dataElementNumberAndField = identifier,
    property_id = local_name(property),
    domain_id = local_name(domain),
    range_id = local_name(range),
    scheme_id = local_name(scheme)
  ) |>
  select(-is_field) |>
  arrange(dataElementNumberAndField, property_id)

# Code lists ----

vocab_values <- objects_of(paste0(SKOS, "inScheme"), "scheme") |>
  rename(concept = s) |>
  left_join(objects_of(paste0(SKOS, "prefLabel"), "preflabel"), by = c("concept" = "s")) |>
  left_join(objects_of(paste0(SKOS, "notation"), "notation"), by = c("concept" = "s")) |>
  left_join(objects_of(paste0(SKOS, "altLabel"), "altlabel"), by = c("concept" = "s")) |>
  mutate(
    scheme_id = local_name(scheme),
    concept_id = local_name(concept),
    notation_key = trimws(notation),
    preflabel_key = tolower(trimws(preflabel)),
    # Keep each code list in notation order.
    notation_order = suppressWarnings(as.numeric(notation))
  ) |>
  arrange(scheme_id, notation_order, notation) |>
  select(scheme, concept, preflabel, notation, altlabel,
         scheme_id, concept_id, notation_key, preflabel_key)

# Scenarios ----

# Reads the Markdown table that follows a "## <heading>" line.
read_md_table <- function(lines, heading) {
  start <- which(lines == paste("##", heading))
  rows <- lines[seq(start + 1, length(lines))]
  rows <- rows[cumsum(startsWith(rows, "## ")) == 0]
  rows <- rows[startsWith(rows, "| ") & !grepl("^\\| ---", rows)]
  cells <- lapply(strsplit(sub("^\\| (.*) \\|$", "\\1", rows), " | ", fixed = TRUE),
                  function(x) gsub("\\\\\\|", "|", trimws(x)))
  table <- as.data.frame(do.call(rbind, cells[-1]), stringsAsFactors = FALSE)
  names(table) <- cells[[1]]
  table
}

scenario_lines <- readLines(scenario_path, encoding = "UTF-8", warn = FALSE)
scenario_list <- read_md_table(scenario_lines, "Scenarios")
mapping <- read_md_table(scenario_lines, "Scenario mapping")

# One row per scenario field: the scenario columns are "<ScenarioName>Request"
# and "<ScenarioName>Response" ("UpdateClientRequst" is spelled that way).
scenario_columns <- setdiff(names(mapping), c("Class", "CSVTable", "DE#", "DataElement",
                                              "FieldNumber", "Name", "dataExchangeOntologyName"))
de_scenarios <- bind_rows(lapply(scenario_columns, function(column) {
  used <- mapping$dataExchangeOntologyName[mapping[[column]] == "x"]
  is_request <- grepl("Requ?e?st$", column)
  tibble(
    ScenarioName = sub("(Requ?e?st|Response)$", "", column),
    requestElement_id = if (is_request) used else NA_character_,
    responseElement_id = if (is_request) NA_character_ else used
  )
})) |>
  filter(!is.na(requestElement_id) | !is.na(responseElement_id)) |>
  left_join(scenario_list |> select(ScenarioName, httpMethod = Method, Label),
            by = "ScenarioName") |>
  mutate(scenario_id = paste0(ScenarioName, "Scenario")) |>
  select(scenario_id, ScenarioName, Label, httpMethod, requestElement_id, responseElement_id)

missing <- setdiff(c(de_scenarios$requestElement_id, de_scenarios$responseElement_id),
                   c(properties$dataDictionaryName, NA))
if (length(missing) > 0) {
  stop("Scenario fields that are not FY26 properties: ", paste(missing, collapse = ", "))
}

# Save ----

ontology_info <- file.info(ontology_path)
saveRDS(
  list(
    ontology_path = "FY26_HMIS_Logic_Model.ttl",
    ontology_mtime = ontology_info$mtime,
    ontology_size = ontology_info$size,
    ontology_md5 = unname(tools::md5sum(ontology_path)),
    built_at = Sys.time(),
    properties = properties,
    vocab_values = vocab_values,
    de_scenarios = de_scenarios
  ),
  cache_path
)

message("Saved ontology cache to: ", cache_path)
message("Property rows: ", nrow(properties),
        " (", sum(!is.na(properties$dataDictionaryName)), " data element fields)")
message("Vocabulary rows: ", nrow(vocab_values))
message("Scenario rows: ", nrow(de_scenarios), " across ",
        n_distinct(de_scenarios$scenario_id), " scenarios")
