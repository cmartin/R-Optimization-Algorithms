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
