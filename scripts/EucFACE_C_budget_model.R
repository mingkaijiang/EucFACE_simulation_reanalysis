EucFACE_C_budget_model <- function(params, GPP, NPP, Pools, delta) {
  
  ######################################################################
  #### read in params and data
  ### params these are parameters we need to constrain
  tau.micr <- params[1] 
  tau.soil <- params[2]
  tau.bg.lit <- params[3]
  
  frac.myco <- params[4]
  frac.ag <- params[5]
  frac.bg <- params[6]
  frac.micr <- params[7]
  
  ### input GPP
  GPP.o <- GPP[1]
  GPP.u <- GPP[2]
  GPP.tot <- GPP.o + GPP.u
  

  ### input NPP
  NPP.ol <- NPP[1]
  NPP.other <- NPP[2]
  NPP.stem <- NPP[3]
  NPP.croot <- NPP[4]
  NPP.froot <- NPP[5]
  NPP.myco <- NPP[6]
  NPP.ins <- NPP[7]
  NPP.und <- NPP[8]
  
  NPP.leaf <- NPP.ol + NPP.und + NPP.ins
  NPP.wood <- NPP.stem + NPP.croot + NPP.other
  NPP.tot <- NPP.leaf + NPP.wood + NPP.froot + NPP.myco
  
  ### CUE
  CUE <- NPP.tot / GPP.tot
  
  ### compute allocation coefficients
  alloc.leaf <- NPP.leaf / NPP.tot
  alloc.wood <- NPP.wood / NPP.tot
  alloc.froot <- NPP.froot / NPP.tot
  alloc.myco <- NPP.myco / NPP.tot
  
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
  
  ### delta pools
  delta.C.ol <- delta[1]
  delta.C.ua <- delta[2]
  delta.C.ins <- delta[3]
  delta.C.leaf <- delta.C.ol + delta.C.ua + delta.C.ins
  
  delta.C.stem <- delta[4]
  delta.C.croot <- delta[5]
  delta.C.wood <- delta.C.stem + delta.C.croot
  
  delta.C.froot <- delta[6]
  delta.C.myco <- delta[7]
  delta.C.ag.lit <- delta[8]
  delta.C.bg.lit <- delta[9]
  delta.C.micr <- delta[10]
  delta.C.soil <- delta[11]
  
  ### turnover rate of pools
  tau.leaf <- (NPP.leaf - delta.C.leaf) / C.leaf
  tau.wood <- (NPP.wood - delta.C.wood) / C.wood
  tau.froot <- (NPP.froot - delta.C.froot) / C.froot
  tau.myco <- (NPP.myco - delta.C.myco) / C.myco
  
  tau.ag.lit <- ((tau.leaf * C.leaf) - delta.C.ag.lit) / C.ag.lit
  tau.bg.lit <- ((tau.froot * C.froot) - delta.C.bg.lit) / C.bg.lit
  
  
  ### write equations for change in pools
  delta.C.leaf.pred <- alloc.leaf * NPP.tot - tau.leaf * C.leaf
  delta.C.froot.pred <- alloc.froot * NPP.tot - tau.froot * C.froot
  delta.C.myco.pred <- alloc.myco * NPP.tot - tau.myco * C.myco
  delta.C.ag.lit.pred <- tau.leaf * C.leaf - tau.ag.lit * C.ag.lit
  delta.C.bg.lit.pred <- tau.froot * C.froot - tau.bg.lit * C.bg.lit
  delta.C.micr.pred <- tau.ag.lit * C.ag.lit + tau.bg.lit * C.bg.lit + tau.myco * C.myco - tau.micr * C.micr
  delta.C.soil.pred <- tau.micr * C.micr - tau.soil * C.soil
  
  
  ### total Rhet
  Rhet <- round(C.ag.lit * (1 - frac.ag) * tau.ag.lit +
                  C.bg.lit * (1 - frac.bg) * tau.bg.lit +
                  C.micr * (1 - frac.micr) * tau.micr +
                  C.myco * (1 - frac.myco) * tau.myco + 
                  C.soil * tau.soil, 2)
  
  ### prepare output
  outDF <- data.frame(GPP.tot, NPP.tot, 
                      delta.C.leaf.pred, delta.C.froot.pred, delta.C.myco.pred, 
                      delta.C.ag.lit.pred, delta.C.bg.lit.pred, 
                      delta.C.micr.pred, delta.C.soil.pred, Rhet)
  
  colnames(outDF) <- c("tot.GPP", "tot.NPP", 
                       "delta.Cleaf", "delta.Cfroot", "delta.Cmyco", 
                       "delta.Cag", "delta.Cbg",
                       "delta.Cmicr", "delta.Csoil", "Rhet")
  
  return(outDF)
  
}
