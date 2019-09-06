##### This is the code repository for re-analyzing EucFACE modeling simulation output
#####
#####
##### Mingkai Jiang
##### m.jiang@westernsydney.edu.au
########################################################################################
### clear wk space
rm(list=ls(all=TRUE))

### prepare
source("prepare.R")

### source the constants
source("initial_constants/initialize_aCO2_constants.R")

### reproduciable results
set.seed(15)

### prepare the input dataframe
obsDF <- initialize_obs_dataframe(GPP.mean = GPP.amb.mean, NPP.mean = NPP.amb.mean,
                                  Pools.mean = Pools.amb.mean, delta.mean = Delta.amb.mean,
                                  GPP.sd = GPP.amb.sd, NPP.sd = NPP.amb.sd,
                                  Pools.sd = Pools.amb.sd, delta.sd = Delta.amb.sd,
                                  Rhet.mean = Rhet.amb.mean, Rhet.sd = Rhet.amb.sd)

### return initial output
out.init <- EucFACE_C_budget_model(params=params, 
                                   GPP=GPP.amb.mean, 
                                   Ra=Ra.amb.mean, 
                                   Pools=Pools.amb.mean, 
                                   delta=Delta.amb.mean)


#### Calculate log likelihood of starting point of the chain
logL0 <- log_likelihood(obs = obsDF, pred = out.init) 


out <- metrop(log_likelihood, params, 1e3)


### Run MCMC
pChain <- MCMC_model_fitting()

summary(pChain)
apply(pChain, 2, sd)

### predict final output
predict_final_output(pChain = pChain, return.option = "Check result")

print(tail(pChain))
