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
#inDF <- initialize_input_dataframe(n=100)
#GPP <- inDF[[1]]
#NPP <- inDF[[2]]
#Pools <- inDF[[3]]
#delta <- inDF[[4]]

set.seed(15)

### Assign inputs for MCMC
chainLength <- 20000
# Discard the first 10% iterations for Burn-IN in MCMC (According to Oijen, 2008)
burn_in <- chainLength * 0.1 
pChain <- matrix(0, nrow=chainLength, ncol = no.var+2)
no.param=1

### Defining the variance-covariance matrix for proposal generation
vcovProposal = diag( (0.99*(params.upper-params.lower))^2 ) ;
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

#Prior0 = prod((params.upper-params.lower)^-1) 
#logPrior0 = log(Prior0)

output.set <- EucFACE_C_budget_model(params=params, 
                                     GPP=GPP.amb.mean, 
                                     NPP=NPP.amb.mean, 
                                     Pools=Pools.amb.mean, 
                                     delta=Delta.amb.mean)

output = output.set


#### Calculate log likelihood of starting point of the chain
#### the best we can get is -4.89784 if pred = obs
logL0 <- log_likelihood_3(Rhet.mean = Rhet.amb.mean,
                       Rhet.sd = Rhet.amb.sd,
                       Rhet.pred = output) 

pChain[1,] <- c(params,logL0, output)

### Calculating the next candidate parameter vector, 
### as a multivariate normal jump away from the current point
for (z in (2 : chainLength)) {
    candidatepValues = c()
    
    candidatepValues = rmvnorm(n=1, mean=params,
                               sigma=vcovProposal) 
    
    #for (i in 1:no.var) {
    #    candidatepValues[i] = rmvnorm(n=1, mean=params[i],
    #                                   sigma=diag(vcovProposal[i],no.param)) 
    #}

    # Reflected back to generate another candidate value
    reflectionFromMin = pmin( unlist(matrix(0,nrow=no.param,ncol=no.var)), 
                              unlist(candidatepValues-params.lower) )
    reflectionFromMax = pmax( unlist(list(rep(0, no.var))), 
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
        #logPrior1 <- sum(unlist(uni.dist))
        #Prior1 = 1
        
        Prior1 <- prod((params.upper-params.lower)^-1)
        logPrior1 <- log(Prior1)
        
    } else {
        Prior1 <- 0
    }
    
    
    # Calculating the outputs for the candidate parameter vector and then log likelihood
    if (Prior1 > 0) {
        
        out.cand.set <- EucFACE_C_budget_model(params=candidatepValues, 
                                               GPP=GPP.amb.mean, 
                                               NPP=NPP.amb.mean, 
                                               Pools=Pools.amb.mean, 
                                               delta=Delta.amb.mean)
        
        
        out.cand = out.cand.set
        
        
        # Calculate log likelihood
        logL1 <- log_likelihood_3(Rhet.mean = Rhet.amb.mean,
                                Rhet.sd = Rhet.amb.sd,
                                Rhet.pred = out.cand) 
        
        # Calculating the logarithm of the Metropolis ratio
        logalpha <- (logPrior1+logL1) - (logPrior0+logL0) 
        
        # Accepting or rejecting the candidate vector
        pValues <- candidatepValues
        logPrior0 <- logPrior1
        logL0 <- logL1
        
    }
    
    pChain[z,] <- c(pValues, logL0, out.cand)
    
}


# Discard the first 10% iterations for Burn-IN in MCMC
pChain <- pChain[(burn_in+1):nrow(pChain),]
pChain = as.data.frame(pChain)


names(pChain) <- c("tau.micr", "tau.soil", "tau.bg.lit", 
                   "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr","logli", "Rhet")


### display acceptance rate
nAccepted = length(unique(pChain[,1]))
acceptance = (paste("Total accepted: ", nAccepted, "out of ", chainLength-burn_in, "candidates accepted ( = ",
                    round(100*nAccepted/chainLength), "%)"))
print(acceptance)


### look at subset
subDF <- subset(pChain, logli > -4.9)
dim(subDF)

# Store the final parameter set values
param.set = colMeans(subDF[ , 1:no.var])
param.SD = apply(subDF[ , 1:no.var], 2, sd)
param.final = data.frame(matrix(ncol = (no.var)*2, nrow = no.param))

names(param.final) <- c("tau.micr", "tau.soil", "tau.bg.lit", 
                        "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr",
                        "tau.micr.sd", "tau.soil.sd", "tau.bg.lit.sd", 
                        "frac.myco.sd", "frac.ag.lit.sd", "frac.bg.lit.sd", "frac.micr.sd")

param.final[,1:7] = param.set
param.final[,8:14] = param.SD

param.set <- as.numeric(param.set)

# Calculate final output set from the predicted parameter set
output.final.set <- EucFACE_C_budget_model(params=param.set, 
                                           GPP=GPP.amb.mean, 
                                           NPP=NPP.amb.mean, 
                                           Pools=Pools.amb.mean, 
                                           delta=Delta.amb.mean)

Rhet.pred <- data.frame(round(mean(subDF$Rhet),2), 
                        round(sd(subDF$Rhet), 2), nrow(subDF))
colnames(Rhet.pred) <- c("Rhet.mean", "Rhet.sd", "sample")

print(paste0("Final predicted = ", output.final.set))
print(paste0("Final range = ", Rhet.pred$Rhet.mean, " (", Rhet.pred$Rhet.sd, ")"))


print(param.set)

print(param.final)
