rm(list = ls())
source("algorithms/genetic_algorithm.R")


source("test_functions/MathewsFink.R")
(sol <- genetic_algorithm_minimizer(2,mf_f))

source("test_functions/Rosenbrock.R")
# Transform y function for GA algorithm
f <- function(params) {
  rosenbrock_y(params[1],params[2])
}
(sol <- genetic_algorithm_minimizer(2,f))

source("test_functions/Himmelblau.R")
# Transform y function for NM algorithm
g <- function(params) {
  himmelblau_f(params[1],params[2])
}
(sol <- genetic_algorithm_minimizer(2,g))

source("test_functions/LinearModel.R")
(sol <- genetic_algorithm_minimizer(2,lm_ss))
#(sol <- genetic_algorithm_minimizer(3,lm_logL))

source("test_functions/Unimodal.R")
(sol <- genetic_algorithm_minimizer(3,ss_unimodal_quadratic))
