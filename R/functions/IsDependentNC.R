# Title: Dependency Analysis
# Objective: Dependency analysis w.r.t. a numerical field & a categorical target
# Created by: greyhypotheses
# Created on:

IsDependentNC <- function(variables, target, frame) {
  #' Returns a table of test statistic, p, & Cramer's V values
  #' https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/kruskal.test
  #' https://www.rdocumentation.org/packages/conover.test/versions/1.1.5/topics/conover.test
  #'
  #' @param variables: The list of categorical fields
  #' @param target: The target field
  #' @param frame: The table of data
  
  estimates <- data.table()
  for (variable in variables) {
    
    writeLines(paste0('\n\n', variable))
    
    
    # x must be a numeric vector, whereas g must be a factor/categorical vector
    test <- stats::kruskal.test(x = frame[[variable]], g = frame[[target]])
    
    # Conover Iman Test
    iman <- conover.test::conover.test(x = frame[[variable]], g = frame[[target]], method = 'bonferroni', kw = TRUE, label = TRUE, wrap = FALSE, table=TRUE, list=FALSE, rmc=FALSE, alpha=0.05, altp=FALSE)
    print(iman$comparisons)
    
    
    # Summaries
    estimates <- rbind(estimates, data.table(field = variable, kruskal_pvalue = test$p.value, 
                                     iman_m = iman$T, 
                                     iman_pvalue_adj = iman$P.adjust))
    
  }
  
  return(estimates)
  
}