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

### optimize parameters to constrain the parameter space
### this is based on aCO2 pools and fluxes
aCO2.fitted <- Nelder_Mead(EucFACE_C_budget_model_prefit, 
                           params, 
                           lower=params.lower, 
                           upper=params.upper)


### the value of the parameters providing the minimum Rhet diff
### update the original parameter mean values
params <- aCO2.fitted$par

### use fitted parameters to generate targeting tot C and tot tau
targDF <- EucFACE_C_budget_model_prefit_output(params)


### prepare the input dataframe
obsDF <- initialize_obs_dataframe(GPP.mean = GPP.amb.mean, NPP.mean = NPP.amb.mean,
                                  Pools.mean = Pools.amb.mean, delta.mean = Delta.amb.mean,
                                  GPP.sd = GPP.amb.sd, NPP.sd = NPP.amb.sd,
                                  Pools.sd = Pools.amb.sd, delta.sd = Delta.amb.sd,
                                  Rhet.mean = Rhet.amb.mean, Rhet.sd = Rhet.amb.sd)


### Run MCMC
pChain <- MCMC_model_fitting()


# Store the final parameter set values
param.set = colMeans(pChain[, 1:7])
param.SD = apply(pChain[ , 1:7], 2, sd)
param.final = data.frame(matrix(ncol = (no.var)*2, nrow = 1))

names(param.final) <- c("tau.micr", "tau.soil", "tau.bg.lit", 
                        "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr",
                        "tau.micr.sd", "tau.soil.sd", "tau.bg.lit.sd", 
                        "frac.myco.sd", "frac.ag.lit.sd", "frac.bg.lit.sd", "frac.micr.sd")

param.final[,1:7] = param.set
param.final[,8:14] = param.SD

param.set <- round(as.numeric(param.set),3)

# Calculate final output set from the predicted parameter set
output.final.set <- EucFACE_C_budget_model(params=param.set, 
                                           GPP=GPP.amb.mean, 
                                           NPP=NPP.amb.mean, 
                                           Pools=Pools.amb.mean, 
                                           delta=Delta.amb.mean)

print(param.set)
print(param.final)
print(paste0("Final predicted = ", output.final.set$Rhet))



