####################################### Define pools, parameters and fluxes

### parameter space

### Ring 2
params.aCO2.R2 <- c(init.parameters$alloc.leaf[init.parameters$Ring=="2"],
                    init.parameters$alloc.wood[init.parameters$Ring=="2"],
                    init.parameters$alloc.froot[init.parameters$Ring=="2"],
                    init.parameters$alloc.myco[init.parameters$Ring=="2"],
                    1.1,          # tau leaf
                    0.8,          # tau froot
                    40.0,         # tau myco
                    1.5,          # tau.bg.lit
                    5.5,          # tau.micr
                    0.18,         # tau.soil
                    91.0,         # C.ag.lit
                    10.0,         # C.bg.lit
                    0.3,          # frac.myco
                    0.3,          # frac.ag
                    0.3,          # frac.bg
                    0.3)          # frac.micr

params.aCO2.lower.R2 <- c(init.parameters$neg.leaf[init.parameters$Ring=="2"],
                          init.parameters$neg.wood[init.parameters$Ring=="2"],
                          init.parameters$neg.froot[init.parameters$Ring=="2"],
                          init.parameters$neg.myco[init.parameters$Ring=="2"],
                          1.0,          # tau leaf
                          0.5,          # tau froot
                          4.0,          # tau myco
                          1.0,          # tau.bg.lit
                          2.0,          # tau.micr.lit
                          0.01,         # tau.soil.lit
                          10.0,         # C.ag.lit
                          0.0,         # C.bg.lit
                          0.3,          # frac.myco
                          0.3,          # frac.ag
                          0.3,          # frac.bg
                          0.3)          # frac.micr


params.aCO2.upper.R2 <- c(init.parameters$pos.leaf[init.parameters$Ring=="2"],
                          init.parameters$pos.wood[init.parameters$Ring=="2"],
                          init.parameters$pos.froot[init.parameters$Ring=="2"],
                          init.parameters$pos.myco[init.parameters$Ring=="2"],
                          1.5,          # tau leaf
                          2.0,          # tau froot
                          50.0,         # tau myco
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
params.aCO2.R3 <- c(init.parameters$alloc.leaf[init.parameters$Ring=="3"],
                    init.parameters$alloc.wood[init.parameters$Ring=="3"],
                    init.parameters$alloc.froot[init.parameters$Ring=="3"],
                    init.parameters$alloc.myco[init.parameters$Ring=="3"],
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

params.aCO2.lower.R3 <- c(init.parameters$neg.leaf[init.parameters$Ring=="3"],
                          init.parameters$neg.wood[init.parameters$Ring=="3"],
                          init.parameters$neg.froot[init.parameters$Ring=="3"],
                          init.parameters$neg.myco[init.parameters$Ring=="3"],
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


params.aCO2.upper.R3 <- c(init.parameters$pos.leaf[init.parameters$Ring=="3"],
                          init.parameters$pos.wood[init.parameters$Ring=="3"],
                          init.parameters$pos.froot[init.parameters$Ring=="3"],
                          init.parameters$pos.myco[init.parameters$Ring=="3"],
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
params.aCO2.R6 <- c(init.parameters$alloc.leaf[init.parameters$Ring=="6"],
                    init.parameters$alloc.wood[init.parameters$Ring=="6"],
                    init.parameters$alloc.froot[init.parameters$Ring=="6"],
                    init.parameters$alloc.myco[init.parameters$Ring=="6"],
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

params.aCO2.lower.R6 <- c(init.parameters$neg.leaf[init.parameters$Ring=="6"],
                          init.parameters$neg.wood[init.parameters$Ring=="6"],
                          init.parameters$neg.froot[init.parameters$Ring=="6"],
                          init.parameters$neg.myco[init.parameters$Ring=="6"],
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


params.aCO2.upper.R6 <- c(init.parameters$pos.leaf[init.parameters$Ring=="6"],
                          init.parameters$pos.wood[init.parameters$Ring=="6"],
                          init.parameters$pos.froot[init.parameters$Ring=="6"],
                          init.parameters$pos.myco[init.parameters$Ring=="6"],
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


