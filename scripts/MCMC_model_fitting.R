MCMC_model_fitting <- function() {
    
    ### Assign chain length for MCMC parameter fitting
    chainLength <- 500000
    
    ### Discard the first 10% iterations for Burn-IN in MCMC (According to Oijen, 2008)
    burn_in <- chainLength * 0.5 
    
    ### prepare output df
    pChain <- matrix(0, nrow=chainLength, ncol = no.var+7+2)
    
    ### set up number of parameters to fit at each run
    no.param=1
    
    ### prepare model aic and bic comparison DF
    k1 = 2 # k = 2 for the usual AIC
    npar = no.param*no.var # npar = total number of parameters in the fitted model
    k2 = log(1) # n being the number of observations for the so-called BIC
    
    
    
    ### Defining the variance-covariance matrix for proposal generation
    vcovProposal = diag( (0.5*(params.upper-params.lower))^2 ) 
    #vcov = (0.5*(params.upper-params.lower))^2
    #vcovProposal =  vcov 
    
    
    ### Find the Prior probability density
    prior.dist = vector("list", no.var)
    for (i in 1:no.var) {
        # Prior normal gaussian distribution
        prior.dist[i] = list(log(dnorm(params[i], (params.lower[i] + params.upper[i])/2, 
                                       (params.upper[i] - params.lower[i])/3))) 
    }
    logPrior0 <- sum(unlist(prior.dist))
    Prior0 <- exp(logPrior0)
    
    #Prior0 = prod((params.upper-params.lower)^-1) 
    #logPrior0 = log(Prior0)
    
    
    ### Run the model, with initial parameter settings
    ### return initial output
    out.init <- EucFACE_C_budget_model(params=params, 
                                       GPP=GPP.amb.mean, 
                                       NPP=NPP.amb.mean, 
                                       Pools=Pools.amb.mean, 
                                       delta=Delta.amb.mean)
    
    
    #### Calculate log likelihood of starting point of the chain
    #### the best we can get is -4.89784 if pred = obs
    logL0 <- log_likelihood(Rhet.mean = Rhet.amb.mean,
                              Rhet.sd = Rhet.amb.sd,
                              Rhet.pred = out.init$Rhet) 
    
    aic <- -2*logL0 + k1*npar
    bic <- -2*logL0 + k2*npar
    
    pChain[1,] <- c(params, logL0, as.numeric(out.init), Prior0, aic, bic)

    
    
    ### Calculating the next candidate parameter vector, 
    ### as a multivariate normal jump away from the current point
    for (z in (2 : chainLength)) {
        candidatepValues = c()
        
        candidatepValues = rmvnorm(n=no.param, mean=params,
                                   sigma=vcovProposal) 
        
        #for (i in 1:no.var) {
        #    candidatepValues[i] = rmvnorm(n=1, mean=params[i],
        #                                   sigma=diag(vcovProposal[i],no.param)) 
        #}
        
        ### Reflected back to generate another candidate value
        reflectionFromMin = pmin( unlist(matrix(0,nrow=no.param,ncol=no.var)), 
                                  unlist(candidatepValues-params.lower) )
        reflectionFromMax = pmax( unlist(list(rep(0, no.var))), 
                                  unlist(candidatepValues-params.upper) )
        candidatepValues = candidatepValues - 2 * reflectionFromMin - 2 * reflectionFromMax 
        
        
        ### Calculating the prior probability density for the candidate parameter vector
        if (all(candidatepValues>params.lower) && all(candidatepValues<params.upper)){
            uni.dist = vector("list", no.var)
            
            # Prior normal gaussian distribution
            for (i in 1:no.var) {
                uni.dist[i] = list(log(dnorm(candidatepValues[i], 
                                             (params.lower[i] + params.upper[i])/2, 
                                             (params.upper[i] - params.lower[i])/3))) 
            }
            logPrior1 <- sum(unlist(uni.dist))
            Prior1 = 1
            
            #Prior1 <- prod((params.upper-params.lower)^-1)
            #logPrior1 <- log(Prior1)
            
        } else {
            Prior1 <- 0
        }
        
        
        ### Calculating the outputs for the candidate parameter vector and then log likelihood
        if (Prior1 > 0) {
            
            out.cand <- EucFACE_C_budget_model(params=candidatepValues, 
                                               GPP=GPP.amb.mean, 
                                               NPP=NPP.amb.mean, 
                                               Pools=Pools.amb.mean, 
                                               delta=Delta.amb.mean)
            
            
            # Calculate log likelihood
            logL1 <- log_likelihood(Rhet.mean = Rhet.amb.mean,
                                      Rhet.sd = Rhet.amb.sd,
                                      Rhet.pred = out.cand$Rhet) 
            
            # Calculating the logarithm of the Metropolis ratio
            logalpha <- (logPrior1+logL1) - (logPrior0+logL0) 
            
            # Accepting or rejecting the candidate vector
            pValues <- candidatepValues
            logPrior0 <- logPrior1
            logL0 <- logL1
            
            aic <- -2*logL1 + k1*npar
            bic <- -2*logL1 + k2*npar
            
        }
        
        pChain[z,] <- c(pValues, logL0, as.numeric(out.cand), Prior1, aic, bic)
        
    }
    
    
    ### Discard the first 10% iterations for Burn-IN in MCMC
    pChain <- pChain[(burn_in+1):nrow(pChain),]
    pChain <- as.data.frame(pChain)
    
    ### assign names
    names(pChain) <- c("tau.micr", "tau.soil", "tau.bg.lit", 
                       "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr",
                       "logli", "tot.C", "tot.tau", "tot.GPP", "tot.NPP", "Rhet", "Prior",
                       "aic", "bic")
    
    
    ### display acceptance rate
    nAccepted = length(unique(pChain[,1]))
    #nAccepted = length(pChain[pChain$Prior==1, "Prior"])
    
    acceptance = (paste("Total accepted: ", nAccepted, 
                        "out of ", chainLength-burn_in, 
                        "candidates accepted ( = ",
                        round(100*nAccepted/chainLength), "%)"))
    print(acceptance)
    
    
    return(pChain)
}