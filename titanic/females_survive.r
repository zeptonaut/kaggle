# Given a dataset |d|, returns a matrix of the same length where the nth row
# indicates whether the nth row of |d| survived.
predictGender <- function(d) {
  return((d$Sex == "female") * 1)
}

printAccuracy <- function(d, predictions) {
  correct <- sum(d$Survived == predictions)
  accuracy <- correct / nrow(d)
  cat("Model accuracy: ", accuracy, '\n')
}

d <- read.csv("data/train.csv")

# Split the dataset into two random groups.
set.seed(123)
train_size <- floor(2 / 3 * nrow(d))
train_idx <- sample(seq_len(nrow(d)), size=train_size)
train <- d[train_idx,]
test <- d[-train_idx,]

# Use a model where all females survive and all males die.
predictions <- predictGender(test)
printAccuracy(test, predictions)

test <- read.csv("data/test.csv")
test$Survived <- predictGender(test)

write.csv(test[, c("PassengerId", "Survived")], file="data/test_output.csv", row.names = FALSE)
cat("Wrote output to data/test_output.csv.\n")