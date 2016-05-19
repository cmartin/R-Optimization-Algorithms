genetic_algorithm_minimizer <- function(
  n_params,
  f, # function to minimize
  max_iterations = 100,
  n_genomes = 150,
  tolerance = 1e-08, # standard error of predicted y before we stop,
  w = 1, # weighting factor to favor best individuals (1 = exactly proportional),
  mutation_rate = 0.5, # what is the probability of mutating,
  mutation_amplitude = 1 # sd of rnorm for mutations
) {

  # A random gene pool to begin with
  pool <- matrix(ncol = n_params, nrow = n_genomes, data = rnorm(n_params*n_genomes))

  for (k in 1:max_iterations) {

    y_values <- apply(pool, 1, f)

    ### Fitness must be inverse of y-values in order to minimize
    fitness <- 1 / y_values

    se <- sd(y_values) / sqrt(n_genomes)

    cat(mean(y_values),"\r\n")

    if (se < tolerance) {
      cat(paste0("Solution reached at iter ",k,"\r\n"))
      return(colMeans(pool))
    }

    # sort both fitness vector and gene pool
    pool <- pool[order(fitness, decreasing = TRUE),]
    fitness <- sort(fitness, decreasing = TRUE)

    p <- fitness / sum(fitness) # calculate probability of reproducing from relative fitness
    p <- p^w # adding weight to best individuals
    (cum_p <- cumsum(p)) # build a cumulative probability vector to compare random numbers against

    # selecting fittest individuals more often
    pool <- pool[sapply(runif(n = n_genomes), FUN = function(x) {
      which.min(cum_p <= x)
    }),]

    # applying some random mutations based on mutation_rate and mutation_amplitude
    #pool <- matrix(ncol = 2, nrow = 25, data = c(1))
    pool <- apply(
      pool,
      1,
      function(x) {
        if(runif(1) < mutation_rate) {
          x+rnorm(length(x),0,mutation_amplitude)
        }else{
          x
        }
      }
    )

  }

  warning(paste("Algorithm did not converge in", k, "iterations\r\n"))

}
