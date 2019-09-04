

run_model <- function() {
    result.without.storage = CBM.grouping(chainLength=3000, no.param.par.var=c(1,2,3),
                                          vol.group=list(c(1,2,3),c(4,5,6),7), with.storage=F, 
                                          model.comparison=T, model.optimization=F)
    
    bic.without.storage = result.without.storage[[6]]
}

CBM.grouping <- function(chainLength, no.param.par.var, vol.group, with.storage, model.comparison, model.optimization) {
    
    source("R/load_packages_CBM.R")
    
    # Assign inputs for MCMC
    bunr_in = chainLength * 0.1 # Discard the first 10% iterations for Burn-IN in MCMC (According to Oijen, 2008)
  
    no.var = 4 # variables to be modelled are: k,Y,af,as
    
    
    param.mean = data.frame(matrix(ncol = no.var+1, nrow = 10))
    names(param.mean) = c("Y","af","as","ar","sf")
    
    aic.bic = data.frame(matrix(ncol = 7, nrow = 10))
    names(aic.bic) <- c("logLi","aic","bic","time","volume.group","no.param","volume")
    
    
    q = 0 # Indicates the iteration number
    set.seed(15) # final seed for reproducible results
    

    # Start the iteration for different treatment group and number of parameters
    v = unlist(vol.group[v1])
    
    # This script take the subset of processed data for particular treatment group
    source("R/data_processing_CBM.R", local=TRUE)
    
    
    param.Y <- matrix(c(0.2,0.3,0.4) , nrow=1, ncol=3, byrow=T)
    param.af <- matrix(c(0,0.5,1) , nrow=1, ncol=3, byrow=T) # Forcing af not to be negetive
    param.as <- matrix(c(0,0.5,1) , nrow=1, ncol=3, byrow=T)
    param.sf <- matrix(c(0,0.005,0.01) , nrow=1, ncol=3, byrow=T) # All Groups having same sf
    
    param = data.frame(param.Y,param.af,param.as,param.sf)
    names(param) <- c("Y_min","Y","Y_max","af_min","af","af_max","as_min","as","as_max","sf_min","sf","sf_max")
    pMinima <- param[ ,c("Y_min","af_min","as_min","sf_min")]
    pMaxima <- param[ ,c("Y_max","af_max","as_max","sf_max")]
    pValues <- param[ ,c("Y","af","as","sf")] # Starting point of the chain
    
    # Defining the variance-covariance matrix for proposal generation
    vcov = (0.005*(pMaxima-pMinima))^2
    vcovProposal =  vcov # The higher the coefficient, the higher the deviations in parameter time series
    
    # Find the Prior probability density
    prior.dist = vector("list", no.var)
    for (i in 1:no.var) {
        prior.dist[i] = list(log(dnorm(pValues[ , i], (pMinima[ , i] + pMaxima[ , i])/2, (pMaxima[ , i] - pMinima[ , i])/3))) # Prior normal gaussian distribution
    }
    logPrior0 <- sum(unlist(prior.dist))
    
    
    for (z in 1:length(no.param.par.var)) {
        # Initialize few output data files
        q = q + 1

        
        
        # Calculating model outputs for the starting point of the chain
        for (j in 1:length(v)) {
            data.set = subset(data,(volume %in% vol[v[j]]))
            Mleaf = Mstem = Mroot = LA = c()
            Mleaf[1] <- data.set$Mleaf[1]
            Mstem[1] <- data.set$Mstem[1]
            Mroot[1] <- data.set$Mroot[1]
            

            output.set = model.without.storage(data.set$GPP,data.set$Rd,no.param,Mleaf,Mstem,Mroot,
                                               pValues$Y,pValues$af,pValues$as,pValues$sf)
            
            
            output.set$volume = as.factor(vol[v[j]])
            if (j == 1) {
                output = output.set
            }
            if (j > 1) {
                output = rbind(output,output.set)
            }
        }
        
        data = data[order(data$volume),]
        logL0 <- logLikelihood(data,output,model.comparison) # Calculate log likelihood of starting point of the chain
        

        pChain[1,] <- c(pValues$Y,pValues$af,pValues$as,pValues$sf,logL0) # Assign the first parameter set with log likelihood
        
        
        
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
        
        # #----------------------------------------------------------------------------------------------------------------
        # if (with.storage==T) {
        #   output.final$Sleaf = output.final$Sleaf / output.final$Mleaf * 100
        # }
        # #----------------------------------------------------------------------------------------------------------------
        
        # Calculate daily parameter values with SD
        Days <- seq(1,nrow(data.set), length.out=nrow(data.set))
        param.daily = param.final[1,]
        
        if (no.param == 1) {
            for (i in 2:length(Days)) {
                param.daily[i,] = param.final[1,]
            }
        }
        if (no.param == 2) {
            for (i in 2:length(Days)) {
                param.daily[i,1:no.var] = param.final[1,1:no.var] + param.final[2,1:no.var] * i
            }
            for (i in (no.var+1):(2*no.var)) {
                param.daily[,i] = ((param.final[1,i]^2 + param.final[2,i]^2)/2)^0.5
            }
        }
        if (no.param == 3) {
            for (i in 2:length(Days)) {
                param.daily[i,1:no.var] = param.final[1,1:no.var] + param.final[2,1:no.var] * i + param.final[3,1:no.var] * i^2
            }
            for (i in (no.var+1):(2*no.var)) {
                param.daily[,i] = ((param.final[1,i]^2 + param.final[2,i]^2 + param.final[3,i]^2)/3)^0.5
            }
        }
        param.daily$ar = 1 - param.daily$af - param.daily$as
        param.daily$ar_SD = with(param.daily, ((af_SD*af_SD + as_SD*as_SD)/2)^0.5)
        param.daily$Date = as.Date(data.set$Date)
    }    
        


    
}

#----------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------


#----------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------


#-- Function to run Carbon Balance Model (CBM). 
#-----------------------------------------------------------------------------------------
# This script define the model equations to carry out Bayesian calibration for 
# 5 variables (allocation fractions: "k","Y",af","as","sf") on 
# various temporal scales to estimate Carbon pools (Cstorage,Cleaf,Cstem,Croot)
#-----------------------------------------------------------------------------------------
# Defining the model to iteratively calculate Cstorage, Cleaf, Cstem, Croot, Sleaf, Sstem, Sroot
model <- function (GPP,Rd,no.param,Mleaf,Mstem,Mroot,tnc,
                   Y,k,af,as,sf) {
    Cstorage = Sleaf = Sstem = Sroot = c()
    
    # From Duan's experiment for TNC partitioning to tree organs
    # Leaf TNC C / Leaf C =  0.1167851; Stem TNC C / Stem C =  0.03782242; Root TNC C / Root C =  0.01795031
    Sleaf[1] = Mleaf[1] * tnc$leaf.tnc.C[7]/100
    Sstem[1] = Mstem[1] * tnc$stem.tnc.C[7]/100
    Sroot[1] = Mroot[1] * tnc$root.tnc.C[7]/100
    Cstorage[1] <- Sleaf[1] + Sstem[1] + Sroot[1] 
    
    Cleaf <- Croot <- Cstem <- c()
    Cleaf[1] <- Mleaf[1] - Sleaf[1]
    Cstem[1] <- Mstem[1] - Sstem[1]
    Croot[1] <- Mroot[1] - Sroot[1]
    
    if (no.param == 1) {
        k.i = k[1]; Y.i = Y[1]; af.i = af[1]; as.i = as[1]; sf.i = sf[1]
    }
    for (i in 2:length(GPP)) {
        if (no.param == 2) {
            k.i = k[1] + k[2]*i; Y.i = Y[1]+ Y[2]*i; af.i = af[1]+ af[2]*i; as.i = as[1]+ as[2]*i; sf.i = sf[1]+ sf[2]*i
        }
        if (no.param == 3) {
            k.i = k[1] + k[2]*i + k[3]*i*i; Y.i = Y[1]+ Y[2]*i + Y[3]*i*i; af.i = af[1]+ af[2]*i + af[3]*i*i; 
            as.i = as[1]+ as[2]*i + as[3]*i*i; 
            sf.i = sf[1]+ sf[2]*i + sf[3]*i*i
        }
        Cstorage[i] <- Cstorage[i-1] + GPP[i-1] - Rd[i-1]*(Mleaf[i-1] + Mroot[i-1] + Mstem[i-1]) - k.i*Cstorage[i-1]
        Sleaf[i] <- Cstorage[i] * tnc$leaf_to_all[7]/100 # 75% of storage goes to leaf (Duan's experiment)
        Sstem[i] <- Cstorage[i] * tnc$stem_to_all[7]/100 # 16% of storage goes to stem (Duan's experiment)
        Sroot[i] <- Cstorage[i] * tnc$root_to_all[7]/100 # 9% of storage goes to root (Duan's experiment)
        
        Cleaf[i] <- Cleaf[i-1] + k.i*Cstorage[i-1]*af.i*(1-Y.i) - sf.i*Mleaf[i-1]
        Cstem[i] <- Cstem[i-1] + k.i*Cstorage[i-1]*as.i*(1-Y.i)
        Croot[i] <- Croot[i-1] + k.i*Cstorage[i-1]*(1-af.i-as.i)*(1-Y.i)
        
        Mleaf[i] <- Cleaf[i] + Sleaf[i]
        Mstem[i] <- Cstem[i] + Sstem[i]
        Mroot[i] <- Croot[i] + Sroot[i]
    }
    output = data.frame(Cstorage,Mleaf,Mstem,Mroot,Sleaf)
    
    return(output)
}
#----------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------