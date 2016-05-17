genetic_algorithm_minimizer <- function(
  n_params,
  f, # function to minimize
  max_iterations = 100,
  n_genomes = 150,
  tolerance = 1e-08 # standard error of predicted y before we stop
) {

  # A random gene pool to begin with
  pool <- matrix(ncol = n_params, nrow = n_genomes, data = rnorm(n_params*n_genomes))

  for (k in 1:max_iterations) {

    y_values <- apply(pool, 1, f)

    ### Fitness must be inverse of y-values in order to minimize
    fitness <- 1 / y_values

    se <- sd(y_values) / sqrt(n_genomes)
    if (se < tolerance) {
      cat(paste0("Solution reached at iter ",k,"\r\n"))
      return(colMeans(pool))
    }

    # sort both fitness vector and gene pool
    pool <- pool[order(fitness, decreasing = TRUE),]
    fitness <- sort(fitness, decreasing = TRUE)

    # build a cumulative probability vector to compare random numbers against
    normalized_fitness <- fitness / sum(fitness)
    (cum_norm_fitness <- cumsum(normalized_fitness))

    # selecting fittest individuals more often
    pool <- pool[sapply(runif(n = n_genomes), FUN = function(x) {
      which.min(cum_norm_fitness <= x)
    }),]

    # applying some random mutations equally to all individuals
    pool <- pool + rnorm(n_genomes*n_params)

  }

  warning(paste("Algorithm did not converge in", k, "iterations\r\n"))

}
