rm(list = ls())

source("utils/se.R")

simulated_annealing_minimizer <- function(
  n_params = 1,
  f,
  max_iterations = 100000,
  start_temp = 100,
  verbose = FALSE,
  tolerance = .01, # variance of last max_stall_iterations before we stop
  max_stall_iterations = 500 * n_params,
  temperature_curve = 0.95, # 1 = linear
  max_search_distance = 0.5

){

  theta <- runif(n_params) # start with random values

  current_y <- -300000 # arbitrary small "maximum" value

  y_trace <- c()

  for (i in 1:max_iterations) {

    # for each parameter
    for (j in 1:n_params) {
      theta1 <- theta

      # pick another point around the original ont
      theta1[j] <- theta1[j] + runif(n = 1, min = -max_search_distance, max = max_search_distance)

      # calculate function value for new params
      new_y <- -f(theta1) # minus signs turn algorithm into a minimizer

      # calculate how much better (or worse) are the new params
      delta_h <- new_y - current_y

      # calculate temperature based on iteration number
      temp <- start_temp * temperature_curve ^ i

      # calculate probability of acceptance of params worse than originals
      p <- exp(delta_h / temp)
      if ( (delta_h > 0) || (runif(1) < p)) {

        # accept new param values
        theta <- theta1
        current_y <- new_y
      }

    }

    y_trace[length(y_trace) + 1] <- current_y

    #Calculate stopping condition only on max_stall_iterations values
    y_to_test <- y_trace[
      (max(length(y_trace) - max_stall_iterations,1)
      ):length(y_trace)
    ]

    v <- var(y_to_test)
    if (!is.na(v) && (v < tolerance)){
      cat(paste0("Solution reached at iter ",i,"\r\n"))
      break
    }

    if (verbose) { print(paste(i,current_y, theta, temp)) }

  }

  if (i == max_iterations) {
    warning(paste("Algorithm did not converge in", i, "iterations\r\n"))
  }

  return(theta)

}
