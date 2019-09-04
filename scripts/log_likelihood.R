log_likelihood <- function(obs, pred) {
    

    ### delta
    logLi <- -0.5*((pred$delta.Cleaf - obs$delta.Cleaf.amb.mean)/obs$delta.Cleaf.amb.sd)^2 - log(obs$delta.Cleaf.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cfroot - obs$delta.Cfroot.amb.mean)/obs$delta.Cfroot.amb.sd)^2 - log(obs$delta.Cfroot.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cmyco - obs$delta.Cmyco.amb.mean)/obs$delta.Cmyco.amb.sd)^2 - log(obs$delta.Cmyco.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cag - obs$delta.Cag.amb.mean)/obs$delta.Cag.amb.sd)^2 - log(obs$delta.Cag.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cbg - obs$delta.Cbg.amb.mean)/obs$delta.Cbg.amb.sd)^2 - log(obs$delta.Cbg.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Cmicr - obs$delta.Cmicr.amb.mean)/obs$delta.Cmicr.amb.sd)^2 - log(obs$delta.Cmicr.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$delta.Csoil - obs$delta.Csoil.amb.mean)/obs$delta.Csoil.amb.sd)^2 - log(obs$delta.Csoil.amb.sd) - log(2*pi)^0.5
    
    ### Rhet
    logLi <- logLi - 0.5*((pred$Rhet - obs$Rhet.amb.mean)/obs$Rhet.amb.sd)^2 - log(obs$Rhet.amb.sd) - log(2*pi)^0.5

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