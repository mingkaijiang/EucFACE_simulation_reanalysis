EucFACE_C_budget_model <- function(params, GPP, Ra, Pools, delta) {
  
  ######################################################################
  #### read in params and data
  ### params these are parameters we need to constrain
  alloc.leaf <- params[1]
  alloc.froot <- params[2]
  alloc.myco <- params[3]
  alloc.wood <- 1 - alloc.leaf - alloc.froot - alloc.myco
  
  tau.leaf <- params[4]
  tau.froot <- params[5]
  tau.myco <- params[6]
  tau.ag.lit <- params[7]
  tau.bg.lit <- params[8]
  tau.micr <- params[9] 
  tau.soil <- params[10]

  frac.myco <- params[11]
  frac.ag <- params[12]
  frac.bg <- params[13]
  frac.micr <- params[14]
  
  ### get total NPP
  NPP.tot <- GPP - Ra
  
  ### CUE
  CUE <- NPP.tot / GPP
  
  ### individual NPP fluxes
  NPP.leaf <- NPP.tot * alloc.leaf
  NPP.wood <- NPP.tot * alloc.wood
  NPP.froot <- NPP.tot * alloc.froot
  NPP.myco <- NPP.tot * alloc.myco
  
  ### Pools
  C.ol <- Pools[1]
  C.ua <- Pools[2]
  C.ins <- Pools[3]
  C.leaf <- C.ol + C.ua + C.ins
  
  C.stem <- Pools[4]
  C.croot <- Pools[5]
  C.wood <- C.stem + C.croot
  
  C.froot <- Pools[6]
  C.myco <- Pools[7]
  C.ag.lit <- Pools[8]
  C.bg.lit <- Pools[9]
  
  C.micr <- Pools[10]
  C.soil <- Pools[11]
  
  
  ### write equations for change in pools
  delta.C.leaf <- NPP.leaf - tau.leaf * C.leaf
  delta.C.froot <- NPP.froot - tau.froot * C.froot
  delta.C.myco <- NPP.myco - tau.myco * C.myco
  
  delta.C.ag.lit <- tau.leaf * C.leaf - tau.ag.lit * C.ag.lit
  delta.C.bg.lit <- tau.froot * C.froot - tau.bg.lit * C.bg.lit
  
  delta.C.micr <- tau.ag.lit * C.ag.lit + tau.bg.lit * C.bg.lit + tau.myco * C.myco - tau.micr * C.micr
  delta.C.soil <- tau.micr * C.micr - tau.soil * C.soil
  
  
  ### turnover rate of pools
  #tau.leaf <- (NPP.leaf - delta.C.leaf) / C.leaf
  #tau.wood <- (NPP.wood - delta.C.wood) / C.wood
  #tau.froot <- (NPP.froot - delta.C.froot) / C.froot
  #tau.myco <- (NPP.myco - delta.C.myco) / C.myco
  #
  #tau.ag.lit <- ((tau.leaf * C.leaf) - delta.C.ag.lit) / C.ag.lit
  #tau.bg.lit <- ((tau.froot * C.froot) - delta.C.bg.lit) / C.bg.lit
  
  

  
  
  ### total Rhet
  Rhet <- round(C.ag.lit * (1 - frac.ag) * tau.ag.lit +
                  C.bg.lit * (1 - frac.bg) * tau.bg.lit +
                  C.micr * (1 - frac.micr) * tau.micr +
                  C.myco * (1 - frac.myco) * tau.myco + 
                  C.soil * tau.soil, 2)
  
  ### prepare output
  outDF <- data.frame(GPP, NPP.tot, CUE,
                      NPP.leaf, NPP.wood, NPP.froot, NPP.myco,
                      delta.C.leaf, delta.C.froot, delta.C.myco, 
                      delta.C.ag.lit, delta.C.bg.lit, 
                      delta.C.micr, delta.C.soil, Rhet)
  
  colnames(outDF) <- c("GPP", "NPP", "CUE",
                       "NPP.leaf", "NPP.wood", "NPP.froot", "NPP.myco",
                       "delta.Cleaf", "delta.Cfroot", "delta.Cmyco", 
                       "delta.Cag", "delta.Cbg",
                       "delta.Cmicr", "delta.Csoil", "Rhet")
  
  return(outDF)
  
}
