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
REPLICATIONS = 20L


FUNS = list(
  "Sphere.1D" = makeSphereFunction(1),
  "Ackley.1D" = makeAckleyFunction(1),
  "Alpine01.1D" = makeAlpine01Function(1)
  )

NOISE = list(
  "NO" = list(noise.var.fun = function(x) 1, noise.type = "constant", min.noise.var = 0, max.noise.var = 0),
  "LinearIncWithX.low" = list(noise.var.fun = function(x) x, noise.type = "x", min.noise.var = 0.1, max.noise.var = 0.35),
  "LinearIncWithY.low" = list(noise.var.fun = function(x) x, noise.type = "y", min.noise.var = 0.1, max.noise.var = 0.35),
  "LinearDecWithY.low" = list(noise.var.fun = function(x) x, noise.type = "y", min.noise.var = 0.1, max.noise.var = 0.35),
  "LinearIncWithX.high" = list(noise.var.fun = function(x) x, noise.type = "x", min.noise.var = 0.1, max.noise.var = 0.7),
  "LinearIncWithY.high" = list(noise.var.fun = function(x) x, noise.type = "y", min.noise.var = 0.1, max.noise.var = 0.7),
  "LinearDecWithY.high" = list(noise.var.fun = function(x) x, noise.type = "y", min.noise.var = 0.1, max.noise.var = 0.7)
  )
