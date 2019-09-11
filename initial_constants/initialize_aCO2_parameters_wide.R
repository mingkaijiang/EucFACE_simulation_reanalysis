####################################### Define pools, parameters and fluxes

### parameter space

#params.aCO2 <- c(0.4,          # alloc leaf
#                 0.15,          # alloc froot 
#                 0.15,          # alloc myco
#                 1.0,          # tau leaf
#                 1.5,          # tau froot
#                 12.0,         # tau myco
#                 3.5,          # tau ag.lit    
#                 1.5,          # tau.bg.lit
#                 5.5,          # tau.micr
#                 0.145,         # tau.soil
#                 78.6,         # C.bg.lit
#                 0.6,          # frac.myco
#                 0.6,          # frac.ag
#                 0.6,          # frac.bg
#                 0.7)          # frac.micr


params.aCO2 <- c(0.46,          # alloc leaf
                 0.10,          # alloc froot 
                 0.27,          # alloc myco
                 1.2,          # tau leaf
                 1.4,          # tau froot
                 42.5,         # tau myco
                 5.6,          # tau ag.lit    
                 1.5,          # tau.bg.lit
                 7.5,          # tau.micr
                 0.17,         # tau.soil
                 79.3,         # C.bg.lit
                 0.6,          # frac.myco
                 0.6,          # frac.ag
                 0.7,          # frac.bg
                 0.8)          # frac.micr


params.aCO2.lower <- c(0.1,
                       0.05,
                       0.1,
                       0.5,          # tau leaf
                       1.0,          # tau froot
                       4.0,          # tau myco
                       1.0,          # tau ag.lit    
                       1.0,          # tau.bg.lit
                       2.0,          # tau.micr.lit
                       0.01,         # tau.soil.lit
                       10,           # C.bg.lit
                       0.1,          # frac.myco
                       0.1,          # frac.ag
                       0.1,          # frac.bg
                       0.1)          # frac.micr


params.aCO2.upper <- c(0.6,
                       0.2,
                       0.4,
                       1.5,          # tau leaf
                       2.0,          # tau froot
                       50.0,         # tau myco
                       8.0,          # tau ag.lit   
                       8.0,          # tau.bg.lit
                       50.0,         # tau.micr.lit
                       0.25,          # tau.soil.lit
                       120,          # C.bg.lit
                       0.9,          # frac.myco
                       0.9,          # frac.ag
                       0.9,          # frac.bg
                       0.9)          # frac.micr
                           

### set number of parameter variables
no.var <- length(params.aCO2)


