

res = readRDS("results/raw/resv1.rds")
res$fct = sapply(res$problem, function(x) strsplit(x, "\\_")[[1]][1])
res$noise = as.numeric(sapply(res$problem, function(x) strsplit(x, "\\_")[[1]][3]))

funs = unique(res$fct)

plotProblemProgress = function(res, fun) {
	resr = res[fct == fun, ]

	df = lapply(unique(resr$job.id), function(id) {
		df = resr[job.id == id, ]$result[[1]]$opt.path
		df$lambda = NULL
		df$ei = NULL
		df$cb = NULL
		cbind(job.id = id, df)
	})

	df = do.call(rbind, df)
	df = ijoin(res[, - c("result")], df, by = "job.id")
	df = df[, iter := 1:.N, by = c("job.id")]
	set(df, which(is.na(df[["repls"]])), "repls", 1)

	# average over the replications
	df$pred_best_ytrue = unlist(df$pred_best_ytrue)
	df$design_best_ytrue = unlist(df$design_best_ytrue)

	dfp = df[, .(pred_best_ytrue_mean = mean(pred_best_ytrue, na.rm = TRUE), 
					design_best_ytrue_mean = mean(design_best_ytrue, na.rm = TRUE)), by = c("iter", "algorithm", "problem", "repls", "noise")]
	
	dfp = reshape2::melt(dfp, id.vars = c("iter", "algorithm", "problem", "repls", "noise"))

	p = ggplot(data = dfp, aes(x = iter, y = value, colour = as.factor(noise), lty = variable)) + geom_line()
	p = p + theme_bw()

	return(p)
	# resr_testfuns = resr[!duplicated(resr$problem), ]
	# testfuns = lapply(resr_testfuns$result, function(x) x$fun)
	# names(testfuns) = resr_testfuns$problem

	# pl1 = do.call(gridExtra::grid.arrange, lapply(testfuns, autoplot))

	# grid.arrange(pl1, p, nrow = 1)
}

plotProblemProgress(res, funs[2])