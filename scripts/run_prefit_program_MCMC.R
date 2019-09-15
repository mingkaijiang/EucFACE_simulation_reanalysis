##### run prefit program to obtain prefit allocation parameters
########################################################################################
run_prefit_program_MCMC <- function(dist.type, obsDF, eco2DF,
                                    range.option) {
    
    ### Assign chain length for MCMC parameter fitting
    chainLength <- 5000
    
    ### set up step size for aCO2 
    step.size.aCO2 <- 0.25 # 0.004
    step.size.eCO2 <- 0.15 # 0.004
    
    ### step 1:
    ## this initial parameters explore prefit parameter space
    source("initial_constants/initialize_aCO2_prefit_parameters_wide_2.R")
    
    ### step 2:
    ### Run MCMC for prefit parameters - at aCO2 for each ring
    ## Ring 2
    pChain_aCO2_1 <- prefit_MCMC_model_fitting_2(params = prefit.params.aCO2, 
                                                 params.lower = prefit.params.aCO2.lower,
                                                 params.upper = prefit.params.aCO2.upper,
                                                 obs=obsDF[1,],
                                                 chainLength=chainLength,
                                                 dist.type=dist.type,
                                                 step.size=step.size.aCO2)
    
    
    generate_most_likely_prefit_outcome(inDF=pChain_aCO2_1,
                                        obs=obsDF[1,])
    
    
    # Ring 3
    pChain_aCO2_2 <- prefit_MCMC_model_fitting_2(params = prefit.params.aCO2, 
                                                 params.lower = prefit.params.aCO2.lower,
                                                 params.upper = prefit.params.aCO2.upper,
                                                 obs=obsDF[2,],
                                                 chainLength=chainLength,
                                                 dist.type=dist.type,
                                                 step.size=step.size.aCO2)
    
    generate_most_likely_prefit_outcome(inDF=pChain_aCO2_2,
                                        obs=obsDF[2,])
    
    
    # Ring 6
    pChain_aCO2_3 <- prefit_MCMC_model_fitting_2(params = prefit.params.aCO2, 
                                                 params.lower = prefit.params.aCO2.lower,
                                                 params.upper = prefit.params.aCO2.upper,
                                                 obs=obsDF[3,],
                                                 chainLength=chainLength,
                                                 dist.type=dist.type,
                                                 step.size=step.size.aCO2)
    
    
    generate_most_likely_prefit_outcome(inDF=pChain_aCO2_3,
                                        obs=obsDF[3,])
    
    
    ########################################################################################
    ### step 3: 
    ### read in parameter space for eCO2 treatment
    source("initial_constants/initialize_eCO2_prefit_parameters_wide_2.R")
    
    ### step 4:
    ### fit the model with eCO2 parameter space to get parameter uncertainties
    # Ring 1
    pChain_eCO2_1 <- prefit_MCMC_model_fitting_2(params = prefit.params.eCO2, 
                                                 params.lower = prefit.params.eCO2.lower,
                                                 params.upper = prefit.params.eCO2.upper,
                                                 obs=eco2DF[1,],
                                                 chainLength=chainLength,
                                                 dist.type=dist.type,
                                                 step.size=step.size.eCO2)
    
    generate_most_likely_prefit_outcome(inDF=pChain_eCO2_1,
                                        obs=eco2DF[1,])
    
    
    
    ## ring 4
    pChain_eCO2_2 <- prefit_MCMC_model_fitting_2(params = prefit.params.eCO2, 
                                                 params.lower = prefit.params.eCO2.lower,
                                                 params.upper = prefit.params.eCO2.upper,
                                                 obs=eco2DF[2,],
                                                 chainLength=chainLength,
                                                 dist.type=dist.type,
                                                 step.size=step.size.eCO2)
    
    generate_most_likely_prefit_outcome(inDF=pChain_eCO2_2,
                                        obs=eco2DF[2,])
    
    
    
    
    # ring 5
    pChain_eCO2_3 <- prefit_MCMC_model_fitting_2(params = prefit.params.eCO2, 
                                                 params.lower = prefit.params.eCO2.lower,
                                                 params.upper = prefit.params.eCO2.upper,
                                                 obs=eco2DF[3,],
                                                 chainLength=chainLength,
                                                 dist.type=dist.type,
                                                 step.size=step.size.eCO2)
    
    generate_most_likely_prefit_outcome(inDF=pChain_eCO2_3,
                                        obs=eco2DF[3,])
    
    
    ########################################################################################
    outDF <- data.frame(c(1:6), NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)
    colnames(outDF) <- c("Ring", "alloc.leaf", "alloc.wood", "alloc.froot", "alloc.myco",
                         "sd.leaf", "sd.wood", "sd.froot", "sd.myco",
                         "pos.leaf", "pos.wood", "pos.froot", "pos.myco",
                         "neg.leaf", "neg.wood", "neg.froot", "neg.myco")
    
    ### ring 1
    outDF[outDF$Ring=="1", 2:(no.var+2)] <- colMeans(pChain_eCO2_1[, 1:(no.var+1)])
    outDF[outDF$Ring=="1", 6:9] <- apply(pChain_eCO2_1[, 1:(no.var+1)], 2, sd)
    
    ### ring 4
    outDF[outDF$Ring=="4", 2:(no.var+2)] <- colMeans(pChain_eCO2_2[, 1:(no.var+1)])
    outDF[outDF$Ring=="4", 6:9] <- apply(pChain_eCO2_2[, 1:(no.var+1)], 2, sd)
    
    ### ring 5
    outDF[outDF$Ring=="5", 2:(no.var+2)] <- colMeans(pChain_eCO2_3[, 1:(no.var+1)])
    outDF[outDF$Ring=="5", 6:9] <- apply(pChain_eCO2_3[, 1:(no.var+1)], 2, sd)
    
    ### ring 2
    outDF[outDF$Ring=="2", 2:(no.var+2)] <- colMeans(pChain_aCO2_1[, 1:(no.var+1)])
    outDF[outDF$Ring=="2", 6:9] <- apply(pChain_aCO2_1[, 1:(no.var+1)], 2, sd)
    
    ### ring 3
    outDF[outDF$Ring=="3", 2:(no.var+2)] <- colMeans(pChain_aCO2_2[, 1:(no.var+1)])
    outDF[outDF$Ring=="3", 6:9] <- apply(pChain_aCO2_2[, 1:(no.var+1)], 2, sd)
    
    ### ring 6
    outDF[outDF$Ring=="6", 2:(no.var+2)] <- colMeans(pChain_aCO2_3[, 1:(no.var+1)])
    outDF[outDF$Ring=="6", 6:9] <- apply(pChain_aCO2_3[, 1:(no.var+1)], 2, sd)
    
    
    ## assign range
    if (range.option == "sd") {
        outDF$pos.leaf <- outDF$alloc.leaf + outDF$sd.leaf
        outDF$neg.leaf <- outDF$alloc.leaf - outDF$sd.leaf
        
        outDF$pos.wood <- outDF$alloc.wood + outDF$sd.wood
        outDF$neg.wood <- outDF$alloc.wood - outDF$sd.wood
        
        outDF$pos.froot <- outDF$alloc.froot + outDF$sd.froot
        outDF$neg.froot <- outDF$alloc.froot - outDF$sd.froot
        
        outDF$pos.myco <- outDF$alloc.myco + outDF$sd.myco
        outDF$neg.myco <- outDF$alloc.myco - outDF$sd.myco
    } else if (range.option == "minmax") {
        print("not written yet")
    }
    
    return(outDF)

}



