plot_parameter_trace_within_parameter_space <- function(params,
                                                        params.upper,
                                                        params.lower,
                                                        inDF,
                                                        dist.type,
                                                        step.size,
                                                        chainLength) {
    
    ### assign y value
    inDF$y <- 1
    
    ### define names
    names <- c("alloc.leaf", "alloc.froot", "alloc.myco",
               "tau.leaf", "tau.froot", "tau.myco",
               "tau.ag.lit", "tau.bg.lit", "tau.micr", "tau.soil", 
               "C.bg.lit", "frac.myco", "frac.ag.lit", "frac.bg.lit", "frac.micr")
    
    ### plotting
    pdf(paste0("output/parameter_trace_", dist.type, "_", 
               step.size, "_", chainLength,
               ".pdf"))
    
    for (i in 1:no.var) {
        plot(inDF[,i], inDF$y, xlim = c(params.lower[i], params.upper[i]),
             ylim = c(0.9,1.1), xlab = names[i], ylab = " ")
    }
    
    
    dev.off()
    
    
}