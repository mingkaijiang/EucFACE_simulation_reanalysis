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
#inDF <- initialize_input_dataframe(n=100)
#GPP <- inDF[[1]]
#NPP <- inDF[[2]]
#Pools <- inDF[[3]]
#delta <- inDF[[4]]

pChain <- MCMC_model_fitting()

### look at subset
subDF <- pChain[pChain$Rhet >= (Rhet.amb.mean-Rhet.amb.sd) & pChain$Rhet <= (Rhet.amb.mean+Rhet.amb.sd), ]
dim(subDF)

# Store the final parameter set values
#param.set = colMeans(subDF[ , 1:no.var])
#param.SD = apply(subDF[ , 1:no.var], 2, sd)
#param.final = data.frame(matrix(ncol = (no.var)*2, nrow = no.param))
#
#names(param.final) <- c("tau.micr", "tau.soil", "tau.bg.lit", 
#                        "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr",
#                        "tau.micr.sd", "tau.soil.sd", "tau.bg.lit.sd", 
#                        "frac.myco.sd", "frac.ag.lit.sd", "frac.bg.lit.sd", "frac.micr.sd")
#
#param.final[,1:7] = param.set
#param.final[,8:14] = param.SD
#
#param.set <- as.numeric(param.set)
#
## Calculate final output set from the predicted parameter set
#output.final.set <- EucFACE_C_budget_model(params=param.set, 
#                                           GPP=GPP.amb.mean, 
#                                           NPP=NPP.amb.mean, 
#                                           Pools=Pools.amb.mean, 
#                                           delta=Delta.amb.mean)
#
#print(param.set)
#print(param.final)

Rhet.pred <- data.frame(round(mean(subDF$Rhet),2), 
                        round(sd(subDF$Rhet), 2), nrow(subDF))
colnames(Rhet.pred) <- c("Rhet.mean", "Rhet.sd", "sample")

#print(paste0("Final predicted = ", output.final.set))
print(paste0("Final range = ", Rhet.pred$Rhet.mean, " (", Rhet.pred$Rhet.sd, ")"))


