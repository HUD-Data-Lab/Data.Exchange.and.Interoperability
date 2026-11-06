
# normalize all cells to character and remove NBSP   
dataProperty2 <- dataProperty %>%
  mutate(across(everything(), ~ nb2sp(as.character(.x)))) %>%
  collapse_by_name()

dataProp <- dataProperty2 %>%
  rowwise() %>%
  mutate(block = {
    subj <- paste0("hmis:", ttl_local(Name))
    ranges <- unique(trimws(ConceptSchemeRange[!is_blank(ConceptSchemeRange)]))
    if (length(ranges) > 1) warning("Data property ", Name, " has more than one range: ", paste(ranges, collapse = ", "))
    
    lines <- c(
      paste0(subj, " a owl:DatatypeProperty ;"),
      ttl_domain(Class),
      paste0("  rdfs:range ", ranges[1], " ;"),
      # metadata as literals (only include if nonblank)
      ttl_annotation("hmis:dataElementNumber", DataElement),
      ttl_annotation("hmis:dataElementFieldNumber", FieldNumber),
      ttl_annotation("hmis:dataDictionaryName", Name),
      ttl_annotation("hmis:CSVExportTable", CSVTable)
    )
    
    # force the final line to end with "." no matter what
    last <- sub(";\\s*$", ".", sub("\\s+$", "", lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)
