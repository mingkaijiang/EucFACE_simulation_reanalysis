####################################### Define pools, parameters and fluxes

### parameter space

params.aCO2 <- c(0.3,          # alloc leaf
                 0.2,          # alloc wood 
                 0.1,          # alloc froot
                 1.0,          # tau leaf
                 1.5,          # tau froot
                 12.0,         # tau myco
                 1.5,          # tau.bg.lit
                 5.5,          # tau.micr
                 0.14,        # tau.soil
                 91.0,         # C.ag.lit
                 78.6,         # C.bg.lit
                 0.6,          # frac.myco
                 0.6,          # frac.ag
                 0.6,          # frac.bg
                 0.6)          # frac.micr

params.aCO2.lower <- c(0.1,
                       0.1,
                       0.05,
                       0.5,          # tau leaf
                       1.0,          # tau froot
                       4.0,          # tau myco
                       1.0,          # tau.bg.lit
                       2.0,          # tau.micr.lit
                       0.01,         # tau.soil.lit
                       10.0,         # C.ag.lit
                       10.0,         # C.bg.lit
                       0.3,          # frac.myco
                       0.3,          # frac.ag
                       0.3,          # frac.bg
                       0.3)          # frac.micr


params.aCO2.upper <- c(0.6,
                       0.2,
                       0.3,
                       1.5,          # tau leaf
                       2.0,          # tau froot
                       40.0,         # tau myco
                       8.0,          # tau.bg.lit
                       50.0,         # tau.micr.lit
                       0.20,         # tau.soil.lit
                       150.0,        # C.ag.lit
                       100,          # C.bg.lit
                       0.8,          # frac.myco
                       0.8,          # frac.ag
                       0.8,          # frac.bg
                       0.8)          # frac.micr
                           

### set number of parameter variables
no.var <- length(params.aCO2)


