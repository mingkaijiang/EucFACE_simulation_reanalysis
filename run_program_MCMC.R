##### This is the code repository for re-analyzing EucFACE modeling simulation output
#####
#####
##### Mingkai Jiang
##### m.jiang@westernsydney.edu.au
########################################################################################
#### A. set up the model and structure

### clear wk space
rm(list=ls(all=TRUE))

### prepare
source("prepare.R")

### Assign chain length for MCMC parameter fitting
chainLength <- 1000

### reproduciable results
set.seed(15)

########################################################################################
#### B. Estimate parameter uncertainties for ambient CO2 treatment
### step 1:
### source the parameter space
source("initial_constants/initialize_aCO2_parameters.R")

### step 2: 
### prepare the input dataframe for aCO2 treatment
obsDF <- initialize_obs_amb_dataframe()

### step 3:
### Run MCMC - at aCO2 for each ring
## Ring 2
pChain_aCO2_1 <- MCMC_model_fitting(params = params.aCO2, 
                                    params.lower = params.aCO2.lower,
                                    params.upper = params.aCO2.upper,
                                    obs=obsDF[1,],
                                    chainLength=chainLength)

## Ring 3
pChain_aCO2_2 <- MCMC_model_fitting(params = params.aCO2, 
                                    params.lower = params.aCO2.lower,
                                    params.upper = params.aCO2.upper,
                                    obs=obsDF[2,],
                                    chainLength=chainLength)

## Ring 6
pChain_aCO2_3 <- MCMC_model_fitting(params = params.aCO2, 
                                    params.lower = params.aCO2.lower,
                                    params.upper = params.aCO2.upper,
                                    obs=obsDF[3,],
                                    chainLength=chainLength)

## briefly check the results
summary(pChain_aCO2_1)
apply(pChain_aCO2_1, 2, sd)

### step 5: 
### combine the results, and make some plots
pChain <- rbind(pChain_aCO2_1, pChain_aCO2_2, pChain_aCO2_3)

plot_posterior(inDF = pChain, Trt = "aCO2")

### step 6: 
### predict final output, at mean aCO2
### print out the final predicted results 
### check if the Rhet is OKish?
predict_final_output(pChain = pChain, 
                     obs = obsDF[4,],
                     return.option = "Check result")


########################################################################################
#### C: Check what parameters are needed for the eCO2 response
### step 1: 
### check if the aCO2 parameters can be directly applied to get the correct Rhet at eCO2
eco2DF <- initialize_obs_ele_dataframe()

predict_final_output(pChain = pChain, 
                     obs = eco2DF[4,],
                     return.option = "Check result")

# answer: no.
# allocation does not change, and therefore the predicted Rhet is the same as aCO2 Rhet


### step 2: 
### read in parameter space for eCO2 treatment
source("initial_constants/initialize_eCO2_parameters.R")

### Assign chain length for MCMC parameter fitting
chainLength <- 1000

### step 3:
### fit the model with eCO2 parameter space to get parameter uncertainties
pChain_eCO2_1 <- MCMC_model_fitting(params = params.eCO2, 
                                    params.lower = params.eCO2.lower,
                                    params.upper = params.eCO2.upper,
                                    obs=eco2DF[4,],
                                    chainLength=chainLength)

summary(pChain_eCO2_1)


pChain_eCO2_2 <- MCMC_model_fitting(params = params.eCO2, 
                                    params.lower = params.eCO2.lower,
                                    params.upper = params.eCO2.upper,
                                    obs=eco2DF[2,],
                                    chainLength=chainLength)

pChain_eCO2_3 <- MCMC_model_fitting(params = params.eCO2, 
                                    params.lower = params.eCO2.lower,
                                    params.upper = params.eCO2.upper,
                                    obs=eco2DF[3,],
                                    chainLength=chainLength)


### briefly check the results
summary(pChain_eCO2)
#apply(pChain_eCO2, 2, sd)
