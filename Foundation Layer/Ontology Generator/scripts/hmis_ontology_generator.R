
# To run everything
{

# Step 1: ----
#Load the functions used in creating the owl files. These set the strings to allowable characters
source("Foundation Layer/Ontology Generator/scripts/Ontology_functions.R")

  
# Step 2: ----
# Set the ontology IRI and load the data used to create the ontology

HMIS <- "http://www.semanticweb.org/ontologies/hmis#" #This will be the IRI for the ontology

core_classes <- read_xlsx("Foundation Layer/Ontology Generator/datasource/SkosVocabulary.xlsx", sheet = 2)
class_relationships <- read_xlsx("Foundation Layer/Ontology Generator/datasource/SkosVocabulary.xlsx", sheet = 3)
skos_concepts <- read_xlsx("Foundation Layer/Ontology Generator/datasource/SkosVocabulary.xlsx", sheet = 4)
skos_conceptScheme <- read_xlsx("Foundation Layer/Ontology Generator/datasource/SkosVocabulary.xlsx", sheet = 5)
dataProperty <- read_xlsx("Foundation Layer/Ontology Generator/datasource/SkosVocabulary.xlsx", sheet = 6) |> 
  filter(Enum_Scalar == "Scalar")|> 
  select(-Enum_Scalar)
objectProperty <- read_xlsx("Foundation Layer/Ontology Generator/datasource/SkosVocabulary.xlsx", sheet = 6) |> 
  filter(Enum_Scalar == "Enum") |> 
  select(-Enum_Scalar)
  

# Step 3: ---
#Set the prefixes and create the owl files for the foundation layers

ttl_header <- c(
  paste0("@prefix hmis: <", HMIS, "> ."),
  "@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .",
  "@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .",
  "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .",
  "@prefix owl:  <http://www.w3.org/2002/07/owl#> .",
  "@prefix skos: <http://www.w3.org/2004/02/skos/core#> .",
  "@prefix dct: <http://purl.org/dc/terms/> .",
  paste0("@base <", HMIS, "> ."),
  "",
  "<http://www.semanticweb.org/61084/ontologies/2026/2/hmis> rdf:type owl:Ontology ;",
  "  dct:description \"Ontology representing HMIS data standards.\"@en ;" ,
  "  dct:title \"HMIS Ontology\"@en ;", 
  "  rdfs:seeAlso <https://www.hudexchange.info/resource/3824/hmis-data-dictionary/> .",
  ""

)

source("Foundation Layer/Ontology Generator/scripts/hmis_coreClasses_generator.R")
source("Foundation Layer/Ontology Generator/scripts/hmis_dataProperty_generator.R")
source("Foundation Layer/Ontology Generator/scripts/hmis_objectProperty_generator.R")
source("Foundation Layer/Ontology Generator/scripts/hmis_skosVocabularies.R")

#Step 4 ----
#Generate the ontology files
{
ontology_version <- "v1.3.0-beta" #format for version numbering is: "v[major].[minor].[patch]" [-beta] is only used for the initial development of v1.0.0
date_Foldertag <- format(Sys.time(), "%Y%m%d_%H%M%S") #or "%Y%m%d" for just the date no time
date_Filetag <- format(Sys.time(), "%m%dT%H%M_%S") #or "%Y%m%d" for just the date no time
dated_dir <- file.path("Foundation Layer/Ontology Generator/output", paste0("Output_", date_Foldertag))
Final_Ontology <- file.path("Artifacts/Ontology", paste0("Output_", ontology_version))
# Ensure directories exist
dir.create(dated_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(Final_Ontology, recursive = TRUE, showWarnings = FALSE)
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

#Create the ontology file that the Translation Layer will use
{
  writeLines(c(ttl_header,classes,coreClassObjProps, skosConceptScheme,skosConcept,dataProp,objProp),
             file.path(Final_Ontology,paste0("hmis_ontology",ontology_version,".ttl")), useBytes = TRUE)
}

}






