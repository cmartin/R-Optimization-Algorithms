rm(list = ls())
source("algorithms/nelder_mead.R")


source("test_functions/MathewsFink.R")
(sol <- nelder_mead_minimizer(2,mf_f))


source("test_functions/Rosenbrock.R")
# Transform y function for NM algorithm
f <- function(params) {
  rosenbrock_y(params[1],params[2])
}
(sol <- nelder_mead_minimizer(2,f))


source("test_functions/Himmelblau.R")
# Transform y function for NM algorithm
g <- function(params) {
  himmelblau_f(params[1],params[2])
}
(sol <- nelder_mead_minimizer(2,g))


source("test_functions/LinearModel.R")
(sol <- nelder_mead_minimizer(2,lm_ss))
(sol <- nelder_mead_minimizer(3,lm_logL))
