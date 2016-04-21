# Given a dataset |d|, returns a matrix of the same length where the nth row
# indicates whether the nth row of |d| survived.
predictLogistic <- function(d) {
  predictions <- rep(.5, nrow(d))
  logisticCost(predictions, d$Survived)
  return(predictions)
}

# Given a prediction vector |hx| and a truth vector |y|, computes the cost.
logisticCost <- function(hx, y) {
  return(sum(-y * log(hx) - (1 - y) * log(1 - hx)))
}