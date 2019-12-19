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
  "Sphere.1D" = makeSphereFunction(1),
  "Ackley.1D" = makeAckleyFunction(1),
  "Alpine01.1D" = makeAlpine01Function(1)
  )

NOISE = list(
  "NO" = list(noise.var.fun = function(x) 1, noise.type = "constant", min.noise.var = 0, max.noise.var = 0),
  "LinearIncWithX" = list(noise.var.fun = function(x) x, noise.type = "x", min.noise.var = 0.1, max.noise.var = 0.7),
  "LinearDecWithY" = list(noise.var.fun = function(x) x, noise.type = "y", min.noise.var = 0.1, max.noise.var = 0.7),
  "LinearDecWithX" = list(noise.var.fun = function(x) x, noise.type = "x", min.noise.var = 0.1, max.noise.var = 0.7),
  "LinearDecWithY" = list(noise.var.fun = function(x) x, noise.type = "y", min.noise.var = 0.1, max.noise.var = 0.7)
  )
