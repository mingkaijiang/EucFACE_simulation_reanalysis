log_likelihood_3 <- function(Rhet.mean,     ### mean observed heterotrophic respiration
                           Rhet.sd,       ### sd observed Rhet
                           Rhet.pred) {
    

    ### why this equation? log likelihood never equals zero!
    #logLi = -0.5*((Rhet.pred - Rhet.mean)/Rhet.sd)^2 - log(Rhet.sd) - log(2*pi)^0.5
    logLi = -0.5*((Rhet.pred-Rhet.mean)/Rhet.sd)^2 -log(Rhet.sd)
    
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