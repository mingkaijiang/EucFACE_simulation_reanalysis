prefit_parameter_estimates <- function() {
    
    GPP=GPP.amb.mean
    Ra=Ra.amb.mean
    Pools=Pools.amb.mean
    delta=Delta.amb.mean
    
    fit <- optim(params, EucFACE_C_budget_model_prefit, method="BFGS",hessian=T)
    fit$par
    
    fitted <- Nelder_Mead(EucFACE_C_budget_model_prefit, 
                          fit$par, 
                          lower=params.lower, 
                          upper=params.upper)
    
    fitted$feval
    fitted$par
    
    
}