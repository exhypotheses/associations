# Title: Dependency Analysis
# Objective: Dependency analysis w.r.t. a numerical field & a categorical target
# Created by: greyhypotheses
# Created on:

IsDependentNC <- function(variables, target, frame) {
  #' Returns a table of test statistic, p, & Cramér's V values
  #'
  #' @param variables: The list of categorical fields
  #' @param target: The target field
  #' @param frame: The table of data
  
  estimates <- data.table()
  for (variable in variables) {
    test <- kruskal.test(x = frame[[variable]], g = frame[[target]])
    estimates <- rbind(estimates, data.table(field = variable, pvalue = test$p.value))
  }
  
  return(estimates)
  
}