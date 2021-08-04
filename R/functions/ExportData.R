# Title: Export Data
# Objective: Save data
# Created by: greyhypotheses
# Created on: 20/07/2021

ExportData <- function (x, file_name, pathstr) {
  #' Saves the data x to the directory pathstr
  #'
  #' @param x A data frame
  #' @param file_name The name of the file wherein the <x> data will be saved.
  #' @param pathstr The path to file_name

  # Write/Save
  data.table::fwrite(x = x, file = file.path(pathstr, paste0(file_name, '.csv')), row.names = FALSE, col.names = TRUE)
  jsonlite::write_json(x = x, path = file.path(pathstr, paste0(file_name, '.json')))

}