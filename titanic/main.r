debugSource("models/females_survive.r")
debugSource("models/logistic.r")

printAccuracy <- function(modelName, truth, predictions) {
  correct <- sum(truth == predictions)
  accuracy <- correct / length(truth)
  cat(modelName, "model accuracy:", accuracy, '\n')
}

# Transforms data frame columns into a format that we can work with. This involves dropping columns
# that our current model doesn't use, creating dummy columns for enum columns, etc.
transformColumns <- function(d) {
  # For now, drop any non-numeric columns.
  d2 <- d[c("PassengerId", "Age")]
  d2$Male <- (d$Sex == "female") * 1
  return(d2)
}

{ function() {
  setwd("~/github/kaggle/titanic")
  
  rawInput <- read.csv("data/train.csv")
  input <- transformColumns(rawInput)
  
  # Split the dataset into two random groups.
  set.seed(123)
  train_size <- floor(2 / 3 * nrow(input))
  train_idx <- sample(seq_len(nrow(input)), size=train_size)
  train <- input[train_idx,]
  trainTruth <- rawInput[rawInput$PassengerId %in% train$PassengerId, "Survived"]
  test <- input[-train_idx,]
  testTruth <- rawInput[rawInput$PassengerId %in% test$PassengerId, "Survived"]
  
  # Use a model where all females survive and all males die.
  genderPredictions <- genderPredict(test)
  printAccuracy("Gender", testTruth, genderPredictions)
  
  # Use logistic regression with age and gender to create a model.
  logisticModel <- createLogisticModel(train, trainTruth)
  logisticPredictions <- applyLogisticModel(logisticModel, test)
  printAccuracy("Logistic", testTruth, logisticPredictions)
  
  test <- read.csv("data/test.csv")
  test <- transformColumns(test)
  test$Survived <- genderPredict(test)
  
  #logisticPredict(test)
  
  write.csv(test[, c("PassengerId", "Survived")], file="data/test_output.csv", row.names = FALSE)
  cat("Wrote output to data/test_output.csv.\n")
}}()