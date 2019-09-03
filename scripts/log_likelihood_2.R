log_likelihood_2 <- function(Rhet.mean,     ### mean observed heterotrophic respiration
                           Rhet.sd,       ### sd observed Rhet
                           Rhet.pred) {
    

    ### why this equation? log likelihood never equals zero!
    logLi = - 0.5*((Rhet.pred - Rhet.mean)/Rhet.sd)^2 - log(Rhet.sd) - log(2*pi)^0.5
    
    #browser()
    
    return(logLi)
}