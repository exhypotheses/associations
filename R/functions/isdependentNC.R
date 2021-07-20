isdependentNC <- function(attributes, label, frame) {
  
  estimates <- data.table()
  for (attribute in attributes) {
    test <- kruskal.test(x = frame[[attribute]], g = frame[[label]])
    estimates <- rbind(estimates, data.table(field = attribute, pvalue = test$p.value))
  }
  
  return(estimates)
  
}