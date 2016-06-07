rm(list = ls())
# https://en.wikipedia.org/wiki/Numerical_differentiation
approximate_derivative <- function(x, f, h = .001) {
  d <- c()
  for (i in 1:length(x)) {
    left <- right <- x
    left[i] <- left[i] + h
    right[i] <- right[i] - h
    d[i] <- (f(left) - f(right)) / (2*h)
  }
  d
}

# https://en.wikipedia.org/wiki/Gradient_descent
gradient_descent <- function(
  n_params = 1,
  f,
  precision = 0.0001,
  max_iterations = 20000,
  step_size = 0.0001, # learning rate
  verbose = FALSE
){

  x_new <- runif(n_params)

  for (i in 1:max_iterations) {
    x_old <- x_new
    (x_new <- x_old - step_size * approximate_derivative(x_old,f))

    if (abs(f(x_new) - f(x_old)) <= precision) {
      cat(paste0("Solution reached at iter ",i,"\r\n"))
      break;
    }

    if (verbose) {
      print(paste(i,f(x_new), x_new))
    }
  }

  if (i == max_iterations) {
    warning(paste("Algorithm did not converge in", i, "iterations\r\n"))
  }

  x_new
}


source("test_functions/LinearModel.R")
(sol <- gradient_descent(2,lm_ss, step_size = 0.0001))
# n_params = 2
# precision = 0.00001
# max_iterations = 100000
# step_size = 0.001
# f = lm_ss

f <- function(x){4*x^2-4*x}
x <- -100:100
plot(x,f(x))
gradient_descent(1,f)

source("test_functions/MathewsFink.R")
(sol <- gradient_descent(2,mf_f))
