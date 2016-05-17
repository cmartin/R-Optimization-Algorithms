rm(list = ls())
source("algorithms/genetic_algorithm.R")


source("test_functions/MathewsFink.R")
(sol <- genetic_algorithm_minimizer(
  2,
  mf_f,
  tolerance = .25,
  max_iterations = 1000,
  n_genomes = 200
))
