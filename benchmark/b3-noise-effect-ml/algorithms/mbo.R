# MBO FOR OPTIMIZATION

fun = function(data, job, instance, repls, ...) {

	par.set = getParamSet(data)
  surr.km = makeLearner("regr.km", predict.type = "se", covtype = "matern3_2", par.vals = list(nugget.estim = TRUE, nugget.stability = 10^(-8)), control = list(trace = FALSE))
  control = makeMBOControl(store.model.at = c(0:MAXEVAL))
	control = setMBOControlTermination(control, max.evals = MAXEVAL)
	control = setMBOControlInfill(control, crit = makeMBOInfillCritEI())
  control = setMBOControlNoisy(control, instances = repls, instance.aggregation = mean)

	run = mbo(data, learner = surr.km, control = control, show.info = TRUE)
	opdf = data.frame(run$opt.path)
    
    if ("smoof_noisy_single_objective_function" %in% class(data)) {
      opdf$ytrue = apply(matrix(opdf[, getParamIds(par.set)], ncol = getParamLengths(par.set)), 1, getMeanFunction(data))
    }

  res = computeFictionalReturnValue(par.set, run, data)
  opdf = merge(opdf, res, all.x = TRUE, by = "dob")

  return(list(opt.path = opdf, fun = data))
}


ades = data.table(repls = c(1, 3, 5, 10))

mbofun = list(fun = fun, ades = ades)


