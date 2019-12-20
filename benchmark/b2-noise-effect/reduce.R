# ---
# SCRIPT TO REDUCR RESULTS
# ---

library(batchtools)
library(smoof)
library(ggplot2)

# --- 1. Load Registry and Metadata
reg = loadRegistry("registry", writeable = TRUE)
tab = summarizeExperiments(
	by = c("job.id", "algorithm", "problem", "repls"))

res = reduceResultsDataTable(findDone())
res = ijoin(tab, res, by = "job.id")

saveRDS(res, "results/raw/resv1.rds")

