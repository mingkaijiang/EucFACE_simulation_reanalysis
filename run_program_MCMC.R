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

source("initialize_aCO2_constants.R")

### set number of parameter variables
no.var <- 7

### EucFACE aCO2
params <- c(0.1,          # tau.micr.amb
            0.02,          # tau.soil.amb
            1.55,         # tau.bg.lit.amb
            0.5,          # frac.myco.amb
            0.5,          # frac.ag.amb
            0.5,          # frac.bg.amb
            0.5           # frac.micr.amb
)
params.lower <- c(0.01,
                  0.0001,
                  0.1,
                  0,
                  0,
                  0,
                  0)


params.upper <- c(100.0,
                  1.0,
                  5,
                  1.0,
                  1.0,
                  1.0,
                  1.0)

### set NPP
NPP <- rnorm(n = 100, mean=608.7, sd=100)

# Defining the variance-covariance matrix for proposal generation
vcov = (0.005*(params.upper-params.lower))^2
vcovProposal =  vcov # The higher the coefficient, the higher the deviations in parameter time series

# Find the Prior probability density
prior.dist = vector("list", no.var)
for (i in 1:no.var) {
    prior.dist[i] = list(log(dnorm(params[i], (params.lower[i] + params.upper[i])/2, 
                                   (params.upper[i] - params.lower[i])/3))) # Prior normal gaussian distribution
}
logPrior0 <- sum(unlist(prior.dist))

for (j in 1:100) {
    output.set <- traceability_EucFACE_aCO2_test(params, NPP[j])
    
    if (j == 1) {
        output = output.set
    }
    if (j > 1) {
        output = rbind(output,output.set)
    }
}


logLikelihood <- function (data,output,model.comparison) {
    logLi <- matrix(0, nrow=nrow(data), ncol = 1) # Initialising the logLi
    for (i in 1:nrow(data)) {
        if (!is.na(data$Mleaf[i])) {
            logLi[i] = - 0.5*((output$Mleaf[i] - data$Mleaf[i])/data$Mleaf_SD[i])^2 - log(data$Mleaf_SD[i]) - log(2*pi)^0.5
        }
        if (!is.na(data$Mstem[i])) {
            logLi[i] = logLi[i] - 0.5*((output$Mstem[i] - data$Mstem[i])/data$Mstem_SD[i])^2 - log(data$Mstem_SD[i]) - log(2*pi)^0.5
        }
        if (!is.na(data$Mroot[i])) {
            logLi[i] = logLi[i] - 0.5*((output$Mroot[i] - data$Mroot[i])/data$Mroot_SD[i])^2 - log(data$Mroot_SD[i]) - log(2*pi)^0.5
        }
        if (model.comparison==F) {
            if (!is.null(data$Sleaf)) {
                if (!is.na(data$Sleaf[i])) {
                    logLi[i] = logLi[i] - 0.5*((output$Sleaf[i] - data$Sleaf[i])/data$Sleaf_SD[i])^2 - log(data$Sleaf_SD[i]) - log(2*pi)^0.5
                }
            }
        }
    }
    return(sum(logLi))
}

logL0 <- logLikelihood(data,output,model.comparison) # Calculate log likelihood of starting point of the chain

pChain[1,] <- c(params,logL0)

# Calculating the next candidate parameter vector, as a multivariate normal jump away from the current point
for (c in (2 : chainLength)) {
    candidatepValues = matrix(ncol = no.var, nrow = no.param)
    for (i in 1:no.var) {
        candidatepValues[,i] = rmvnorm(n=1, mean=pValues[,i],
                                       sigma=diag(vcovProposal[,i],no.param)) 
    }
    candidatepValues = data.frame(candidatepValues)
    
    names(candidatepValues) <- c("Y","af","as","sf")
    
    
    # Reflected back to generate another candidate value
    reflectionFromMin = pmin( unlist(matrix(0,nrow=no.param,ncol=no.var)), unlist(candidatepValues-pMinima) )
    reflectionFromMax = pmax( unlist(list(rep(0, no.param))), unlist(candidatepValues-pMaxima) )
    candidatepValues = candidatepValues - 2 * reflectionFromMin - 2 * reflectionFromMax 
    
    
    # Calculating the prior probability density for the candidate parameter vector
    if (all(candidatepValues>pMinima) && all(candidatepValues<pMaxima)){
        uni.dist = vector("list", no.var)
        for (i in 1:no.var) {
            uni.dist[i] = list(log(dnorm(candidatepValues[ , i], (pMinima[ , i] + pMaxima[ , i])/2, (pMaxima[ , i] - pMinima[ , i])/3))) # Prior normal gaussian distribution
        }
        logPrior1 <- sum(unlist(uni.dist))
        Prior1 = 1
    } else {
        Prior1 <- 0
    }
    
    
    # Calculating the outputs for the candidate parameter vector and then log likelihood
    if (Prior1 > 0) {
        for (j in 1:length(v)) {
            data.set = subset(data,(volume %in% vol[v[j]]))
            Mleaf = Mstem = Mroot = c()
            Mleaf[1] <- data.set$Mleaf[1]
            Mstem[1] <- data.set$Mstem[1]
            Mroot[1] <- data.set$Mroot[1]
            
            
            out.cand.set = model.without.storage(data.set$GPP,data.set$Rd,no.param,Mleaf,Mstem,Mroot,candidatepValues$Y,
                                                 candidatepValues$af,candidatepValues$as,candidatepValues$sf)
            
            
            out.cand.set$volume = as.factor(vol[v[j]])
            if (j == 1) {
                out.cand = out.cand.set
            }
            if (j > 1) {
                out.cand = rbind(out.cand,out.cand.set)
            }
        }
        
        data = data[order(data$volume),]
        logL1 <- logLikelihood(data,out.cand,model.comparison) # Calculate log likelihood
        
        # Calculating the logarithm of the Metropolis ratio
        logalpha <- (logPrior1+logL1) - (logPrior0+logL0) 
        
        # Accepting or rejecting the candidate vector
        if ( log(runif(1, min = 0, max =1)) < logalpha && candidatepValues$af[1] + candidatepValues$as[1] <= 1
             && candidatepValues$as[1] >= 0 && candidatepValues$af[1] >= 0) {
            pValues <- candidatepValues
            logPrior0 <- logPrior1
            logL0 <- logL1
        }
    }
    
    pChain[c,] <- c(pValues$Y,pValues$af,pValues$as,pValues$sf,logL0)
    
}


# Discard the first 500 iterations for Burn-IN in MCMC
pChain <- pChain[(bunr_in+1):nrow(pChain),]
pChain = as.data.frame(pChain)

if (no.param.par.var[z]==1) {
    names(pChain) <- c("Y1","af1","as1","sf1","logli")
} else if (no.param.par.var[z]==2) {
    names(pChain) <- c("Y1","Y2","af1","af2","as1","as2","sf1","sf2","logli")
} else if (no.param.par.var[z]==3) {
    names(pChain) <- c("Y1","Y2","Y3","af1","af2","af3","as1","as2","as3","sf1","sf2","sf3","logli")
}



# Store the final parameter set values
param.set = colMeans(pChain[ , 1:(no.param*no.var)])
param.SD = apply(pChain[ , 1:(no.param*no.var)], 2, sd)
param.final = data.frame(matrix(ncol = (no.var)*2, nrow = no.param))

names(param.final) <- c("Y","af","as","sf","Y_SD","af_SD","as_SD","sf_SD")
param.final$Y = param.set[1:no.param]
param.final$af = param.set[(1+no.param):(2*no.param)]
param.final$as = param.set[(1+2*no.param):(3*no.param)]
param.final$sf = param.set[(1+3*no.param):(4*no.param)]

param.final$Y_SD = param.SD[1:no.param]
param.final$af_SD = param.SD[(1+no.param):(2*no.param)]
param.final$as_SD = param.SD[(1+2*no.param):(3*no.param)]
param.final$sf_SD = param.SD[(1+3*no.param):(4*no.param)]


# Calculate final output set from the predicted parameter set
for (j in 1:length(v)) {
    data.set = subset(data,(volume %in% vol[v[j]]))
    Mleaf = Mstem = Mroot = c()
    Mleaf[1] <- data.set$Mleaf[1]
    Mstem[1] <- data.set$Mstem[1]
    Mroot[1] <- data.set$Mroot[1]
    
    
    output.final.set = model.without.storage(data.set$GPP,data.set$Rd,no.param,Mleaf,Mstem,Mroot,param.final$Y,
                                             param.final$af,param.final$as,param.final$sf)
    
    
    output.final.set$volume = as.factor(vol[v[j]])
    if (j == 1) {
        output.final = output.final.set
    }
    if (j > 1) {
        output.final = rbind(output.final,output.final.set)
    }
}


































