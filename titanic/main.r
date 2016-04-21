debugSource("models/females_survive.r")
debugSource("models/logistic.r")

printAccuracy <- function(modelName, d, predictions) {
  correct <- sum(d$Survived == predictions)
  accuracy <- correct / nrow(d)
  cat(modelName, "model accuracy:", accuracy, '\n')
}

d <- read.csv("data/train.csv")

# Split the dataset into two random groups.
set.seed(123)
train_size <- floor(2 / 3 * nrow(d))
train_idx <- sample(seq_len(nrow(d)), size=train_size)
train <- d[train_idx,]
test <- d[-train_idx,]

# Use a model where all females survive and all males die.
genderPredictions <- predictGender(test)
printAccuracy("Gender", test, genderPredictions)

test <- read.csv("data/test.csv")
test$Survived <- predictGender(test)
predictLogistic(test)

write.csv(test[, c("PassengerId", "Survived")], file="data/test_output.csv", row.names = FALSE)
cat("Wrote output to data/test_output.csv.\n")