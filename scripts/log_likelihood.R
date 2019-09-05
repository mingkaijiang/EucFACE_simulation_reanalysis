log_likelihood <- function(obs, pred) {
    
    ### NPP
    logLi <- -0.5*((pred$NPP.leaf - obs$NPP.leaf.mean)/obs$NPP.leaf.sd)^2 - log(obs$NPP.leaf.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$NPP.wood - obs$NPP.wood.mean)/obs$NPP.wood.sd)^2 - log(obs$NPP.wood.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$NPP.froot - obs$NPP.froot.mean)/obs$NPP.froot.sd)^2 - log(obs$NPP.froot.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$NPP.myco - obs$NPP.myco.mean)/obs$NPP.myco.sd)^2 - log(obs$NPP.myco.sd) - log(2*pi)^0.5
    

    ### delta
    logLi <- logLi - 0.5*((pred$delta.Cleaf - obs$delta.Cleaf.mean)/obs$delta.Cleaf.sd)^2 - log(obs$delta.Cleaf.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cfroot - obs$delta.Cfroot.mean)/obs$delta.Cfroot.sd)^2 - log(obs$delta.Cfroot.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cmyco - obs$delta.Cmyco.mean)/obs$delta.Cmyco.sd)^2 - log(obs$delta.Cmyco.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cag - obs$delta.Cag.mean)/obs$delta.Cag.sd)^2 - log(obs$delta.Cag.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cbg - obs$delta.Cbg.mean)/obs$delta.Cbg.sd)^2 - log(obs$delta.Cbg.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cmicr - obs$delta.Cmicr.mean)/obs$delta.Cmicr.sd)^2 - log(obs$delta.Cmicr.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Csoil - obs$delta.Csoil.mean)/obs$delta.Csoil.sd)^2 - log(obs$delta.Csoil.sd) - log(2*pi)^0.5
    
    ### Rhet
    logLi <- logLi - 0.5*((pred$Rhet - obs$Rhet.mean)/obs$Rhet.sd)^2 - log(obs$Rhet.sd) - log(2*pi)^0.5

    return(logLi)
}


#logLikelihood <- function (data,output,model.comparison) {
#    logLi <- matrix(0, nrow=nrow(data), ncol = 1) # Initialising the logLi
#    for (i in 1:nrow(data)) {
#        if (!is.na(data$Mleaf[i])) {
#            logLi[i] = - 0.5*((output$Mleaf[i] - data$Mleaf[i])/data$Mleaf_SD[i])^2 - log(data$Mleaf_SD[i]) - log(2*pi)^0.5
#        }
#        if (!is.na(data$Mstem[i])) {
#            logLi[i] = logLi[i] - 0.5*((output$Mstem[i] - data$Mstem[i])/data$Mstem_SD[i])^2 - log(data$Mstem_SD[i]) - log(2*pi)^0.5
#        }
#        if (!is.na(data$Mroot[i])) {
#            logLi[i] = logLi[i] - 0.5*((output$Mroot[i] - data$Mroot[i])/data$Mroot_SD[i])^2 - log(data$Mroot_SD[i]) - log(2*pi)^0.5
#        }
#        
#    }
#    return(sum(logLi))
#}