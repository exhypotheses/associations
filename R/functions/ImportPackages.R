# Title: Import Packages
# Objective: Imports packages
# Created by: greyhypotheses
# Created on:

ImportPackages <- function(){
  #' Imports packages
  #'
  
  # List of packages
  packages <- c("ggplot2", "plotly", "data.table", "rcompanion", "conover.test")
  
  # Prepare
  prepare <- function(x){
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
  isready <- lapply(packages, prepare)
  
}