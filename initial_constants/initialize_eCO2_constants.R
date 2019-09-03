#### Define pools, parameters and fluxes

########################################## Pools
### eCO2
C.ol.ele <- 157
C.ua.ele <- 140
C.ins.ele <- 0.07
C.leaf.ele <- C.ol.ele + C.ua.ele + C.ins.ele

C.stem.ele <- 5091
C.croot.ele <- 821
C.wood.ele <- C.stem.ele + C.croot.ele

C.froot.ele <- 79.3
C.myco.ele <- 6.1
C.ag.lit.ele <- 64
C.bg.lit.ele <- C.froot.ele

C.micr.ele <- 61
C.soil.ele <- 2282


############################################ Change in pools

### eCO2
delta.C.ol.ele <- 15.21
delta.C.ua.ele <- 31.54
delta.C.ins.ele <- 0.05
delta.C.leaf.ele <- delta.C.ol.ele + delta.C.ua.ele + delta.C.ins.ele

delta.C.stem.ele <- 37.37
delta.C.croot.ele <- 4.77
delta.C.wood.ele <- delta.C.stem.ele + delta.C.croot.ele

delta.C.froot.ele <- -24.83
delta.C.myco.ele <- -1.16
delta.C.ag.lit.ele <- 0.76
delta.C.bg.lit.ele <- 0
delta.C.micr.ele <- -11.59
delta.C.soil.ele <- -82.39


################################################ fluxes
### Rhetero
Rhet.obs.ele <- 742

### GPP 
GPP.o.ele <- 1754
GPP.u.ele <- 552
GPP.ele <- GPP.o.ele + GPP.u.ele

### NPP
## eCO2
NPP.ol.ele <- 182
NPP.other.ele <- 118
NPP.stem.ele <- 38.8
NPP.croot.ele <- 5.0
NPP.froot.ele <- 94.6
NPP.myco.ele <- 230
NPP.ins.ele <- 27.8
NPP.und.ele <- 201

NPP.leaf.ele <- NPP.ol.ele + NPP.und.ele + NPP.ins.ele
NPP.wood.ele <- NPP.stem.ele + NPP.croot.ele + NPP.other.ele

NPP.ele <- NPP.leaf.ele + NPP.wood.ele + NPP.froot.ele + NPP.myco.ele

### CUE
CUE.ele <- NPP.ele / GPP.ele

############################################# allocation coefficients
## eCO2
alloc.leaf.ele <- NPP.leaf.ele / NPP.ele
alloc.wood.ele <- NPP.wood.ele / NPP.ele
alloc.froot.ele <- NPP.froot.ele / NPP.ele
alloc.myco.ele <- NPP.myco.ele / NPP.ele

############################################# turnover rate of pools
## eCO2
tau.leaf.ele <- (NPP.leaf.ele - delta.C.leaf.ele) / C.leaf.ele
tau.wood.ele <- (NPP.wood.ele - delta.C.wood.ele) / C.wood.ele
tau.froot.ele <- (NPP.froot.ele - delta.C.froot.ele) / C.froot.ele
tau.myco.ele <- (NPP.myco.ele - delta.C.myco.ele) / C.myco.ele

tau.ag.lit.ele <- ((tau.leaf.ele * C.leaf.ele) - delta.C.ag.lit.ele) / C.ag.lit.ele
tau.bg.lit.ele <- ((tau.froot.ele * C.froot.ele) - delta.C.bg.lit.ele) / C.bg.lit.ele


########################################## transfer fractions to next pool
### fractions of pool moved to the next pool
### the rest goes to Rhetero
#frac.myco.ele <- 0.5          
#frac.ag.ele <- 0.5
#frac.bg.ele <- 0.5
#frac.micr.ele <- 0.5





