rm(list = ls())

source("utils/se.R")

delta <- function() {
  runif(n = 1, min = -.5, max = +.5)
}

p <- function(delta_h, t) {
  exp(delta_h / t)
}

temp_for_progress <- function(progress, start_temp) { # Progress is 0 at first, 1 at the end

  (((1-progress) * start_temp)^2)/start_temp + .00001 # temp must never be zero for probability calculations

}

simulated_annealing_minimizer <- function(
  n_params = 1,
  f,
  max_iterations = 100000,
  start_temp = 3,
  verbose = FALSE,
  tolerance = 1e-5,
  max_stall_iterations = 500 * n_params

){

  theta <- runif(n_params)

  current_y <- -300000

  y_trace <- c()

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

    y_trace[length(y_trace) + 1] <- current_y

    y_to_test <- y_trace[
      (max(length(y_trace) - max_stall_iterations,1)
      ):length(y_trace)
    ]
    se <- std_err(y_to_test)

    if (!is.na(se) && (se < tolerance)){
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
