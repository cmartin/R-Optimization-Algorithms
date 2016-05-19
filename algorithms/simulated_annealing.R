rm(list = ls())
delta <- function() {
  runif(n = 1, min = -.5, max = +.5)
}

p <- function(delta_h, t) {
  exp(delta_h / t)
}

temp_for_progress <- function(progress, start_temp) { # Progress is 0 at first, 1 at the end

  (((1-progress) * start_temp)^2)/start_temp + .00001 # temp must never be zero for probability calculations

}

simulated_annealing <- function(
  n_params = 1,
  f,
  max_iterations = 50,
  start_temp = 3,
  verbose = TRUE
){

  theta <- runif(n_params)

  current_y <- -300000

  for (i in 1:max_iterations) {
    for (j in 1:n_params) {
      theta1 <- theta
      theta1[j] <- theta1[j] + delta()

      new_y <- -f(theta1) # turn algorithm into a minimizer

      delta_h <- new_y - current_y

      temp <- temp_for_progress(i / max_iterations, start_temp)
      if ( (delta_h > 0) || (runif(1) < p(delta_h, temp))) {
        theta <- theta1
        current_y <- new_y
      }

    }

    if (verbose) { print(paste(i,current_y, theta, temp)) }

  }

  return(theta)

}


source("test_functions/MathewsFink.R")
simulated_annealing(2,mf_f, max_iterations = 100)
