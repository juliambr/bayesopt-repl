# The Effect of Noise in Bayesian Optimization 


## Scenario 

Given we can access evaluations of a function up to some noise term: 

$$
	y(x) = f(x) + \eps, \qquad \eps \sim \mathcal{N}(0, \tau^2(x)), 
$$

we want to solve the following optimization problem 

$$
	\min_x \mathbb{E}(f(x))
$$


## Main Question 

What is the effect of the noise type / noise level on the outcome of Bayesian Optimization? 

* Does a higher noise-level lead to worse optimization results? 
* Can the type of return work against this effect? 
	* best observed during run (of course noisy)
	* best predicted according to model  
* Can we say something about model quality? 
* Can we divide the overall error into
	* error due to misleading / bad steps / bad model
	* error due to false identification
* What is overfitting? How can it be formalilzed? How can it be avoided? 

## Experimental Considerations



### Synthetic Test Functions 


#### Problem Design 

| Function | Dimension | Property | 
|---|---|---|
| Sphere  | 2D  | Convex, unique global minimum |   
| StyblinskyTang  | 2D |   |   


#### Return Type 


#### 


### Real Machine Learning Problems 