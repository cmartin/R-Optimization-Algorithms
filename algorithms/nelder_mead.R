# Nelder-Mead minimizer, as described in Nelder & Mead's 1965 paper

source("utils/se.R")

nelder_mead_minimizer <- function(
  n, # how many parameters is the problem
  f, # the function to minimize
  alpha = 1, # reflecion coefficient
  gamma = 1, # expansion coefficient
  beta = 0.5, # contraction coefficient
  max_iterations = 200,
  tolerance = 1e-08 # standard error of predicted y before we stop
  ) {

  # Generate starting simplex from random values
  P <- matrix(ncol = n, nrow = n+1, data = runif(n*(n+1)))

  for (i in 1:max_iterations) {
    h <- which.max(apply(P, 1, f)) # Worst vertex
    l <- which.min(apply(P, 1, f)) # Best vertex
    mean_P <- colMeans(P[-h,]) # Centroid

    # Calculate reflecion point (P* in article)
    P_s <- (1+alpha) * mean_P - alpha * P[h,]

    # Calculate f at reflection vertex and compare with best vertex
    y_s <- f(P_s)
    y_l <- f(P[l,])
    if(y_s <y_l) {

      # if reflection vertex is best, see if we can expand further
      P_ss <- (1+gamma)*P_s - gamma*mean_P
      y_ss <- f(P_ss)

      # if expanded vertex is best, keep it, else, keep reflection
      if(y_ss < y_l) {
        P[h,] <- P_ss
      } else {
        P[h,] <- P_s
      }

    } else {
      if (all(y_s > apply(P[-h,],1,f))) {

        y_h <- f(P[h,])
        if(!(y_s > y_h)) {
          P[h,] <- P_s
        }
        P_ss <- beta * P[h,] + (1-beta) * mean_P # Find contraction vertex
        y_ss <- f(P_ss)

        if (y_ss > y_h) { # Contraction failed
          # Scale the whole thing
          P <- (P + P[l,]) / 2
        } else {
          P[h,] <- P_ss
        }

      } else {
        P[h,] <- P_s
      }
    }

    # Checking for exit condition
    se <- std_err(apply(P,1,f))
    if (se < tolerance) {
      cat(paste0("Solution reached at iter ",i,"\r\n"))
      break
    }

  }

  if (i == max_iterations) {
    warning(paste("Algorithm did not converge in", i, "iterations\r\n"))
  }

  #P[which.min(apply(P,1,f)),]
  colMeans(P)

}
