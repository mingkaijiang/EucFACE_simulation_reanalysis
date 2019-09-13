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

### reproduciable results
set.seed(15)

### Assign chain length for MCMC parameter fitting
chainLength <- 100000

### set up step size for aCO2 
step.size.aCO2 <- 0.004 # 0.003

### set up distribution type for parameter space
dist.type <- "uniform"

########################################################################################
#### B. Estimate parameter uncertainties for ambient CO2 treatment
### step 1:
## this initial parameters explore wider parameter space
source("initial_constants/initialize_aCO2_parameters_wide_2.R")

### step 2: 
### prepare the input dataframe for aCO2 treatment
obsDF <- initialize_obs_amb_dataframe_2()

### step 3:
### Run MCMC - at aCO2 for each ring
## Ring 2
pChain_aCO2_1 <- MCMC_model_fitting_2(params = params.aCO2, 
                                      params.lower = params.aCO2.lower,
                                      params.upper = params.aCO2.upper,
                                      obs=obsDF[1,],
                                      chainLength=chainLength,
                                      dist.type=dist.type,
                                      step.size=step.size.aCO2)

generate_most_likely_outcome(inDF=pChain_aCO2_1,
                             obs=obsDF[1,])


plot_parameter_trace_within_parameter_space(params= params.aCO2, 
                                            params.lower = params.aCO2.lower,
                                            params.upper = params.aCO2.upper,
                                            inDF = pChain_aCO2_1,
                                            dist.type=dist.type,
                                            step.size=step.size.aCO2,
                                            chainLength=chainLength,
                                            Trt = "aCO2_1")


# Ring 3
pChain_aCO2_2 <- MCMC_model_fitting_2(params = params.aCO2, 
                                      params.lower = params.aCO2.lower,
                                      params.upper = params.aCO2.upper,
                                      obs=obsDF[2,],
                                      chainLength=chainLength,
                                      dist.type=dist.type,
                                      step.size=step.size.aCO2)

generate_most_likely_outcome(inDF=pChain_aCO2_2,
                             obs=obsDF[2,])

plot_parameter_trace_within_parameter_space(params= params.aCO2, 
                                            params.lower = params.aCO2.lower,
                                            params.upper = params.aCO2.upper,
                                            inDF = pChain_aCO2_2,
                                            dist.type=dist.type,
                                            step.size=step.size.aCO2,
                                            chainLength=chainLength,
                                            Trt = "aCO2_2")

# Ring 6
pChain_aCO2_3 <- MCMC_model_fitting_2(params = params.aCO2, 
                                      params.lower = params.aCO2.lower,
                                      params.upper = params.aCO2.upper,
                                      obs=obsDF[3,],
                                      chainLength=chainLength,
                                      dist.type=dist.type,
                                      step.size=step.size.aCO2)


generate_most_likely_outcome(inDF=pChain_aCO2_3,
                             obs=obsDF[3,])

plot_parameter_trace_within_parameter_space(params= params.aCO2, 
                                            params.lower = params.aCO2.lower,
                                            params.upper = params.aCO2.upper,
                                            inDF = pChain_aCO2_3,
                                            dist.type=dist.type,
                                            step.size=step.size.aCO2,
                                            chainLength=chainLength,
                                            Trt = "aCO2_3")


### step 5: 
### combine the results, and make some plots
pChain.aCO2 <- rbind(pChain_aCO2_1, pChain_aCO2_2, pChain_aCO2_3)

plot_posterior(inDF = pChain.aCO2, Trt = "aCO2", dist.type = dist.type,
               chainLength = chainLength)

### step 6: 
### predict final output, at mean aCO2
### print out the final predicted results 
### check if the Rhet is OKish?
predict_final_output_2(pChain = pChain.aCO2, 
                       obs = obsDF[4,],
                       return.option = "Check result")


########################################################################################
#### C: Check what parameters are needed for the eCO2 response
### step 1: 
### check if the aCO2 parameters can be directly applied to get the correct Rhet at eCO2
eco2DF <- initialize_obs_ele_dataframe_2()

predict_final_output_2(pChain = pChain.aCO2, 
                       obs = eco2DF[4,],
                       return.option = "Check result")

# answer: no.
# allocation does not change, and therefore the predicted Rhet is the same as aCO2 Rhet


### step 2: 
### read in parameter space for eCO2 treatment
source("initial_constants/initialize_eCO2_parameters_wide_2.R")

### set up step size for aCO2 and eCO2 
chainLength <- 500000
step.size.eCO2 <- 0.0004
dist.type <- "uniform"

### step 3:
### fit the model with eCO2 parameter space to get parameter uncertainties
# Ring 1
pChain_eCO2_1 <- MCMC_model_fitting_2(params = params.eCO2, 
                                      params.lower = params.eCO2.lower,
                                      params.upper = params.eCO2.upper,
                                      obs=eco2DF[1,],
                                      chainLength=chainLength,
                                      dist.type=dist.type,
                                      step.size=step.size.eCO2)

generate_most_likely_outcome(inDF=pChain_eCO2_1,
                             obs=eco2DF[1,])

plot_parameter_trace_within_parameter_space(params= params.eCO2, 
                                            params.lower = params.eCO2.lower,
                                            params.upper = params.eCO2.upper,
                                            inDF = pChain_eCO2_1,
                                            dist.type=dist.type,
                                            step.size=step.size.eCO2,
                                            chainLength=chainLength,
                                            Trt = "eCO2_1")


# ring 4
pChain_eCO2_2 <- MCMC_model_fitting_2(params = params.eCO2, 
                                      params.lower = params.eCO2.lower,
                                      params.upper = params.eCO2.upper,
                                      obs=eco2DF[2,],
                                      chainLength=chainLength,
                                      dist.type=dist.type,
                                      step.size=step.size.eCO2)

generate_most_likely_outcome(inDF=pChain_eCO2_2,
                             obs=eco2DF[2,])


plot_parameter_trace_within_parameter_space(params= params.eCO2, 
                                            params.lower = params.eCO2.lower,
                                            params.upper = params.eCO2.upper,
                                            inDF = pChain_eCO2_1,
                                            dist.type=dist.type,
                                            step.size=step.size.eCO2,
                                            chainLength=chainLength,
                                            Trt = "eCO2_2")


# ring 5
pChain_eCO2_3 <- MCMC_model_fitting_2(params = params.eCO2, 
                                      params.lower = params.eCO2.lower,
                                      params.upper = params.eCO2.upper,
                                      obs=eco2DF[3,],
                                      chainLength=chainLength,
                                      dist.type=dist.type,
                                      step.size=step.size.eCO2)

generate_most_likely_outcome(inDF=pChain_eCO2_3,
                             obs=eco2DF[3,])

plot_parameter_trace_within_parameter_space(params= params.eCO2, 
                                            params.lower = params.eCO2.lower,
                                            params.upper = params.eCO2.upper,
                                            inDF = pChain_eCO2_1,
                                            dist.type=dist.type,
                                            step.size=step.size.eCO2,
                                            chainLength=chainLength,
                                            Trt = "eCO2_3")


### step 4: 
### combine the results, and make some plots
pChain.eCO2 <- rbind(pChain_eCO2_1, pChain_eCO2_2, pChain_eCO2_3)

plot_posterior(inDF = pChain.eCO2, Trt = "eCO2", dist.type = dist.type,
               chainLength = chainLength)

### step 5: 
### predict final output, at mean eCO2 values
### print out the final predicted results 
### check if the Rhet is OKish?
predict_final_output_2(pChain = pChain.eCO2, 
                       obs = eco2DF[4,],
                       return.option = "Check result")



########################################################################################
#### D: Make aCO2 and eCO2 summary and comparison summaries
### step 1:
### compute a output table to summarize parameters and their uncertainties
make_parameter_summary_table()
