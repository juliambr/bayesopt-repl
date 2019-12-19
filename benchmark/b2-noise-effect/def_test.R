# ---
# GENERAL DEFINITION FILE FOR TESTING
# ---

# contains general (task and algorithm-independent) setup

# overwrite registry?
OVERWRITE = TRUE

# termination criterion for each run
MAXEVAL = 40L

# replication of each run 
REPLICATIONS = 1L

FUNS = list(
  "Sphere.2D" = makeSphereFunction(1),
  "Styblinsky" = makeStyblinkskiTangFunction()
  )

LEVELS =seq(0, 1, by = 0.1)

NOISE = lapply(LEVELS, function(x) {
  list(noise.var.fun = function(x) 1, noise.type = "constant", min.noise.var = x, max.noise.var = x)
})


names(NOISE) = paste("CONST", LEVELS, sep = "_") 