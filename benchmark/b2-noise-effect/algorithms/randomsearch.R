# RANDOM SEARCH FOR OPTIMIZATION

fun = function(data, job, instance) {

	par.set = getParamSet(data)
  	control = makeMBOControl()
	control = setMBOControlTermination(control, max.evals = MAXEVAL + 1)

	des = generateRandomDesign(MAXEVAL, par.set)

	run = mbo(data, design = des, control = control, show.info = TRUE)
	opdf = data.frame(run$opt.path)
	opdf = opdf[opdf$dob == 0, ]
	opdf$dob = 1:nrow(opdf)
    
  if ("smoof_noisy_single_objective_function" %in% class(data)) {
    pl = getParamLengths(par.set)
    pn = getParamIds(par.set)
    if(pl > 1) {
      opdf$ytrue = apply(as.matrix(opdf[, paste(pn, 1:pl, sep = "")], ncol = pl), 1, getMeanFunction(data))
    } else {
      opdf$ytrue = apply(matrix(opdf[, getParamIds(par.set)], ncol = getParamLengths(par.set)), 1, getMeanFunction(data)) 
    }
  }

  	res = computeFictionalReturnValue(par.set, run, data)
  	opdf = merge(opdf, res, all.x = TRUE, by = "dob")
    
  return(list(opt.path = opdf, fun = data))
}


ades = data.table()

randomsearch = list(fun = fun, ades = ades)
