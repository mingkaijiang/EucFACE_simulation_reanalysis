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
  
  C.bg.lit <- params[11]

  frac.myco <- params[12]
  frac.ag <- params[13]
  frac.bg <- params[14]
  frac.micr <- params[15]
  
  ### get total NPP
  NPP.tot <- GPP - Ra
  
  ### CUE
  CUE <- NPP.tot / GPP
  
  ### individual NPP fluxes
  NPP.leaf <- NPP.tot * alloc.leaf
  NPP.wood <- NPP.tot * alloc.wood
  NPP.froot <- NPP.tot * alloc.froot
  NPP.myco <- NPP.tot * alloc.myco
  
  #browser()
  
  ### Pools
  C.leaf <- Pools[1]
  C.wood <- Pools[2]
  C.froot <- Pools[3]
  C.myco <- Pools[4]
  C.ag.lit <- Pools[5]
  C.micr <- Pools[6]
  C.soil <- Pools[7]
  
  
  ### write equations for change in pools
  delta.C.leaf <- NPP.leaf - tau.leaf * C.leaf
  delta.C.froot <- NPP.froot - tau.froot * C.froot
  delta.C.myco <- NPP.myco - tau.myco * C.myco
  
  delta.C.ag.lit <- tau.leaf * C.leaf - tau.ag.lit * C.ag.lit
  
  ### this is unconstrained
  delta.C.bg.lit <- tau.froot * C.froot - tau.bg.lit * C.bg.lit
  
  delta.C.micr <- frac.ag * tau.ag.lit * C.ag.lit + frac.bg * tau.bg.lit * C.bg.lit + frac.myco * tau.myco * C.myco - tau.micr * C.micr
  delta.C.soil <- frac.micr * tau.micr * C.micr - tau.soil * C.soil
  
  
  ### total Rhet
  Rhet <- round(C.ag.lit * (1 - frac.ag) * tau.ag.lit +
                  C.bg.lit * (1 - frac.bg) * tau.bg.lit +
                  C.micr * (1 - frac.micr) * tau.micr +
                  C.myco * (1 - frac.myco) * tau.myco + 
                  C.soil * tau.soil, 2)
  
  #browser()
  
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
