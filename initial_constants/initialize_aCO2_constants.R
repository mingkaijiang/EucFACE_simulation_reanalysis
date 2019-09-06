####################################### Define pools, parameters and fluxes

### parameter space
params <- c(0.55,          # alloc leaf
            0.13,          # alloc froot 
            0.13,          # alloc myco
            1.0,          # tau leaf
            1.5,          # tau froot
            12.0,         # tau myco
            3.5,          # tau ag.lit    
            1.5,          # tau.bg.lit
            5.5,          # tau.micr
            0.13,         # tau.soil
            78.6,         # C.bg.lit
            0.6,          # frac.myco
            0.6,          # frac.ag
            0.6,          # frac.bg
            0.6           # frac.micr
)

params.lower <- c(0.5,
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


params.upper <- c(0.6,
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
no.var <- length(params)

### Pools
Pools.amb.mean <- data.frame(151 + 156 + 0.17,     # C.leaf
                             4966 + 777,           # C.wood
                             78.6,                 # C.froot
                             7.4,                  # C.myco
                             91,                   # C.ag.lit
                             64,                   # C.micr
                             2183)                 # C.soil

Pools.amb.sd <- data.frame(14 + 20 + 0.03,     # C.leaf
                           344 + 62,           # C.wood
                           6.3,                # C.froot
                           1.6,                # C.myco
                           20.0,               # C.ag.lit
                           5.3,                # C.micr
                           280.0)              # C.soil



### Change in pools
Delta.amb.mean <- data.frame(16.72 + 4.32 + 0.18,     # C.leaf
                           44.75 + 5.34,              # C.wood
                           -32.21,                    # C.froot
                           -1.57,                     # C.myco
                           13.8,                      # C.ag.lit
                           -13.5,                     # C.micr
                           -58.61)                    # C.soil

Delta.amb.sd <- data.frame(9.5 + 21.8 + 0.07,     # C.leaf
                           30.5 + 4.1,              # C.wood
                           13.6,                    # C.froot
                           0.7,                     # C.myco
                           3.2,                      # C.ag.lit
                           4.8,                     # C.micr
                           72.6)                    # C.soil

### GPP
GPP.amb.mean <- 1563+497
GPP.amb.sd <- 200+28

### Rhetero
Rhet.amb.mean <- 631
Rhet.amb.sd <- 134

Ra.amb.mean <- 1386.6
Ra.amb.sd <- 165.8

#Ra.ele.mean <- 1442.4
#Ra.ele.sd <- 151.3

### NPP
NPP.amb.mean <- data.frame(192 + 25.5 + 146,     # leaf
                           107 + 43.4 + 5.2,     # wood
                           89.6)                 # froot

NPP.amb.sd <- data.frame(0.2 + 4.3 + 22,         # leaf
                         6.0 + 14.3 + 2.1,       # wood
                         50.2)                   # froot

colnames(NPP.amb.mean) <- colnames(NPP.amb.sd) <- c("NPP.leaf", "NPP.wood", "NPP.froot")

