# Title: Dependency Analysis
# Objective: Dependency Analysis
# Created by: greyhypotheses
# Created on:

main <- function () {

  # Ensure that the required packages are available
  source("R/functions/ImportPackages.R")
  ImportPackages()

  # Functions
  source("R/functions/IsDependentCC.R")
  source("R/functions/IsDependentNC.R")
  source("R/functions/ExportData.R")

  # Libraries
  library(jsonlite)
  library(httr)
  library(rcompanion)

  # These will be the YAML file entities
  classes <- c("integer", "integer", "integer", "integer", "integer", "integer", "integer", "factor", "factor", "factor",
               "factor", "factor", "factor", "factor", "factor", "factor", "factor", "factor", "factor", "factor", "factor", "factor")
  dataurl <- 'https://raw.githubusercontent.com/exhypotheses/risk/develop/warehouse/data/baseline.csv'
  propertiesurl <- 'https://raw.githubusercontent.com/exhypotheses/risk/develop/warehouse/data/fields.json'

  # Data
  baseline <- fread(dataurl, header = TRUE, encoding = "UTF-8", data.table = TRUE,
                    colClasses = classes)

  # A dictionary of the data fields
  request <- httr::GET(url = propertiesurl)
  httr::http_type(request)
  fields <- jsonlite::fromJSON(txt = content(request, as = 'text', encoding = 'UTF-8'), simplifyVector = TRUE)

  # The fields w.r.t. the data set in focus (ref. the data URL)
  indices <- seq(fields$source)
  index <- indices[fields$source == basename(dataurl)]
  categorical_ <- fields$properties$categoricalFields[[index]]
  numeric_ <- fields$properties$numeric[[index]]
  target_ <- fields$properties$target[[index]]

  # The degree of dependence between target & categorical variables
  c_categorical <- IsDependentCC(variables = categorical_, target = target_, frame = baseline)

  # Next, for each target & numeric variable pairing determine the correlation values
  n_categorical <- IsDependentNC(variables = numeric_, target = target_, frame = baseline)

  # Prepare directory
  pathstr <- file.path(getwd(), 'warehouse', 'dependencies')
  if (dir.exists(paths = pathstr)) {
    base::unlink(pathstr, recursive = TRUE)
  }
  dir.create(path = pathstr, showWarnings = TRUE, recursive = TRUE)

  # Save
  mapply(ExportData, x = list(c_categorical, n_categorical), file_name = list('categorical.csv', 'numerical.csv'), pathstr =
    pathstr)

}
