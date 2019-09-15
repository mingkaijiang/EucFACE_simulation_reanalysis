####################################### Define pools, parameters and fluxes

### parameter space

### Ring 2
params.aCO2.R2 <- c(0.5,          # alloc leaf
                    0.2,          # alloc wood 
                    0.1,          # alloc froot
                    1.1,          # tau leaf
                    0.8,          # tau froot
                    25.0,         # tau myco
                    1.5,          # tau.bg.lit
                    5.5,          # tau.micr
                    0.18,         # tau.soil
                    91.0,         # C.ag.lit
                    10.0,         # C.bg.lit
                    0.8,          # frac.myco
                    0.6,          # frac.ag
                    0.6,          # frac.bg
                    0.8)          # frac.micr

params.aCO2.lower.R2 <- c(0.3,
                          0.1,
                          0.05,
                          1.0,          # tau leaf
                          0.5,          # tau froot
                          4.0,          # tau myco
                          1.0,          # tau.bg.lit
                          2.0,          # tau.micr.lit
                          0.01,         # tau.soil.lit
                          10.0,         # C.ag.lit
                          0.0,         # C.bg.lit
                          0.5,          # frac.myco
                          0.3,          # frac.ag
                          0.3,          # frac.bg
                          0.5)          # frac.micr


params.aCO2.upper.R2 <- c(0.6,
                          0.35,
                          0.3,
                          1.5,          # tau leaf
                          2.0,          # tau froot
                          40.0,         # tau myco
                          8.0,          # tau.bg.lit
                          40.0,         # tau.micr.lit
                          0.20,         # tau.soil.lit
                          150.0,        # C.ag.lit
                          20.0,          # C.bg.lit
                          0.9,          # frac.myco
                          0.8,          # frac.ag
                          0.8,          # frac.bg
                          0.9)          # frac.micr



### Ring 3
params.aCO2.R3 <- c(0.6,          # alloc leaf
                    0.25,          # alloc wood 
                    0.15,          # alloc froot
                    1.1,          # tau leaf
                    1.5,          # tau froot
                    0.0,          # tau myco
                    1.5,          # tau.bg.lit
                    10.0,         # tau.micr
                    0.1,          # tau.soil
                    91.0,         # C.ag.lit
                    100.0,         # C.bg.lit
                    0.8,          # frac.myco
                    0.7,          # frac.ag
                    0.7,          # frac.bg
                    0.8)          # frac.micr

params.aCO2.lower.R3 <- c(0.3,
                          0.1,
                          0.05,
                          1.0,          # tau leaf
                          0.5,          # tau froot
                          0.0,          # tau myco
                          1.0,          # tau.bg.lit
                          2.0,          # tau.micr.lit
                          0.01,         # tau.soil.lit
                          10.0,         # C.ag.lit
                          0.0,         # C.bg.lit
                          0.5,          # frac.myco
                          0.3,          # frac.ag
                          0.3,          # frac.bg
                          0.5)          # frac.micr


params.aCO2.upper.R3 <- c(0.6,
                          0.35,
                          0.3,
                          1.5,          # tau leaf
                          2.0,          # tau froot
                          0.1,         # tau myco
                          8.0,          # tau.bg.lit
                          40.0,         # tau.micr.lit
                          0.20,         # tau.soil.lit
                          150.0,        # C.ag.lit
                          150.0,          # C.bg.lit
                          0.9,          # frac.myco
                          0.8,          # frac.ag
                          0.8,          # frac.bg
                          0.9)          # frac.micr


### Ring 6
params.aCO2.R6 <- c(0.55,          # alloc leaf
                    0.2,          # alloc wood 
                    0.15,          # alloc froot
                    1.1,          # tau leaf
                    1.4,          # tau froot
                    0.0,         # tau myco
                    1.5,          # tau.bg.lit
                    5.5,          # tau.micr
                    0.1,         # tau.soil
                    91.0,         # C.ag.lit
                    100.0,         # C.bg.lit
                    0.3,          # frac.myco
                    0.3,          # frac.ag
                    0.3,          # frac.bg
                    0.3)          # frac.micr

params.aCO2.lower.R6 <- c(0.3,
                          0.1,
                          0.05,
                          1.0,          # tau leaf
                          0.5,          # tau froot
                          0.0,          # tau myco
                          1.0,          # tau.bg.lit
                          2.0,          # tau.micr.lit
                          0.01,         # tau.soil.lit
                          10.0,         # C.ag.lit
                          0.0,         # C.bg.lit
                          0.3,          # frac.myco
                          0.3,          # frac.ag
                          0.3,          # frac.bg
                          0.3)          # frac.micr


params.aCO2.upper.R6 <- c(0.6,
                          0.35,
                          0.3,
                          1.5,          # tau leaf
                          2.0,          # tau froot
                          0.01,         # tau myco
                          8.0,          # tau.bg.lit
                          40.0,         # tau.micr.lit
                          0.2,         # tau.soil.lit
                          350.0,        # C.ag.lit
                          150.0,          # C.bg.lit
                          0.9,          # frac.myco
                          0.8,          # frac.ag
                          0.8,          # frac.bg
                          0.9)          # frac.micr

### set number of parameter variables
no.var <- length(params.aCO2.R2)


params.aCO2 <- c(0.3,          # alloc leaf
                    0.2,          # alloc wood 
                    0.1,          # alloc froot
                    1.1,          # tau leaf
                    0.8,          # tau froot
                    12.0,         # tau myco
                    1.5,          # tau.bg.lit
                    5.5,          # tau.micr
                    0.14,         # tau.soil
                    91.0,         # C.ag.lit
                    10.0,         # C.bg.lit
                    0.8,          # frac.myco
                    0.6,          # frac.ag
                    0.6,          # frac.bg
                    0.8)          # frac.micr

params.aCO2.lower <- c(0.3,
                          0.1,
                          0.05,
                          1.0,          # tau leaf
                          0.5,          # tau froot
                          4.0,          # tau myco
                          1.0,          # tau.bg.lit
                          2.0,          # tau.micr.lit
                          0.01,         # tau.soil.lit
                          10.0,         # C.ag.lit
                          0.0,         # C.bg.lit
                          0.5,          # frac.myco
                          0.3,          # frac.ag
                          0.3,          # frac.bg
                          0.5)          # frac.micr


params.aCO2.upper <- c(0.6,
                          0.35,
                          0.3,
                          1.5,          # tau leaf
                          2.0,          # tau froot
                          40.0,         # tau myco
                          8.0,          # tau.bg.lit
                          40.0,         # tau.micr.lit
                          0.20,         # tau.soil.lit
                          150.0,        # C.ag.lit
                          20.0,          # C.bg.lit
                          0.9,          # frac.myco
                          0.8,          # frac.ag
                          0.8,          # frac.bg
                          0.9)          # frac.micr