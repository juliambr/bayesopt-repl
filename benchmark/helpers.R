# ---
# HELPER FUNCTIONS 
# ---

readProblem = function(fun, noise) {

  fn.mean = FUNS[[fun]]
  noise.attr = NOISE[[noise]]

  makeNoisySingleObjectiveFunction(
  	fn.mean = fn.mean, fn.noise = noise.attr$noise.var.fun, noise.type = noise.attr$noise.type,
  	min.noise.var = noise.attr$min.noise.var, max.noise.var = noise.attr$max.noise.var, 
  	par.set = getParamSet(fn.mean)
  	)
}

computeFictionalReturnValue = function(par.set, run, fun) {
	
	opdf = data.frame(run$opt.path)
	n.ninit = sum(opdf$dob == 0)

    pl = getParamLengths(par.set)
    pn = getParamIds(par.set)

    if (pl > 1) {
    	pn = paste(pn, 1:pl, sep = "")
    }

	# compute the fictional best if the returned value is the best predicted
	models = run$models

	if (length(run$models) != 0) {
		des = generateDesign(n = 10000, par.set)
		res1 = lapply(models[2:length(models)], function(m) {
			ret = which.min(predict(m, newdata = des)$data$response)
			x = des[ret, ]
			y = getMeanFunction(fun)(x)
			c(x = x, ytrue = y)
		})
		res1 = as.data.frame(do.call(rbind, res1))
		names(res1) = paste("pred_best_", names(res1), sep = "")
	} else {
		opdf$dob = 1:nrow(opdf)
		# dummy
		dummy = data.frame(replicate(pl + 1, replicate(nrow(opdf), NA)))
		res1 = data.frame(dummy)
		names(res1) = paste("pred_best_", c(pn, "y"), sep = "")		
	}

	# compute the fictional best if the best point in design is returned
	res2 = lapply(unique(opdf$dob), function(d) {
		opdf_red = opdf[opdf$dob <= d, ]
		opdf_agg = setDT(opdf_red)[, mean := mean(y), by = pn]
		ret = which.min(opdf_agg$mean)
		x = data.frame(opdf_agg)[ret, pn]
		y = opdf_agg[ret, ]$mean
		ytrue = getMeanFunction(fun)(x)
		c(x, y = y, ytrue = ytrue)
	})
	res2 = as.data.frame(do.call(rbind, res2))
	names(res2) = paste("design_best_", names(res2), sep = "")

	res = cbind(res1, res2)
	res = cbind(dob = 0:(nrow(res) - 1), res)

	return(res)
}


plotModelPrediction = function(run, d, fun) {

	opdf = data.frame(run$opt.path)
	df = opdf[opdf$dob <= d, ]
	n.ninit = sum(opdf$dob == 0)

	models = run$models
	mod = models[[nrow(df) - n.ninit + 1]]

	des = generateDesign(1000, par.set)
	preds = predict(mod, newdata = des)
	des$pred = preds$data$response

	p = autoplot(fun)
	p = p + geom_point(data = df, aes(x = x, y = y, color = prop.type))
	p = p + geom_line(data = des, aes(x = x, y = pred), color = "green")
	# p = p + geom_point(data = df[nrow(df), ], aes(x = x, y = pred_best_ytrue))
	p = p + theme_bw()
	p
}
