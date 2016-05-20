# R implementations of classic optimization algorithms

This is a repository of code I've worked on following my week at the [Computation Ecology Summer School 2016](http://poisotlab.io/summerschool/)

This repository is mainly 3 folders : 
* [algorithms](algorithms) contains the optimization algorithms
* [test_functions](test_functions) contains some pre-built functions to test the algorithms
* [runners](runners) contains some scripts to test each algorithm on each test function

The following algorithms are implemented : 
* [simulated annealing](algorithms/simulated_annealing.R) (mostly as teached during the week)
* [genetic algorithm](algorithms/genetic_algorithm.R) (rewritten from scratch, now using elite parents that automatically survive and crossovers)
* [nelder-mead algorithm](algorithms/nelder_mead.R) (not seen during the week, but very cool to learn and very performant)

As of now, the genetic algorithm cannot run the log-likelihood linear model because there is no way to constrain the value of some parameters to a specific range

PS these functions were built mostly for readability, and thus are not optimized or coded for restarts etc.
Serious work should probably be done with R's more robust functions (e.g. optim etc.)

# References
The MATLAB help pages have some clear introductions to the algorithms, e.g. 
* http://www.mathworks.com/help/gads/genetic-algorithm.html, 
* http://www.mathworks.com/help/gads/simulated-annealing.html, 

especially the "Concepts" sections were very helpful.

And for the Nelder-Mead, reading the 2d (i.e. 2 parameters) examples was very helpful to visualize what was going on (e.g. http://www.scholarpedia.org/article/Nelder-Mead_algorithm)
