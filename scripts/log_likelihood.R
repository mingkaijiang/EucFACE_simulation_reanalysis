log_likelihood <- function(Rhet.mean,     ### mean observed heterotrophic respiration
                           Rhet.sd,       ### sd observed Rhet
                           Rhet.pred) {
    
    ### Initialising the logLi
    logLi <- matrix(0, nrow=nrow(Rhet.pred), ncol = 1) 
    
    ### compute loglikelihood
    for (i in 1:nrow(Rhet.pred)) {
        logLi[i] = - 0.5*((Rhet.pred[i] - Rhet.mean)/Rhet.sd)^2 - log(Rhet.sd) - log(2*pi)^0.5
    }
    
    return(sum(logLi))
    

    
}