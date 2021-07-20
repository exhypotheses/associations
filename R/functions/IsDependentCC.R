# Title: Dependency Analysis
# Objective: Dependency analysis w.r.t. a categorical field & a categorical target
# Created by: greyhypotheses
# Created on:

IsDependentCC <- function(variables, target, frame){
  #' Returns a table of test statistic, p, & Cramér's V values
  #'
  #' @param variables: The list of categorical fields
  #' @param target: The target field
  #' @param frame: The table of data
  
  estimates <- data.table()
  for (variable in variables) {
    
    writeLines(paste0('\n\nCase: ', variable))
    frequencies <- table(frame[[variable]], frame[[target]])
    print(frequencies)

    # In relation to a categrical field in question, is the classification of an instance independent of the
    # categories/elements of the field?
    chisquared <- chisq.test(frequencies, simulate.p.value = TRUE, B = 5000)

    # In relation to a categrical field in question, what is the degree of association between the classification options &
    # the categories/elements of the field?
    cramercinq <- rcompanion::cramerV(frequencies, y = NULL, ci = FALSE, conf = 0.95, type = 'bca', 
                                  R = 1000, histogram = FALSE, digits = 4, bias.correct = TRUE)

    # Add the estimates to the table of estimates
    calculations <- data.table(field = variable, chi_squared_statistic = chisquared$statistic,
                               pvalue = chisquared$p.value, cramerv = cramercinq)
    estimates <- rbind(estimates, calculations)
  }
  
  return(estimates)
  
}