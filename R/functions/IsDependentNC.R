# Title: Dependency Analysis
# Objective: Dependency analysis w.r.t. a numerical field & a categorical target
# Created by: greyhypotheses
# Created on:

isdependentNC <- function(attributes, label, frame) {
  #' Returns a table of test statistic, p, & Cramér's V values
  #'
  #' @param attributes: The list of categorical fields
  #' @param label: The name of the target field
  #' @param frame: The table of data
  
  estimates <- data.table()
  for (attribute in attributes) {
    test <- kruskal.test(x = frame[[attribute]], g = frame[[label]])
    estimates <- rbind(estimates, data.table(field = attribute, pvalue = test$p.value))
  }
  
  return(estimates)
  
}