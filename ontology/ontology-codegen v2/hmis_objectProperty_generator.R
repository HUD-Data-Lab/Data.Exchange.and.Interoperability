# normalize all cells to character and remove NBSP
objectProperty2 <- objectProperty %>%
  mutate(across(everything(), ~ nb2sp(as.character(.x))))


objProp <- objectProperty2 %>%
  rowwise() %>%
  mutate(block = {
    subj <- paste0("hmis:", ttl_local(Name))
    
    lines <- c(
      paste0(subj, " a owl:ObjectProperty ;"),
      paste0("  rdfs:domain hmis:", ttl_local(Class), " ;"),
      paste0("  rdfs:range skos:Concept ;")
    )
    
    if (!is_blank(DataElement))
      lines <- c(lines, paste0("  hmis:dataElementNumber ", ttl_lit(DataElement), " ;"))
    
    if (!is_blank(FieldNumber))
      lines <- c(lines, paste0("  hmis:dataElementFieldNumber ", ttl_lit(FieldNumber), " ;"))
    
    if (!is_blank(Name))
      lines <- c(lines, paste0("  hmis:dataDictionaryName ", ttl_lit(Name), " ;"))
    
    if (!is_blank(CSVTable))
      lines <- c(lines, paste0("  hmis:CSVExportTable ", ttl_lit(CSVTable), " ;"))
    
    if (!is_blank(ConceptScheme))
      lines <- c(
        lines,
        paste0("  hmis:linkedVocabulary hmis:", ttl_local(ConceptScheme), " ;")
      )
    
    last <- sub(";\\s*$", ".", trimws(lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)



