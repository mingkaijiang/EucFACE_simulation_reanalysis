####################################### Define pools, parameters and fluxes
### set number of parameter variables
no.var <- 11

### EucFACE aCO2
params <- c(1.0,          # tau.micr.amb
            0.1,          # tau.soil.amb
            1.55,         # tau.bg.lit.amb
            0.5,          # frac.myco.amb
            0.5,          # frac.ag.amb
            0.5,          # frac.bg.amb
            0.5,          # frac.micr.amb
            0.6,          # alloc leaf
            0.1,          # alloc wood
            0.1,          # alloc froot
            0.2           # alloc myco
)


params.lower <- c(0.1,
                  0.001,
                  1.0,
                  0.1,
                  0.1,
                  0.1,
                  0.1,
                  0.5,
                  0.05,
                  0.05,
                  0.05)


params.upper <- c(20.0,
                  0.5,
                  2.0,
                  0.9,
                  0.9,
                  0.9,
                  0.9,
                  0.7,
                  0.2,
                  0.4,
                  0.5)

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
GPP.amb.mean <- matrix(c(1563,       # GPP.o.amb
                         497),       # GPP.u.amb
                       nrow=1,ncol=2,byrow=T)

GPP.amb.sd <- matrix(c(200,       # GPP.o.amb
                       28),       # GPP.u.amb
                     nrow=1,ncol=2,byrow=T)

### NPP
NPP.amb.mean <- matrix(c(192,        # NPP.ol.amb
                         107,        # NPP.other.amb
                         43.4,       # NPP.stem.amb
                         5.2,        # NPP.croot.amb
                         89.6,       # NPP.froot.amb
                         91,         # NPP.myco.amb
                         25.5,       # NPP.ins.amb
                         146),        # NPP.und.amb
                       nrow=1,ncol=8,byrow=T)

NPP.amb.sd <- matrix(c(0.2,        # NPP.ol.amb
                       6.0,        # NPP.other.amb
                       14.3,       # NPP.stem.amb
                       2.1,        # NPP.croot.amb
                       50.2,       # NPP.froot.amb
                       10.0,       # NPP.myco.amb, guess value
                       4.3,       # NPP.ins.amb
                       22),        # NPP.und.amb
                     nrow=1,ncol=8,byrow=T)

### Rhetero
Rhet.amb.mean <- 631
Rhet.amb.sd <- 134

