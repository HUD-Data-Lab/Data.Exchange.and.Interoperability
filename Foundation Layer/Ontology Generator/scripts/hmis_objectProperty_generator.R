# normalize all cells to character and remove NBSP
objectProperty2 <- objectProperty %>%
  mutate(across(everything(), ~ nb2sp(as.character(.x)))) %>%
  collapse_by_name()


objProp <- objectProperty2 %>%
  rowwise() %>%
  mutate(block = {
    subj <- paste0("hmis:", ttl_local(Name))
    schemes <- unique(trimws(ConceptSchemeRange[!is_blank(ConceptSchemeRange)]))
    
    lines <- c(
      paste0(subj, " a owl:ObjectProperty ;"),
      ttl_domain(Class),
      paste0("  rdfs:range skos:Concept ;"),
      ttl_annotation("hmis:dataElementNumber", DataElement),
      ttl_annotation("hmis:dataElementFieldNumber", FieldNumber),
      ttl_annotation("hmis:dataDictionaryName", Name),
      ttl_annotation("hmis:CSVExportTable", CSVTable),
      if (length(schemes) > 0)
        paste0("  hmis:linkedVocabulary ", paste0("hmis:", ttl_local(schemes), collapse = " , "), " ;")
    )
    
    last <- sub(";\\s*$", ".", sub("\\s+$", "", lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)
