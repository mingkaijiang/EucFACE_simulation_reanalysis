#### Define pools, parameters and fluxes

#### Pool vector X
C.ol.amb <- 151
C.ua.amb <- 156
C.ins.amb <- 0.17
C.leaf.amb <- C.ol.amb + C.ua.amb + C.ins.amb

C.stem.amb <- 4966
C.croot.amb <- 777
C.wood.amb <- C.stem.amb + C.croot.amb

C.froot.amb <- 78.6
C.myco.amb <- 7.4
C.ag.lit.amb <- 91
C.bg.lit.amb <- C.froot.amb

C.micr.amb <- 64
C.soil.amb <- 2183


#### fluxes
### Rhetero
Rhet.obs.amb <- 631

### GPP 
GPP.o.amb <- 1563
GPP.u.amb <- 497
GPP.amb <- GPP.o.amb + GPP.u.amb

### NPP
NPP.ol.amb <- 192
NPP.other.amb <- 107
NPP.stem.amb <- 43.4
NPP.croot.amb <- 5.2
NPP.froot.amb <- 89.6
NPP.myco.amb <- 91
NPP.ins.amb <- 25.5
NPP.und.amb <- 146

NPP.leaf.amb <- NPP.ol.amb + NPP.und.amb + NPP.ins.amb
NPP.wood.amb <- NPP.stem.amb + NPP.croot.amb + NPP.other.amb

NPP.amb <- NPP.leaf.amb + NPP.wood.amb + NPP.froot.amb + NPP.myco.amb

### CUE
CUE <- NPP.amb / GPP.amb

### allocation coefficients
alloc.leaf.amb <- NPP.leaf.amb / NPP.amb
alloc.wood.amb <- NPP.wood.amb / NPP.amb
alloc.froot.amb <- NPP.froot.amb / NPP.amb
alloc.myco.amb <- NPP.myco.amb / NPP.amb

### fractions of pool moved to the next pool
### the rest goes to Rhetero
frac.myco.amb <- 0.5          
frac.ag.amb <- 0.5
frac.bg.amb <- 0.5
frac.micr.amb <- 0.5


### turnover rate of pools
tau.leaf.amb <- 1.183
tau.wood.amb <- 0.008
tau.froot.amb <- 1.042
tau.myco.amb <- 12.3
tau.ag.lit.amb <- 3.71
tau.bg.lit.amb <- tau.ag.lit.amb
tau.micr.amb <- tau.myco.amb
tau.soil.amb <- 0.02


