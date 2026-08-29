library(rdflib)
library(magrittr)

HMIS <- "http://www.semanticweb.org/61084/ontologies/2026/2/hmis#" #This will be the IRI for the ontology
API <- "http://www.semanticweb.org/61084/ontologies/2026/2/hmis/api#" #This will be the IRI for the API ontology
RDF <- "http://www.w3.org/1999/02/22-rdf-syntax-ns#" #This is the IRI for rdf
RDFS <- "http://www.w3.org/2000/01/rdf-schema#" #This is for RDF schema. Used for things like label
OWL <- "http://www.w3.org/2002/07/owl#" #This is the IRI for owl


#g <- rdf()
g <- rdf_parse("Artifacts/Ontology/Output_v1.1.0-beta/hmis_ontologyv1.1.0-beta.ttl", format = "turtle")

#Add Scenario and Endpoint Classes to the API ontology

rdf_add(
  g,
  subject   = paste0(API,"Scenario"),
  predicate = paste0(RDF,"type"),
  object    = paste0(OWL,"Class")
)

rdf_add(
  g,
  subject   = paste0(API,"Scenario"),
  predicate = paste0(RDFS,"label"),
  object    = "Scenarios"
)

rdf_add(
  g,
  subject   = paste0(API,"Endpoint"),
  predicate = paste0(RDF,"type"),
  object    = paste0(OWL,"Class")
)

rdf_add(
  g,
  subject   = paste0(API,"Endpoint"),
  predicate = paste0(RDFS,"label"),
  object    = "Endpoint"
)

#Add data subclasses to endpoint ----

#Get subclass

rdf_add(
  g,
  subject   = paste0(API,"Get"),
  predicate = paste0(RDF,"type"),
  object    = paste0(OWL,"Class")
)

rdf_add(
  g,
  subject   = paste0(API,"Get"),
  predicate = paste0(RDFS,"subClassOf"),
  object    = paste0(OWL,"Endpoint")
)

#Patch subclass

rdf_add(
  g,
  subject   = paste0(API,"Patch"),
  predicate = paste0(RDF,"type"),
  object    = paste0(OWL,"Class")
)

rdf_add(
  g,
  subject   = paste0(API,"Patch"),
  predicate = paste0(RDFS,"subClassOf"),
  object    = paste0(OWL,"Endpoint")
)

#Post subclass

rdf_add(
  g,
  subject   = paste0(API,"Post"),
  predicate = paste0(RDF,"type"),
  object    = paste0(OWL,"Class")
)

rdf_add(
  g,
  subject   = paste0(API,"Post"),
  predicate = paste0(RDFS,"subClassOf"),
  object    = paste0(OWL,"Endpoint")
)

#Delete subclass

rdf_add(
  g,
  subject   = paste0(API,"Delete"),
  predicate = paste0(RDF,"type"),
  object    = paste0(OWL,"Class")
)

rdf_add(
  g,
  subject   = paste0(API,"Delete"),
  predicate = paste0(RDFS,"subClassOf"),
  object    = paste0(OWL,"Endpoint")
)

# Add the object properties
#api:hasEndpoint rdf:type owl:ObjectTypeProperty .
#api:hasEndpoint rdfs:domain owl:ObjectTypeProperty .

rdf_add(
  g,
  subject   = paste0(API,"hasEndpoint"),
  predicate = paste0(RDF,"type"),
  object    = paste0(OWL,"ObjectTypeProperty")
)

rdf_add(
  g,
  subject   = paste0(API,"hasEndpoint"),
  predicate = paste0(RDFS,"domain"),
  object    = paste0(OWL,"Endpoint")
)


# Save the generated API module ----
date_Filetag <- format(Sys.time(), "%m%dT%H%M_%S")
filepath_ttl <- paste0("Translation Layer/outputs/api_baseline_ontology",date_Filetag,".ttl")
filepath_nquads <- paste0("Translation Layer/outputs/api_baseline_ontology",date_Filetag,".nq") # This puts every triple into its own line. Allows for the serialization into any format

rdf_serialize(
  g,
  doc = filepath_nquads,
  format = "nquads" #turtle
)

# SPARQL to pull the data 

