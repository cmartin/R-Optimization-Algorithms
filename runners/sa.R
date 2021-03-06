rm(list = ls())
source("algorithms/simulated_annealing.R")

source("test_functions/MathewsFink.R")
(sol <- simulated_annealing_minimizer(2,mf_f))

source("test_functions/Rosenbrock.R")
# Transform y function for SA algorithm
f <- function(params) {
  rosenbrock_y(params[1],params[2])
}
(sol <- simulated_annealing_minimizer(2,f))

source("test_functions/Himmelblau.R")
# Transform y function for SA algorithm
g <- function(params) {
  himmelblau_f(params[1],params[2])
}
(sol <- simulated_annealing_minimizer(2,g))

source("test_functions/LinearModel.R")
(sol <- simulated_annealing_minimizer(2,lm_ss))
(sol <- simulated_annealing_minimizer(3,lm_logL))

source("test_functions/Unimodal.R")
(sol <- simulated_annealing_minimizer(3,ss_unimodal_quadratic))
