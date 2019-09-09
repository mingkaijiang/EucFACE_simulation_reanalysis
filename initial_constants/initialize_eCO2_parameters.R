####################################### Define pools, parameters and fluxes

### parameter space

params.eCO2 <- c(0.46,          # alloc leaf
                 0.10,          # alloc froot 
                 0.30,          # alloc myco
                 1.2,          # tau leaf
                 1.4,          # tau froot
                 42.5,         # tau myco
                 5.6,          # tau ag.lit    
                 1.5,          # tau.bg.lit
                 7.5,          # tau.micr
                 0.18,         # tau.soil
                 79.3,         # C.bg.lit
                 0.6,          # frac.myco
                 0.6,          # frac.ag
                 0.7,          # frac.bg
                 0.8)          # frac.micr


params.eCO2.lower <- c(0.4,
                       0.05,
                       0.25,
                       0.8,          # tau leaf
                       1.0,          # tau froot
                       30.0,          # tau myco
                       4.0,          # tau ag.lit    
                       1.0,          # tau.bg.lit
                       4.0,          # tau.micr.lit
                       0.01,         # tau.soil.lit
                       10,           # C.bg.lit
                       0.4,          # frac.myco
                       0.4,          # frac.ag
                       0.4,          # frac.bg
                       0.4)          # frac.micr


params.eCO2.upper <- c(0.6,
                       0.15,
                       0.4,
                       1.5,          # tau leaf
                       2.0,          # tau froot
                       50.0,         # tau myco
                       8.0,          # tau ag.lit   
                       2.0,          # tau.bg.lit
                       10.0,         # tau.micr.lit
                       0.2,          # tau.soil.lit
                       120,          # C.bg.lit
                       0.8,          # frac.myco
                       0.8,          # frac.ag
                       0.8,          # frac.bg
                       0.8)          # frac.micr
                           

### set number of parameter variables
no.var <- length(params.eCO2)


