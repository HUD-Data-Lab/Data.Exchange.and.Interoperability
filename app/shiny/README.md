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

## Requirements

The app needs [R](https://www.r-project.org/) 4.1 or later and five R
packages: shiny, tidyverse, bslib, jsonlite and rdflib. It has been
run with R 4.5.2. Install them in any one of these ways.

**Ubuntu or Debian, system packages.** These are prebuilt, so nothing is
compiled:

```bash
sudo apt install r-base r-cran-shiny r-cran-tidyverse r-cran-bslib r-cran-jsonlite r-cran-rdflib
```

**macOS, with Homebrew.** Then install the packages from CRAN, as shown under
"Any platform" below:

```bash
brew install r
```

**Windows, with winget.** Or use the installer from
[CRAN](https://cran.r-project.org/bin/windows/base/). Then install the
packages from CRAN, as below:

```powershell
winget install RProject.R
```

**Any platform, with conda or mamba.** This needs no administrator rights,
and everything stays in its own environment:

```bash
conda create -n hmis-shiny -c conda-forge r-base r-shiny r-tidyverse r-bslib r-jsonlite r-rdflib
conda activate hmis-shiny
```

**Any platform, from CRAN.** Once R is installed, run this in R. On Linux,
building tidyverse from source also needs system libraries such as
libcurl, libssl, libxml2 and libfontconfig development headers; the apt or
conda routes above avoid that.

```r
install.packages(c("shiny", "tidyverse", "bslib", "jsonlite", "rdflib"))
```

Check that everything loads:

```bash
Rscript -e 'for (p in c("shiny","tidyverse","bslib","jsonlite","rdflib")) library(p, character.only = TRUE)'
```

## Running it

Start it from the repository root:

```r
shiny::runApp("app/shiny")
```

`runApp` makes `app/shiny` the working directory, so every path in the code
is relative to this folder.

## Which ontology it uses

The app reads `FY26_HMIS_Logic_Model.ttl`, the ontology at the repository
root, through a prebuilt cache, `data/hmis_ontology_cache.rds`. The cache
holds three tables:

- `properties`: one row per ontology property and data element number. A
  property is a data element field, with a `dataDictionaryName`, when its
  range is a datatype or a code list. The element and field number come from
  `dcterms:identifier`, and the CSV table from the `:CSVTableReference` of the
  property's domain class.
- `vocab_values`: every SKOS concept with its code list, label and notation.
- `de_scenarios`: the fields each scenario uses in its request and response,
  read from [api/DataExchangeScenarioList.md](../../api/DataExchangeScenarioList.md)
  by each field's `dataExchangeOntologyName`.

Rebuild the cache whenever either source file changes:

```bash
Rscript app/shiny/build_cache.R
```

It takes about a second. The app warns at startup when the ontology file has
changed since the cache was built. Field names are the ontology's property names, so the
app shows `GrantStartDate` and `EventType` where the API's JSON uses
`StartDate` and `Event`.

## Files

| File | What it is | Where it was before |
| --- | --- | --- |
| `app.R` | Entry point. It sources `global.R` and starts the app with `ui` and `server`. | Repository root |
| `global.R` | Loads the packages and the data files, and prepares the element and scenario lists. It also defines the functions that build JSON schemas (`build_field_schema`, `find_field`, `build_object_schema`) and data dictionary HTML (`build_element_html`, `build_dictionary_tables`), plus the Home page cards. | Repository root |
| `ui.R` | Layout of the three tabs, built with `bslib::page_navbar`. | Repository root |
| `server.R` | The reactive logic: tables, data dictionary panels, schema text and the two JSON download handlers. | Repository root |
| `html_text_blocks.R` | HTML text for the Home page overview. | Repository root |
| `manifest.json` | Deployment manifest for Posit Connect or shinyapps.io (rsconnect). It pins the R version and package versions and lists checksums for the files in this folder. If you change any file, regenerate it with `rsconnect::writeManifest("app/shiny")`. | Repository root |
| `build_cache.R` | Builds `data/hmis_ontology_cache.rds` from `FY26_HMIS_Logic_Model.ttl` and `api/DataExchangeScenarioList.md`. | New. It replaces `Translation Layer/scripts/build_ontology_cache.R`, which read the v1.3.0-beta ontology. |
| `data/hmis_ontology_cache.rds` | The cache the app reads at startup, described above. | New. It replaces `Artifacts/Ontology/Output_v1.3.0-beta/hmis_ontology_cache_v1.3.0-beta.rds`. |
| `data/DataDictionaryAnnotations.md` | Data dictionary guidance for each of the 87 HMIS data elements, from HUD's HMIS Data Standards Manual: who collects it, about whom, when, the system rules, its CSV file, why it is collected, and a link to its HUD Exchange page. It is shown on the Data Dictionary panels. `read_data_dictionary()` in `global.R` parses it, so keep its layout. It was converted from `DataDictionaryAnnotations.xlsx`. | `Foundation Layer/Ontology Generator/datasource/` (as .xlsx) |
