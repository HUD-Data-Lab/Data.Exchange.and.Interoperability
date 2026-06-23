
# normalize all cells to character and remove NBSP   
dataProperty2 <- dataProperty %>%
  mutate(across(everything(), ~ nb2sp(as.character(.x))))

dataProp <- dataProperty2 %>%
  rowwise() %>%
  mutate(block = {
    subj <- paste0("hmis:", ttl_local(Name))
    
    lines <- c(
      paste0(subj, " a owl:DatatypeProperty ;"),
      paste0("  rdfs:domain hmis:", ttl_local(Class), " ;"),
      paste0("  rdfs:range ", trimws(Range), " ;")
    )
    
    # metadata as literals (only include if nonblank)
    if (!is_blank(DataElement))   lines <- c(lines, paste0("  hmis:dataElementNumber ", ttl_lit(DataElement), " ;"))
    if (!is_blank(FieldNumber))   lines <- c(lines, paste0("  hmis:dataElementFieldNumber ", ttl_lit(FieldNumber), " ;"))
    if (!is_blank(Name))          lines <- c(lines, paste0("  hmis:dataDictionaryName ", ttl_lit(Name), " ;"))
    if (!is_blank(CSVTable))      lines <- c(lines, paste0("  hmis:CSVExportTable ", ttl_lit(CSVTable), " ;"))
    
    # force the final line to end with "." no matter what
    last <- sub(";\\s*$", ".", trimws(lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)

