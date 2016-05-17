# Function tested in http://www.jasoncantarella.com/downloads/NelderMeadProof.pdf
mf_f <- function(params_vector) {
  x <- params_vector[1]
  y <- params_vector[2]
  x ^ 2 - 4*x + y ^ 2 - y - x*y
}

# Minimum should be found at x=3,y=2
