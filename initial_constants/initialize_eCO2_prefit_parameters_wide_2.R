####################################### Define pools, parameters and fluxes

### parameter space

### R1
prefit.params.eCO2.R1 <- c(0.4,          # alloc leaf
                        0.2,          # alloc wood 
                        0.1,
                        1.1,          # tau leaf
                        0.8,          # tau froot
                        40.0)

prefit.params.eCO2.lower.R1 <- c(0.3,
                              0.1,
                              0.05,
                              1.0,          # tau leaf
                              0.5,          # tau froot
                              0.0)


prefit.params.eCO2.upper.R1 <- c(0.8,
                              0.35,
                              0.3,
                              1.5,          # tau leaf
                              2.0,          # tau froot
                              50.0)        



