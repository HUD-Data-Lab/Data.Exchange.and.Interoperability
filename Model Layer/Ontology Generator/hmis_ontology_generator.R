
# To run everything
{

# Step 1: ----
#Load the functions used in creating the owl files. These set the strings to allowable characters
source("Ontology_functions.R")

  
# Step 2: ----
# Set the ontology IRI and load the data used to create the ontology

HMIS <- "http://www.semanticweb.org/61084/ontologies/2026/2/hmis#" #This will be the IRI for the ontology

core_classes <- read_xlsx("datasource/SkosVocabulary.xlsx", sheet = 2)
class_relationships <- read_xlsx("datasource/SkosVocabulary.xlsx", sheet = 3)
skos_concepts <- read_xlsx("datasource/SkosVocabulary.xlsx", sheet = 4)
skos_conceptScheme <- read_xlsx("datasource/SkosVocabulary.xlsx", sheet = 5)
dataProperty <- read_xlsx("datasource/SkosVocabulary.xlsx", sheet = 6)
objectProperty <- read_xlsx("datasource/SkosVocabulary.xlsx", sheet = 7)

# Step 3: ---
#Set the prefixes and create the owl files for the foundation layers

ttl_header <- c(
  paste0("@prefix hmis: <", HMIS, "> ."),
  "@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .",
  "@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .",
  "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .",
  "@prefix owl:  <http://www.w3.org/2002/07/owl#> .",
  "@prefix skos: <http://www.w3.org/2004/02/skos/core#> .",
  ""
)

source("hmis_coreClasses_generator.R")
source("hmis_dataProperty_generator.R")
source("hmis_objectProperty_generator.R")
source("hmis_skosVocabularies.R")

#Step 4 ----
#Generate the ontology files
{
date_Foldertag <- format(Sys.time(), "%Y%m%d_%H%M%S") #or "%Y%m%d" for just the date no time
date_Filetag <- format(Sys.time(), "%m%dT%H%M_%S") #or "%Y%m%d" for just the date no time
dated_dir <- file.path("output", paste0("Output_", date_Foldertag))
# Ensure directories exist
dir.create(dated_dir, recursive = TRUE, showWarnings = FALSE)
}

{
#Set the core classes
writeLines(c(ttl_header, classes, coreClassObjProps),
           file.path(dated_dir,paste0("hmis_coreClasses",date_Filetag,".ttl")),useBytes = TRUE) 

#Add the Skos vocabularies (HMIS Data Lists)
writeLines(c(ttl_header, skosClasses,skosConceptScheme,skosConcept),
           file.path(dated_dir,paste0("hmis_skosVocabularies",date_Filetag,".ttl")),useBytes = TRUE) 

#Add in the HMIS Data Elements (Data and object properties)
writeLines(c(ttl_header, dataProp, objProp),
           file.path(dated_dir,paste0("hmis_dataPropertiesObjectProperties",date_Filetag,".ttl")), useBytes = TRUE)

#Full RDF/OWL of HMIS Ontology
writeLines(c(ttl_header,classes,coreClassObjProps, skosConceptScheme,skosConcept,dataProp,objProp),
           file.path(dated_dir,paste0("hmis_ontology",date_Filetag,".ttl")), useBytes = TRUE)
}
}






