# Title: Dependency Analysis
# Objective: Dependency Analysis
# Created by: greyhypotheses
# Created on:

main <- function () {

  # Ensure that the required packages are available
  source("R/functions/ImportPackages.R")
  ImportPackages()
  
  
  # Libraries
  library(GDAtools)
  library(jsonlite)
  library(httr)
  library(rcompanion)
  

  # Functions
  source("R/functions/IsDependentCC.R")
  source("R/functions/IsDependentNC.R")
  source("R/functions/ExportData.R")
  

  # These will be the YAML file entities
  classes <- c("e_chq_acc_status" = "factor", "duration_months" = "integer", "credit_history" = "factor", "purpose" = "factor", "credit_amount" = "integer", "savings_acc_class" = "factor", "curr_emp_class" = "factor", "i_rate_by_disp_inc" = "integer", "sex_and_status" = "factor", "other_debtors_class" = "factor", "curr_res_since" = "integer", "property" = "factor", "age_years" = "integer", "other_i_plans" = "factor", "housing" = "factor", "n_e_credits_this_bank" = "integer", "job" = "factor", "n_dependants" = "integer", "telephone" = "factor", "foreign_worker" = "factor", "female" = "factor", "acceptable" = "factor")
  
  dataurl <- 'https://raw.githubusercontent.com/exhypotheses/risk/develop/warehouse/data/baseline/data.csv'
  propertiesurl <- 'https://raw.githubusercontent.com/exhypotheses/risk/develop/warehouse/data/baseline/properties.json'

  
  # Data
  baseline <- fread(dataurl, header = TRUE, encoding = "UTF-8", data.table = TRUE,
                    colClasses = classes)

  
  # A dictionary of the data fields
  request <- httr::GET(url = propertiesurl)
  httr::http_type(request)
  fields <- jsonlite::fromJSON(txt = content(request, as = 'text', encoding = 'UTF-8'), simplifyVector = TRUE)

  
  # The fields w.r.t. the data set in focus
  categorical_ <- fields$categoricalFields
  numeric_ <- fields$numeric
  target_ <- fields$target

  
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
  mapply(ExportData, x = list(c_categorical, n_categorical), file_name = list('categorical', 'numerical'), pathstr =
    pathstr)

}
