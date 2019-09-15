####################################### Define pools, parameters and fluxes

### prefit.parameter space

### 
prefit.params.aCO2 <- c(0.5,          # alloc leaf
                        0.2,          # alloc wood 
                        0.1)          # alloc froot
        

prefit.params.aCO2.lower <- c(0.3,
                              0.1,
                              0.05)


prefit.params.aCO2.upper <- c(0.6,
                              0.35,
                              0.3)


### set number of parameter variables
no.var <- length(prefit.params.aCO2)


