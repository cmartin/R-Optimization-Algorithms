rm(list = ls())
source("test_functions/MathewsFink.R")
n_params = 2
f = mf_f # function to minimize
max_generations = 100
population_size = 50
tolerance = 1e-08 # standard error of predicted y before we stop,
w = 2 # weighting factor to favor best individuals (1 = exactly proportional),
mutation_amplitude = 1 # sd of rnorm for mutations

elite_count = 2 # how many "best" individuals do we keep?
cross_over_fraction = 0.5 # what are the proportions of crossovers vs mutations

# genetic_algorithm_minimizer <- function(
#   n_params,
#   f, # function to minimize
#   max_iterations = 100,
#   population_size = 50,
#   tolerance = 1e-08, # standard error of predicted y before we stop,
#   w = 1, # weighting factor to favor best individuals (1 = exactly proportional),
#   mutation_amplitude = 1 # sd of rnorm for mutations
# ) {

  population <- matrix(ncol = n_params, nrow = population_size, data = rnorm(n_params*population_size))

  i=1
  #for (i in 1:max_generations) {
    y_values <- apply(population, 1, f)
    fitness <- 1/y_values

    next_population <- matrix(ncol = n_params, nrow = population_size,data=NA)

    # first, keep elite_count best individuals
    next_population[1:elite_count,] <- population[order(fitness, decreasing = TRUE)[1:elite_count],]

    crossover_count <- round((population_size - elite_count)*cross_over_fraction)

  #}

#}
