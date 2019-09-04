##### This is the code repository for re-analyzing EucFACE modeling simulation output
#####
#####
##### Mingkai Jiang
##### m.jiang@westernsydney.edu.au

########################################################################################
#### clear wk space
rm(list=ls(all=TRUE))

#### prepare
source("prepare.R")

### source the constants
source("initial_constants/initialize_aCO2_constants_2.R")

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
#params <- aCO2.fitted$par

### use fitted parameters to generate targeting tot C and tot tau
targDF <- EucFACE_C_budget_model_prefit_output(params)

obsDF <- data.frame(Rhet.amb.mean, targDF$tot.C, targDF$tot.tau, 
           Rhet.amb.sd, targDF$tot.C*0.1, targDF$tot.tau*0.1)
colnames(obsDF) <- c("Rhet.amb.mean", "totC.amb.mean", "tau.amb.mean",
                     "Rhet.amb.sd", "totC.amb.sd", "tau.amb.sd")

### prepare the input dataframe
#inDF <- initialize_input_dataframe(n=100)
#GPP <- inDF[[1]]
#NPP <- inDF[[2]]
#Pools <- inDF[[3]]
#delta <- inDF[[4]]

pChain <- MCMC_model_fitting_2()

### subset only accepted data
#pChain <- subset(pChain, Prior == 1)
#pChain <- pChain[40000:45000,]

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

print(output.final.set)
print(obsDF)


print(param.set)
print(aCO2.fitted$par)
