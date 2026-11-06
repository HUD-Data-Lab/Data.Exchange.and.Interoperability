# normalize all cells to character and remove NBSP
skos_concepts2 <- skos_concepts %>% 
  mutate(across(everything(), ~ nb2sp(as.character(.x))))

skos_conceptScheme2 <- skos_conceptScheme %>% 
  mutate(across(everything(), ~ nb2sp(as.character(.x)))) %>%
  distinct() # some schemes (e.g. list_TargetPopulation) are listed twice in the spreadsheet


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
      paste0("  hmis:csvList ", ttl_lit(CSVList), " ;")
      
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
      paste0("  skos:altLabel ", ttl_lit(AltLabel), "@en ;"),
      # Type the code as an integer only when it is one; codes such as "459GE" stay plain strings.
      paste0("  skos:notation ", ttl_lit(Notation),
             if (grepl("^-?[0-9]+$", trimws(Notation))) "^^xsd:integer" else "", " ;"),
      paste0("  skos:inScheme hmis:", Scheme, " ;")
    )
    
    lines[length(lines)] <- sub(";\\s*$", ".", lines[length(lines)])
    
    paste0(paste(lines, collapse = "\n"), "\n")
  }) %>%
  ungroup() %>%
  pull(block)


