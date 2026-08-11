
# scripts/build_ontology_cache.R

library(rdflib)
library(dplyr)

ontology_path <- "Artifacts/Ontology/Output_v1.0.0-beta/hmis_ontologyv1.0.0-beta.ttl"
cache_path <- "Artifacts/Ontology/hmis_ontology_cache_v1.0.0-beta.rds"

dir.create(dirname(cache_path), recursive = TRUE, showWarnings = FALSE)

query_all <- '
PREFIX hmis: <http://www.semanticweb.org/61084/ontologies/2026/2/hmis#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl:  <http://www.w3.org/2002/07/owl#>

SELECT ?property ?dataDictionaryName ?dataElementNumber ?dataElementFieldNumber ?CSVExportTable ?domain ?range ?scheme
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

g <- rdf_parse(ontology_path, format = "turtle")


results <- rdf_query(g, query_all)

vocab_values <- rdf_query(g, query_vocab)

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

ontology_info <- file.info(ontology_path)

saveRDS(
  list(
    ontology_path = ontology_path,
    ontology_mtime = ontology_info$mtime,
    ontology_size = ontology_info$size,
    built_at = Sys.time(),
    properties = results_clean,
    vocab_values = vocab_values_clean
  ),
  cache_path
)

message("\nSaved ontology cache to: ", cache_path)
message("Property rows: ", nrow(results_clean))
message("Vocabulary rows: ", nrow(vocab_values_clean))
