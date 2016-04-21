# Given a dataset |d|, returns a matrix of the same length where the nth row
# indicates whether the nth row of |d| survived.
predictGender <- function(d) {
  return((d$Sex == "female") * 1)
}