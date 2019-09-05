####################################### Define pools, parameters and fluxes
### set number of parameter variables
no.var <- 10

### EucFACE aCO2
params <- c(0.6,          # alloc leaf
            0.1,          # alloc froot 
            0.1,          # alloc myco
            10.0,         # tau.micr.amb
            0.1,          # tau.soil.amb
            1.55,         # tau.bg.lit.amb
            0.5,          # frac.myco.amb
            0.5,          # frac.ag.amb
            0.5,          # frac.bg.amb
            0.5           # frac.micr.amb
)

params.lower <- c(0.55,
                  0.05,
                  0.05,
                  1.0,
                  0.01,
                  1.0,
                  0.4,
                  0.4,
                  0.4,
                  0.4)


params.upper <- c(0.65,
                  #0.25,           # alloc to wood, assumed to be the difference
                  0.15,
                  0.15,
                  20.0,
                  0.2,
                  2.0,
                  0.6,
                  0.6,
                  0.6,
                  0.6)

### Pools
Pools.amb.mean <- matrix(c(151,        # C.ol.amb
                           156,        # C.ua.amb
                           0.17,       # C.ins.amb
                           4966,       # C.stem.amb
                           777,        # C.croot.amb
                           78.6,       # C.froot.amb
                           7.4,        # C.myco.amb
                           91,         # C.ag.lit.amb
                           78.6,       # C.bg.lit.amb
                           64,         # C.micr.amb
                           2183),       # C.soil.amb
                         nrow=1, ncol=11, byrow=T)


Pools.amb.sd <- matrix(c(14,          # C.ol.amb
                         20,          # C.ua.amb
                         0.03,        # C.ins.amb
                         344,         # C.stem.amb
                         62,          # C.croot.amb
                         6.3,         # C.froot.amb
                         1.6,         # C.myco.amb
                         20,          # C.ag.lit.amb
                         6.3,         # C.bg.lit.amb
                         5.3,         # C.micr.amb
                         280),        # C.soil.amb
                       nrow=1, ncol=11, byrow=T)

### Change in pools
Delta.amb.mean <- matrix(c(16.72,        # C.ol.amb
                           4.32,         # C.ua.amb
                           0.18,         # C.ins.amb
                           44.75,        # C.stem.amb
                           5.34,         # C.croot.amb
                           -32.21,       # C.froot.amb
                           -1.57,        # C.myco.amb
                           13.8,         # C.ag.lit.amb
                           0.0,          # C.bg.lit.amb
                           -13.5,        # C.micr.amb
                           -58.61),      # C.soil.amb
                         nrow=1, ncol=11, byrow=T)

Delta.amb.sd <- matrix(c(9.5,          # C.ol.amb
                         21.8,         # C.ua.amb
                         0.07,         # C.ins.amb
                         30.5,         # C.stem.amb
                         4.1,          # C.croot.amb
                         13.6,         # C.froot.amb
                         0.7,          # C.myco.amb
                         3.2,          # C.ag.lit.amb
                         13.6,         # C.bg.lit.amb
                         4.8,          # C.micr.amb
                         72.6),        # C.soil.amb
                       nrow=1, ncol=11, byrow=T)


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
NPP.amb.mean <- data.frame(192 + 25.5 + 146,
                           107 + 43.4 + 5.2,
                           89.6, 
                           91)

NPP.amb.sd <- data.frame(0.2 + 4.3 + 22,
                         6.0 + 14.3 + 2.1,
                         50.2,
                         10.0)      # guess value

colnames(NPP.amb.mean) <- colnames(NPP.amb.sd) <- c("NPP.leaf", "NPP.wood", "NPP.froot", "NPP.myco")

