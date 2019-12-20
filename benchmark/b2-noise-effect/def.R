# ---
# GENERAL DEFINITION FILE 
# ---

# contains general (task and algorithm-independent) setup
source("helpers.R")

# overwrite registry?
OVERWRITE = FALSE

# termination criterion for each run
MAXEVAL = 160L

# replication of each run 
REPLICATIONS = 25L


FUNS = list(
  "Sphere.2D" = makeSphereFunction(2),
  "Styblinsky" = makeStyblinkskiTangFunction()
  )

LEVELS =seq(0, 1, by = 0.2)

NOISE = lapply(LEVELS, function(x) {
  list(noise.var.fun = function(x) 1, noise.type = "constant", min.noise.var = x, max.noise.var = x)
})


names(NOISE) = paste("CONST", LEVELS, sep = "_") 