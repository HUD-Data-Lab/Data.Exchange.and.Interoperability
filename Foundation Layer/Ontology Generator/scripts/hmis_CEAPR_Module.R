library(writexl)
# Build a reporting Ontology for the CE APR

g <- rdf_parse("Artifacts/Ontology/Output_v1.0.0-beta/hmis_ontologyv1.0.0-beta.ttl", format = "turtle")

# CE APR Ontology Lists
# should I include the ids? Such as PersonalID? 


ceAPR_Fundamentals <- c("2.02.5","2.09","2.09.1","2.03.1","4.19.1",
                        "4.20.1","5.06","3.16.1","3.15","4.19.1","3.03")

ceAPR_Q4 <- c("2.01.2","2.01.1","2.02.2","2.02.1",
              "2.02.6","2.02.6A","2.09.1","2.02.6B",
              "2.02.6C", "2.03.1","2.03.2","2.01.3")
ceAPR_Q5 <- c("2.02.6","3.03.1","3.15.1","3.11.1",
              "3.10.1","3.07.1","3.917","3.08")
ceAPR_Q6 <- c("3.01","3.02","3.03","3.04")
ceAPR_Q7a <- c("3.03.1","3.15.1")
ceAPR_Q8a <- c("4.19","4.20","3.15","3.03")
ceAPR_Q9a <- c("4.19.3")
ceAPR_Q9b <- c("4.19.7")
ceAPR_Q9c <- c("4.20.2","4.20.A","4.19.1","2.02.1")
ceAPR_Q9d <- c("4.20.2","4.20.D")
ceAPR_Q10 <- c("4.19.4","4.20.2","4.20.A",
               "4.20.B","4.20.D","4.19.4")


#HMIS Glossary Reporting Reference
ActiveClients <- c("2.02", "3.10", "3.11", "3.20", "4.12",
                   "4.14", "W1", "P1", "R14", "V2")
Age <- c("3.03","3.10")
HouseholdTypes <- c("5.09",Age)
UNduplicatedClntHHCountsByHHType <- c("5.08","5.09","3.15")
ChronicHomelessStatus <- c("2.02", "3.08", "3.10", "3.917", "4.12", 
                           "4.05", "4.06", "4.07", 
                          "4.08", "4.09", "4.10")

ceAPR_Questions <- list(
  Q4 = ceAPR_Q4,
  Q5 = ceAPR_Q5,
  Q6 = ceAPR_Q6,
  Q7a = ceAPR_Q7a,
  Q8a = ceAPR_Q8a,
  Q9a = ceAPR_Q9a,
  Q9b = ceAPR_Q9b,
  Q9c = ceAPR_Q9c,
  Q9d = ceAPR_Q9d,
  Q10 = ceAPR_Q10,
  ActiveClients = ActiveClients,
  Age = Age,
  HouseholdTypes = HouseholdTypes,
  UNduplicatedClntHHCountsByHHType = UNduplicatedClntHHCountsByHHType,
  ChronicHomelessStatus = ChronicHomelessStatus
)

ceAPR_AllElements <- sort(
  unique(unlist(ceAPR_Questions, use.names = FALSE))
)


# Extract graph objects ----

## SPARQL body to extract ontology DATA PROPERTIES
query_all <- '
PREFIX hmis: <http://www.semanticweb.org/61084/ontologies/2026/2/hmis#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?property ?dataDictionaryName ?dataElementNumber ?dataElementFieldNumber ?CSVExportTable ?domain ?range ?scheme
WHERE {

  ?property a ?type .

  FILTER(
      STRENDS(STR(?type), "ObjectProperty") ||
      STRENDS(STR(?type), "DatatypeProperty")
  )


  OPTIONAL { ?property hmis:dataDictionaryName ?dataDictionaryName . }
  OPTIONAL { ?property hmis:dataElementNumber ?dataElementNumber . }
  OPTIONAL { ?property hmis:dataElementFieldNumber ?dataElementFieldNumber . }
  OPTIONAL { ?property hmis:CSVExportTable ?CSVExportTable . }
  OPTIONAL { ?property rdfs:domain ?domain . }
  OPTIONAL { ?property rdfs:range ?range . }
  OPTIONAL { ?property hmis:linkedVocabulary ?scheme . }
}
'

## Execute SPARQL queries on graph
results <- rdf_query(g, query_all)

results_Clean <- results |> 
  select(property,dataDictionaryName,dataElementNumber,dataElementFieldNumber) |> 
  filter(dataDictionaryName != "NA") |> 
  mutate(dataElementNumberField = paste0(dataElementNumber,".",dataElementFieldNumber)) |> 
  distinct()

CEAPR_dataElementReferences <- results_Clean |> 
  mutate(
    IncludedinCEAPR = case_when(
      dataElementNumberField %in% ceAPR_AllElements | dataElementNumber %in% ceAPR_AllElements ~ "Yes",
      TRUE ~ "No")) |> 
  filter(IncludedinCEAPR == "Yes") |> 
  select(dataDictionaryName,dataElementNumberField,IncludedinCEAPR)
      
writexl::write_xlsx(CEAPR_dataElementReferences,"Foundation Layer/Ontology Generator/output/ceAPRDataElementRef4.xlsx")
         