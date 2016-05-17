# Rosenbrock's parabolic valley
# As described in Nelder & Mead's 1965 paper
# True minimum is 0
rosenbrock_y <- function(x1,x2) {
  100*(x2-x1^2)^2+(1-x1)^2
}

# x1 <- x2 <- seq(from= -5, to = 5, length.out = 20)
# z <- outer(x1,x2,rosenbrock_y)
# persp(x1,x2,z)
