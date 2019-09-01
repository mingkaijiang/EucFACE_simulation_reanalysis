#### Define pools, parameters and fluxes

########################################## Pools
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


############################################ Change in pools
delta.C.ol.amb <- 16.72
delta.C.ua.amb <- 4.32
delta.C.ins.amb <- 0.18
delta.C.leaf.amb <- delta.C.ol.amb + delta.C.ua.amb + delta.C.ins.amb

delta.C.stem.amb <- 44.75
delta.C.croot.amb <- 5.34
delta.C.wood.amb <- delta.C.stem.amb + delta.C.croot.amb

delta.C.froot.amb <- -32.21
delta.C.myco.amb <- -1.57
delta.C.ag.lit.amb <- 13.8
delta.C.bg.lit.amb <- 0
delta.C.micr.amb <- -13.5
delta.C.soil.amb <- -58.61


################################################ fluxes
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

############################################# allocation coefficients
alloc.leaf.amb <- NPP.leaf.amb / NPP.amb
alloc.wood.amb <- NPP.wood.amb / NPP.amb
alloc.froot.amb <- NPP.froot.amb / NPP.amb
alloc.myco.amb <- NPP.myco.amb / NPP.amb


############################################# turnover rate of pools
tau.leaf.amb <- (NPP.leaf.amb - delta.C.leaf.amb) / C.leaf.amb
tau.wood.amb <- (NPP.wood.amb - delta.C.wood.amb) / C.wood.amb
tau.froot.amb <- (NPP.froot.amb - delta.C.froot.amb) / C.froot.amb
tau.myco.amb <- (NPP.myco.amb - delta.C.myco.amb) / C.myco.amb

tau.ag.lit.amb <- ((tau.leaf.amb * C.leaf.amb) - delta.C.ag.lit.amb) / C.ag.lit.amb
tau.bg.lit.amb <- ((tau.froot.amb * C.froot.amb) - delta.C.bg.lit.amb) / C.bg.lit.amb

#tau.micr.amb <- tau.myco.amb
#tau.soil.amb <- 0.2


########################################## transfer fractions to next pool
### fractions of pool moved to the next pool
### the rest goes to Rhetero
#frac.myco.amb <- 0.5          
#frac.ag.amb <- 0.5
#frac.bg.amb <- 0.5
#frac.micr.amb <- 0.5



