# Given a training dataset |train| and a truth vector for that dataset |trainTruth|, returns
# a 
createLogisticModel <- function(train, trainTruth) {
  predictions <- rep(.5, nrow(d))
  logisticCost(predictions, d$Survived)
  return(predictions)
}

# Given a prediction vector |hx| and a truth vector |y|, computes the cost.
logisticCost <- function(hx, y) {
  return(sum(-y * log(hx) - (1 - y) * log(1 - hx)))
}