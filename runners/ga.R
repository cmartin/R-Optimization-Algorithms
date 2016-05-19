rm(list = ls())
source("algorithms/genetic_algorithm.R")


source("test_functions/MathewsFink.R")
(sol <- genetic_algorithm_minimizer(
  2,
  mf_f,
  tolerance = .01,
  max_iterations = 500,
  n_genomes = 200,
  w = 3,
  mutation_rate = 0.1,
  mutation_amplitude = 2
))
