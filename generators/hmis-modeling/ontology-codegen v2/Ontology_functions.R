library(tidyverse)
library(readxl)
library(stringr)


# Functions to clean up text
nb2sp <- function(x) gsub("\u00A0", " ", x, fixed = TRUE) #non-breaking to space

# For IRI and local names (object property names, class names, individual names)
ttl_local <- function(x) {
  x <- nb2sp(trimws(as.character(x)))
  x[is.na(x) | x == ""] <- "unnamed"
  
  # Normalize Unicode punctuation → ASCII
  x <- iconv(x, from = "", to = "ASCII//TRANSLIT")
  
  # Replace anything not allowed in PN_LOCAL with "_"
  x <- gsub("[^A-Za-z0-9_]", "_", x)
  
  # Collapse repeated underscores
  x <- gsub("_+", "_", x)
  
  # Trim leading/trailing underscores
  x <- gsub("^_|_$", "", x)
  
  # Turtle QName rule: must NOT start with a digit
  starts_bad <- grepl("^[0-9]", x)
  
  x[starts_bad] <- paste0("_", x[starts_bad])
  
  x
}

# For literals (annotations such as prefLabel)

ttl_lit <- function(x) {
  x <- nb2sp(as.character(x))
  x[is.na(x)] <- ""
  x <- trimws(x)
  
  # Escape Turtle-sensitive characters
  x <- gsub("\\\\", "\\\\\\\\", x)   # backslash
  x <- gsub("\"", "\\\\\"", x)       # quotes
  x <- gsub("\n", "\\\\n", x)        # newlines
  x <- gsub("\r", "\\\\r", x)
  
  paste0("\"", x, "\"")
}


is_blank <- function(x) {
  x <- nb2sp(as.character(x))
  is.na(x) | trimws(x) == ""
}

clean_iri <- function(x) {
  x <- nb2sp(as.character(x))
  x <- trimws(x)
  x <- gsub("\\s+", "", x)              # remove any remaining whitespace
  x
}


