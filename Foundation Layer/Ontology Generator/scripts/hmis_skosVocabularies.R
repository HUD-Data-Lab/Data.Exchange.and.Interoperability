# normalize all cells to character and remove NBSP
skos_concepts2 <- skos_concepts %>% 
  mutate(across(everything(), ~ nb2sp(as.character(.x))))

skos_conceptScheme2 <- skos_conceptScheme %>% 
  mutate(across(everything(), ~ nb2sp(as.character(.x))))


skosClasses <- {
  lines <- c(
    "skos:Concept a owl:Class ;",
    paste0("  rdfs:label ", ttl_lit("Concept"), "@en ;"),
    "  owl:disjointWith skos:ConceptScheme .",
    "",
    "skos:ConceptScheme a owl:Class ;",
    paste0("  rdfs:label ", ttl_lit("ConceptScheme"), "@en ."),
    "",
    "skos:inScheme a owl:ObjectProperty ;",
    "  rdfs:domain skos:Concept ;",
    "  rdfs:range skos:ConceptScheme ."
  )
  
  paste0(paste(lines, collapse = "\n"), "\n\n")
}

skosConceptScheme <- skos_conceptScheme2 %>%
  rowwise() %>%
  mutate(block = {
    
    subj <- paste0("hmis:",ttl_local(Scheme))
    
    lines <- c(
      paste0(subj, " a skos:ConceptScheme ;"),
      paste0("  skos:prefLabel ", ttl_lit(PrefLabel), "@en ;"),
      paste0("  hmis:csvList ", ttl_lit(CSVList), "@en ;")
      
    )
    
    lines[length(lines)] <- sub(";\\s*$", ".", lines[length(lines)])
    
    paste0(paste(lines, collapse = "\n"), "\n")
  }) %>%
  ungroup() %>%
  pull(block)


skosConcept <- skos_concepts2 %>%
  rowwise() %>%
  mutate(block = {
    
    subj <- paste0("hmis:",ttl_local(PrefLabel))
    
    lines <- c(
      paste0(subj, " a skos:Concept ;"),
      paste0("  skos:prefLabel ", ttl_lit(PrefLabel), "@en ;"),
      paste0("  skos:notation ", ttl_lit(Notation), "^^xsd:integer ;"),
      paste0("  skos:inScheme hmis:", Scheme, " ;")
    )
    
    lines[length(lines)] <- sub(";\\s*$", ".", lines[length(lines)])
    
    paste0(paste(lines, collapse = "\n"), "\n")
  }) %>%
  ungroup() %>%
  pull(block)


