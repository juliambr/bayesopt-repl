# ---
# SUBMISSION SCRIPT ON LRZ CLUSTER
# ---

library(batchtools)

# Load Registry and Metadata
reg = loadRegistry("registry", writeable = TRUE)
tab = summarizeExperiments(
	by = c("job.id", "algorithm", "problem", "repls"))

# Serial cluster 
# resources.serial = list(
# 	walltime = 3600L * 96L, memory = 1024L * 4L,
# 	clusters = "serial", max.concurrent.jobs = 1000L # get name from lrz homepage)
# )

# resources.mpp2 = list(ncpus = 15L,
#     walltime = 3600L * 48L, memory = 1024L * 4L,
#     clusters = "mpp2") # get name from lrz homepage))


tosubmit = ijoin(tab, findNotDone())
#tosubmit = tosubmit[algorithm == "randomsearch", ] # maybe filter for variants to be run
# submitJobs(tosubmit, resources = resources.serial)

submitJobs(tosubmit)