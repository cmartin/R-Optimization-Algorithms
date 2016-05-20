rm(list = ls())

source("utils/se.R")


source("test_functions/MathewsFink.R")

n_params = 2
f = mf_f # function to minimize
max_generations = 1000
population_size = 50
tolerance = 1e-08 # standard error of predicted y before we stop,
w = 1 # weighting factor to favor best individuals (1 = exactly proportional),

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

  for (i in 1:max_generations) {
    y_values <- apply(population, 1, f)
    fitness <- 1/y_values

    se <- std_err(y_values)
    cat(min(y_values),"\r\n")
    if (se < tolerance) {
      cat(paste0("Solution reached at iter ",k,"\r\n"))
      return(colMeans(population))
    }

    next_population <- matrix(ncol = n_params, nrow = population_size,data=NA)

    # first, keep elite_count best individuals
    next_population[1:elite_count,] <- population[order(fitness, decreasing = TRUE)[1:elite_count],]

    # probability of reproducing is relative fitness (and a possible exponent to penalize bad fitness)
    p <- (fitness / sum(fitness))^w

    # next step : build crossover individuals (i.e. sexual reproduction)
    crossover_count <- round((population_size - elite_count)*cross_over_fraction)

    for (j in (elite_count + 1):(elite_count + crossover_count)){
      parents <- population[sample(1:population_size,2,prob = p),]
      next_population[j,] <- apply(parents,2,function(x) {
        x[sample(c(1,2),1)]
      })
    }

    # Finally, fill the rest of new pop with mutants
    mutation_count <- population_size - (elite_count + crossover_count)

    mutants <- population[sample(1:population_size,mutation_count,prob = p),]

    next_population[(j+1):population_size,] <- mutants + rnorm(length(mutants))

    population <- next_population

  }

#}
