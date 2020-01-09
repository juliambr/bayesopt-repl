# ---
# SUBMISSION SCRIPT ON LRZ CLUSTER
# ---

library(batchtools)

# Load Registry and Metadata
reg = loadRegistry("registry", writeable = TRUE)
# reg$cluster.functions = makeClusterFunctionsSocket(2)

tab = summarizeExperiments(
	by = c("job.id", "algorithm", "problem", "repls"))

tosubmit = ijoin(tab, findNotDone())

resources.serial = list(
	walltime = 3600L * 96L, memory = 1024L * 4L,
	clusters = "serial", max.concurrent.jobs = 1000L # get name from lrz homepage)
)

tosubmit$chunk = chunk(tosubmit$job.id, chunk.size = 50)

submitJobs(tosubmit, resources = resources.serial)
