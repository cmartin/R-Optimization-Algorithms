#https://en.wikipedia.org/wiki/Himmelblau%27s_function

himmelblau_f <- function(x,y) {
  (x^2+y-11)^2+(x+y^2-7)^2
}
# Maximum is at x = -0.270845, y = -0.923039

# Four identical minima
# f(3.0, 2.0) = 0.0,
# f(-2.805118, 3.131312) = 0.0,
# f(-3.779310, -3.283186) = 0.0,
# f(3.584428, -1.848126) = 0.0.
