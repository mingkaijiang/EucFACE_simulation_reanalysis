plot_posterior <- function(inDF, Trt) {
    
    ### colmeans
    mDF <- colMeans(inDF)
    
    ### column length
    col <- ncol(inDF)
    #apply(pChain, 2, sd)
    
    names <- c("alloc.leaf", "alloc.froot", "alloc.myco",
               "tau.leaf", "tau.froot", "tau.myco",
               "tau.ag.lit", "tau.bg.lit", "tau.micr", "tau.soil", 
               "C.bg.lit",
               "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr",
               "logli", "GPP", "NPP", "CUE",
               "NPP.leaf", "NPP.wood", "NPP.froot", "NPP.myco",
               "delta.Cleaf", "delta.Cfroot", "delta.Cmyco", 
               "delta.Cag", "delta.Cbg",
               "delta.Cmicr", "delta.Csoil", "Rhet", 
               "Prior","aic", "bic")
    
    pdf(paste0("output/posterior_distributions_", Trt, ".pdf"))
    for (i in 1:col) {
        hist(inDF[,i], main = names[i],
             prob=TRUE,col="black",border="white")
        lines(density(inDF[,i],na.rm=T),col="red",lwd=4)
        abline(v=mDF[i], lwd = 6, col="blue")
        
    }
    
    dev.off()
    
}