std_err <- function(x) {
  sd(x) / sqrt(length(x)+1)
}
