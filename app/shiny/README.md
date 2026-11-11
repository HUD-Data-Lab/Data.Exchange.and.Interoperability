# HMIS Data Exchange Product Suite (Shiny app)

This R Shiny app lets HMIS vendors and developers browse the HMIS data
elements and download JSON schemas for them. It is meant to help them describe,
in machine-readable form, the HMIS data they want to use in a data exchange
project.

The app has three tabs:

- **Home** gives an overview of the product suite. It also has placeholder
  cards for privacy and security, data mapping, and guides, which all say
  "Coming soon".
- **Explore the HMIS Data Model** lets you pick any HMIS data elements by data
  dictionary name, element number or field type. It shows them as a table,
  as data dictionary text, and as a JSON schema you can download.
- **HMIS Data Exchange Scenarios** lets you pick one of the common data
  exchange scenarios. It lists the data elements that scenario uses, shows
  their data dictionary text, and builds the full, request and response JSON
  schemas, which you can download.

## Running it

Install the packages it needs:

```r
install.packages(c("shiny", "tidyverse", "jsonlite", "bslib", "rdflib", "readxl"))
```

Start it from the repository root:

```r
shiny::runApp("app/shiny")
```

`runApp` makes `app/shiny` the working directory, so every path in the code
is relative to this folder.

## Which ontology it uses

The app does not read `FY26_HMIS_Logic_Model.ttl` at the repository root. It
reads a prebuilt cache of the older **v1.3.0-beta** ontology, which is
`data/hmis_ontology_cache_v1.3.0-beta.rds`. The script that built that cache,
`Translation Layer/scripts/build_ontology_cache.R`, and the generator code it
relied on were removed from this branch in commit 9e04c05. They are still in
the history before that commit.

## Files

| File | What it is | Where it was before |
| --- | --- | --- |
| `app.R` | Entry point. It sources `global.R` and starts the app with `ui` and `server`. | Repository root |
| `global.R` | Loads the packages and the data files, and prepares the element and scenario lists. It also defines the functions that build JSON schemas (`build_field_schema`, `find_field`, `build_object_schema`) and data dictionary HTML (`build_element_html`, `build_dictionary_tables`), plus the Home page cards. | Repository root |
| `ui.R` | Layout of the three tabs, built with `bslib::page_navbar`. | Repository root |
| `server.R` | The reactive logic: tables, data dictionary panels, schema text and the two JSON download handlers. | Repository root |
| `html_text_blocks.R` | HTML text for the Home page overview. | Repository root |
| `manifest.json` | Deployment manifest for Posit Connect or shinyapps.io (rsconnect). It pins the R version and package versions and lists checksums for the files in this folder. If you change any file, regenerate it with `rsconnect::writeManifest("app/shiny")`. | Repository root |
| `data/hmis_ontology_cache_v1.3.0-beta.rds` | Prebuilt cache of the v1.3.0-beta ontology. It holds the data properties (`properties`), the SKOS code-list values (`vocab_values`) and the data exchange scenarios (`de_scenarios`). | `Artifacts/Ontology/Output_v1.3.0-beta/` |
| `data/DataExchangeScenarioOntology.xlsx` | The scenario list. The app uses it to add a readable label to each scenario in the cache. | `Translation Layer/datasource/` |
| `data/DataDictionaryAnnotations.xlsx` | Data dictionary text for each element, shown on the Data Dictionary panels. | `Foundation Layer/Ontology Generator/datasource/` |

`global.R` also looks for `data/hmis_ontologyv1.3.0-beta.ttl`, but only to
warn when the cache is older than that file. The file is not included, so the
check is skipped.
