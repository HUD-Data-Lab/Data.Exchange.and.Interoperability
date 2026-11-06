# Transform data into the format needed to generate the classes ttl file
core_classes2 <- core_classes %>% 
  mutate(across(everything(), ~ nb2sp(as.character(.x))))


classes <- core_classes2 %>%
  rowwise() %>%
  mutate(block = {
    
    # Subject
    subj <- paste0("hmis:", ttl_local(Class))
    
    lines <- c(
      paste0(subj, " a owl:Class ;")
    )
    
    # rdfs:label (explicit column)
    if (!is_blank(`rdfs:label`)) {
      lines <- c(
        lines,
        paste0("  rdfs:label ", ttl_lit(`rdfs:label`), " ;")
      )
    }
    
    # rdfs:comment
    if (!is_blank(`rdfs:comment`)) {
      lines <- c(
        lines,
        paste0("  rdfs:comment ", ttl_lit(`rdfs:comment`), " ;")
      )
    }
    
    # rdfs:subClassOf (single value)
    if (!is_blank(SubClassof)) {
      lines <- c(
        lines,
        paste0("  rdfs:subClassOf hmis:", ttl_local(SubClassof), " ;")
      )
    }
    
    # owl:disjointWith is no longer generated. The pairwise axioms grew as O(N^2),
    # and ICF agreed they solve no current problem. The "Disjoint With" column
    # in SkosVocabulary.xlsx is now ignored.

    # Replace final ";" with "."
    lines[length(lines)] <- sub(";\\s*$", ".", lines[length(lines)])
    
    paste0(paste(lines, collapse = "\n"), "\n")
  }) %>%
  ungroup() %>%
  pull(block)


coreClassObjProps <- class_relationships %>%
  rowwise() %>%
  mutate(block = {
    
    subj <- paste0("hmis:", ObjectProperty)
    
    lines <- c(
      paste0(subj, " a owl:ObjectProperty ;")
    )
    
    if (!is.na(SubPropertyOf) && SubPropertyOf != "")
      lines <- c(lines, paste0("  rdfs:subPropertyOf hmis:", SubPropertyOf, " ;"))
    
    if (!is.na(InverseOf) && InverseOf != "")
      lines <- c(lines, paste0("  owl:inverseOf hmis:", InverseOf, " ;"))
    
    if (!is.na(Domain) && Domain != "")
      lines <- c(lines, paste0("  rdfs:domain hmis:", Domain, " ;"))
    
    if (!is.na(Range) && Range != "")
      lines <- c(lines, paste0("  rdfs:range hmis:", Range, " ;"))
    
    if (!is.na(label) && label != "")
      lines <- c(lines, paste0("  rdfs:label ", ttl_lit(label), "@en ;"))
    
    if (!is.na(comment) && comment != "")
      lines <- c(lines, paste0("  rdfs:comment ", ttl_lit(comment), "@en ;"))
    
    # Force final predicate to end with "."
    last <- sub(";\\s*$", ".", sub("\\s+$", "", lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n")
  }) %>%
  ungroup() %>%
  pull(block)



