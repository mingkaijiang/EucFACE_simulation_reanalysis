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
source("initial_constants/initialize_aCO2_parameters.R")

### reproduciable results
set.seed(15)

### prepare the input dataframe
obsDF <- initialize_obs_amb_dataframe()

### Run MCMC
pChain_aCO2_1 <- MCMC_model_fitting(params = params, 
                                    obs=obsDF[1,])

pChain_aCO2_2 <- MCMC_model_fitting(params = params, 
                                    obs=obsDF[2,])

pChain_aCO2_3 <- MCMC_model_fitting(params = params, 
                                    obs=obsDF[3,])

### briefly check the results
summary(pChain_aCO2_1)
apply(pChain_aCO2_1, 2, sd)

### combine the results
pChain <- rbind(pChain_aCO2_1, pChain_aCO2_2, pChain_aCO2_3)

### make some plots
plot_posterior(inDF = pChain, Trt = "aCO2")

### predict final output
predict_final_output(pChain = pChain, return.option = "Check result")

print(tail(pChain))
