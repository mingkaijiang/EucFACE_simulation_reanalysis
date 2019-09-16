####################################### Define pools, parameters and fluxes

### parameter space

params.aCO2 <- c(0.55,          # alloc leaf
                 0.13,          # alloc froot 
                 0.14,          # alloc myco
                 1.0,          # tau leaf
                 1.5,          # tau froot
                 12.0,         # tau myco
                 3.5,          # tau ag.lit    
                 1.5,          # tau.bg.lit
                 5.5,          # tau.micr
                 0.145,         # tau.soil
                 78.6,         # C.bg.lit
                 0.6,          # frac.myco
                 0.6,          # frac.ag
                 0.6,          # frac.bg
                 0.7)          # frac.micr


params.aCO2.lower <- c(0.5,
                       0.1,
                       0.1,
                       0.5,          # tau leaf
                       1.0,          # tau froot
                       4.0,          # tau myco
                       3.0,          # tau ag.lit    
                       1.0,          # tau.bg.lit
                       2.0,          # tau.micr.lit
                       0.01,         # tau.soil.lit
                       10,           # C.bg.lit
                       0.4,          # frac.myco
                       0.4,          # frac.ag
                       0.4,          # frac.bg
                       0.4)          # frac.micr


params.aCO2.upper <- c(0.6,
                       0.16,
                       0.16,
                       1.5,          # tau leaf
                       2.0,          # tau froot
                       20.0,         # tau myco
                       4.0,          # tau ag.lit   
                       2.0,          # tau.bg.lit
                       10.0,         # tau.micr.lit
                       0.2,          # tau.soil.lit
                       120,          # C.bg.lit
                       0.8,          # frac.myco
                       0.8,          # frac.ag
                       0.8,          # frac.bg
                       0.8)          # frac.micr
                           

### set number of parameter variables
no.var <- length(params.aCO2)


