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

### prepare the input dataframe
inDF <- initialize_input_dataframe(n=100)
GPP <- inDF[[1]]
NPP <- inDF[[2]]
Pools <- inDF[[3]]
delta <- inDF[[4]]

### Assign inputs for MCMC
chainLength <- 1000
# Discard the first 10% iterations for Burn-IN in MCMC (According to Oijen, 2008)
bunr_in <- chainLength * 0.1 
pChain <- matrix(0, nrow=chainLength, ncol = no.var+1)
no.param <- 1

### Defining the variance-covariance matrix for proposal generation
vcov = (0.005*(params.upper-params.lower))^2
vcovProposal =  vcov # The higher the coefficient, the higher the deviations in parameter time series

### Find the Prior probability density
prior.dist = vector("list", no.var)
for (i in 1:no.var) {
    prior.dist[i] = list(log(dnorm(params[i], (params.lower[i] + params.upper[i])/2, 
                                   (params.upper[i] - params.lower[i])/3))) # Prior normal gaussian distribution
}
logPrior0 <- sum(unlist(prior.dist))

for (j in 1:100) {
    output.set <- EucFACE_C_budget_model(params=params, 
                                         GPP=GPP[j,], 
                                         NPP=NPP[j,], 
                                         Pools=Pools[j,], 
                                         delta=delta[j,])
    
    if (j == 1) {
        output = output.set
    }
    if (j > 1) {
        output = rbind(output,output.set)
    }
}

#### Calculate log likelihood of starting point of the chain
logL0 <- log_likelihood(Rhet.mean = Rhet.amb.mean,
                       Rhet.sd = Rhet.amb.sd,
                       Rhet.pred = output) 

pChain[1,] <- c(params,logL0)

### Calculating the next candidate parameter vector, as a multivariate normal jump away from the current point
for (z in (2 : chainLength)) {
    candidatepValues = c()
    
    for (i in 1:no.var) {
        candidatepValues[i] = rmvnorm(n=1, mean=params[i],
                                       sigma=diag(vcovProposal[i],no.param)) 
    }

    # Reflected back to generate another candidate value
    reflectionFromMin = pmin( unlist(matrix(0,nrow=no.param,ncol=no.var)), 
                              unlist(candidatepValues-params.lower) )
    reflectionFromMax = pmax( unlist(list(rep(0, no.param))), 
                              unlist(candidatepValues-params.upper) )
    candidatepValues = candidatepValues - 2 * reflectionFromMin - 2 * reflectionFromMax 
    
    
    # Calculating the prior probability density for the candidate parameter vector
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
    } else {
        Prior1 <- 0
    }
    
    
    # Calculating the outputs for the candidate parameter vector and then log likelihood
    if (Prior1 > 0) {
        for (j in 1:100) {
            out.cand.set <- EucFACE_C_budget_model(params=candidatepValues, 
                                                 GPP=GPP[j,], 
                                                 NPP=NPP[j,], 
                                                 Pools=Pools[j,], 
                                                 delta=delta[j,])
            
            
            if (j == 1) {
                out.cand = out.cand.set
            }
            if (j > 1) {
                out.cand = rbind(out.cand,out.cand.set)
            }
        }
        
        # Calculate log likelihood
        logL1 <- log_likelihood(Rhet.mean = Rhet.amb.mean,
                                Rhet.sd = Rhet.amb.sd,
                                Rhet.pred = out.cand) 
        
        # Calculating the logarithm of the Metropolis ratio
        logalpha <- (logPrior1+logL1) - (logPrior0+logL0) 
        
        # Accepting or rejecting the candidate vector
        pValues <- candidatepValues
        logPrior0 <- logPrior1
        logL0 <- logL1
        
    }
    
    pChain[z,] <- c(pValues,logL0)
    
}


# Discard the first 500 iterations for Burn-IN in MCMC
pChain <- pChain[(bunr_in+1):nrow(pChain),]
pChain = as.data.frame(pChain)


names(pChain) <- c("tau.micr", "tau.soil", "tau.bg.lit", 
                   "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr","logli")


# Store the final parameter set values
param.set = colMeans(pChain[ , 1:(no.param*no.var)])
param.SD = apply(pChain[ , 1:(no.param*no.var)], 2, sd)
param.final = data.frame(matrix(ncol = (no.var)*2, nrow = no.param))

names(param.final) <- c("tau.micr", "tau.soil", "tau.bg.lit", 
                        "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr",
                        "tau.micr.sd", "tau.soil.sd", "tau.bg.lit.sd", 
                        "frac.myco.sd", "frac.ag.lit.sd", "frac.bg.lit.sd", "frac.micr.sd")

param.final[,1:7] = param.set
param.final[,8:14] = param.SD


# Calculate final output set from the predicted parameter set
output.final.set <- EucFACE_C_budget_model(params=param.set, 
                                           GPP=GPP.amb.mean, 
                                           NPP=NPP.amb.mean, 
                                           Pools=Pools.amb.mean, 
                                           delta=Delta.amb.mean)

