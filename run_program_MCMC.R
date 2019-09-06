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


### Run MCMC
pChain <- MCMC_model_fitting()

### briefly check the results
summary(pChain)
apply(pChain, 2, sd)

### make some plots
plot_posterior()

### predict final output
predict_final_output(pChain = pChain, return.option = "Check result")

print(tail(pChain))
