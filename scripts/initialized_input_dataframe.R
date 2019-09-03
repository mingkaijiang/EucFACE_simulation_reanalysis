initialize_input_dataframe <- function(n) {
    
    ### set GPP
    ncol <- ncol(GPP.amb.mean)
    GPP <- matrix(ncol=ncol, nrow=n)
    for (i in 1:ncol) {
        GPP[,i] <- rnorm(n = n, mean=GPP.amb.mean[,i], sd=GPP.amb.sd[,i])
    }
    
    ### set NPP
    ncol <- ncol(NPP.amb.mean)
    NPP <- matrix(ncol=ncol, nrow=n)
    for (i in 1:ncol) {
        NPP[,i] <- rnorm(n = n, mean=NPP.amb.mean[,i], sd=NPP.amb.sd[,i])
    }

    ### set Pools
    ncol <- ncol(Pools.amb.mean)
    Pools <- matrix(ncol=ncol, nrow=n)
    for (i in 1:ncol) {
        Pools[,i] <- rnorm(n = n, mean=Pools.amb.mean[,i], sd=Pools.amb.sd[,i])
    }
    
    ### set delta
    ncol <- ncol(Delta.amb.mean)
    delta <- matrix(ncol=ncol, nrow=n)
    for (i in 1:ncol) {
        delta[,i] <- rnorm(n = n, mean=Delta.amb.mean[,i], sd=Delta.amb.sd[,i])
    }
    
    out <- list(GPP, NPP, Pools, delta)
    
    return(out)
}