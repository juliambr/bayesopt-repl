# ---
# BENCHMARK 
# ---


# ---
# 0.  Load libraries and helpers
# ---

# devtools::install_github("juliambr/smoof")
# install_github("mlr-org/mlrMBO", ref = "feature_noisy_incumbent_ocba")
packages = c( 
  "batchtools",
  "smoof", 
  "data.table", 
  "mlrMBO"
  ) 

lapply(packages, library, character.only = TRUE)

source("../helpers.R")

# ---
# 1.  Setup environment (test / no test) 
#     Registry will be loaded
# ---

TEST = FALSE # <-- ADAPT


if (TEST) {
  deffile = "def_test.R"  # <-- ADAPT def_test.R
  registry_name = "registry_test" 
} else {
  deffile = "def.R"       # <-- ADAPT def.R
  registry_name = "registry" 
}

source(deffile)

if (file.exists(registry_name)) {
  if (OVERWRITE) {
    unlink(registry_name, recursive = TRUE)
    reg = makeExperimentRegistry(file.dir = registry_name, seed = 123L,
      packages = packages, source = c(deffile, "../helpers.R"))
  } else {
    reg = loadRegistry(registry_name, writeable = TRUE)
  }
} else {
    reg = makeExperimentRegistry(file.dir = registry_name, seed = 123L,
      packages = packages, source = c(deffile, "../helpers.R"))
}

# ---
# 2.  Add Problems
# ---


source("pdes.R") # <-- ADAPT pdes.R

for (i in names(FUNS)) {
  for (j in names(NOISE)) {
    addProblem(
      name = paste(i, j, sep = "_"), 
      reg = reg, 
      data = readProblem(i, j)
    )
  }
}


# ---
# 3. Add Algorithms 
# ---

source("ades.R") # <-- ADAPT ades.R

for (i in 1:length(ALGORITHMS)) {
  addAlgorithm(name = names(ALGORITHMS)[i], reg = reg, fun = ALGORITHMS[[i]]$fun)  
}


# ---
# 4. Add Experiments
# ---

addExperiments(
  reg = reg, 
  algo.designs = ades, 
  repls = REPLICATIONS)

