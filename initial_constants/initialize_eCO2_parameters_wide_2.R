####################################### Define pools, parameters and fluxes

### parameter space

params.eCO2 <- c(0.3,          # alloc leaf
                 0.2,          # alloc wood 
                 0.1,          # alloc froot
                 1.0,          # tau leaf
                 1.5,          # tau froot
                 10.0, #12.0,         # tau myco
                 1.5,          # tau.bg.lit
                 5.5,          # tau.micr
                 0.145,        # tau.soil
                 91.0,         # C.ag.lit
                 78.6,         # C.bg.lit
                 0.3,          # frac.myco
                 0.3,          # frac.ag
                 0.3,          # frac.bg
                 0.3)          # frac.micr

params.eCO2.lower <- c(0.1,
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
                       0.1,          # frac.myco
                       0.1,          # frac.ag
                       0.1,          # frac.bg
                       0.1)          # frac.micr


params.eCO2.upper <- c(0.6,
                       0.2,
                       0.2,
                       1.5,          # tau leaf
                       2.0,          # tau froot
                       50.0,         # tau myco
                       8.0,          # tau.bg.lit
                       40,#50.0,         # tau.micr.lit
                       0.25,         # tau.soil.lit
                       150.0,        # C.ag.lit
                       100,          # C.bg.lit
                       0.9,          # frac.myco
                       0.9,          # frac.ag
                       0.9,          # frac.bg
                       0.9)          # frac.micr
                           

### set number of parameter variables
no.var <- length(params.eCO2)


