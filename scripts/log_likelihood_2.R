log_likelihood_2 <- function(obs, pred) {
    
    logLi <- -0.5*((pred$tot.C - obs$totC.amb.mean)/obs$totC.amb.sd)^2 - log(obs$totC.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$tot.tau - obs$tau.amb.mean)/obs$tau.amb.sd)^2 - log(obs$tau.amb.sd) - log(2*pi)^0.5
    logLi <- logLi - 0.5*((pred$Rhet - obs$Rhet.amb.mean)/obs$Rhet.amb.sd)^2 - log(obs$Rhet.amb.sd) - log(2*pi)^0.5
    
    return(logLi)
}


