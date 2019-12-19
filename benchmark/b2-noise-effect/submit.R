# ---
# SUBMISSION SCRIPT ON LRZ CLUSTER
# ---

library(batchtools)

# Load Registry and Metadata
reg = loadRegistry("registry", writeable = TRUE)
reg$cluster.functions = makeClusterFunctionsSocket(2)

variants = unlist(lapply(ades, function(x) names(x)))
tab = summarizeExperiments(
	by = c("job.id", "algorithm", "problem", variants))

tosubmit = ijoin(tab, findNotDone())
tosubmit = tosubmit[repls == 1, ]

submitJobs(tosubmit)