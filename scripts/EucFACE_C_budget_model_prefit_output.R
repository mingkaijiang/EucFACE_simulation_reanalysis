EucFACE_C_budget_model_prefit_output <- function(params) {
  
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
  GPP.o <- GPP.amb.mean[1]
  GPP.u <- GPP.amb.mean[2]
  GPP.tot <- GPP.o + GPP.u
  

  ### input NPP
  NPP.ol <- NPP.amb.mean[1]
  NPP.other <- NPP.amb.mean[2]
  NPP.stem <- NPP.amb.mean[3]
  NPP.croot <- NPP.amb.mean[4]
  NPP.froot <- NPP.amb.mean[5]
  NPP.myco <- NPP.amb.mean[6]
  NPP.ins <- NPP.amb.mean[7]
  NPP.und <- NPP.amb.mean[8]
  
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
  C.ol <- Pools.amb.mean[1]
  C.ua <- Pools.amb.mean[2]
  C.ins <- Pools.amb.mean[3]
  C.leaf <- C.ol + C.ua + C.ins
  
  C.stem <- Pools.amb.mean[4]
  C.croot <- Pools.amb.mean[5]
  C.wood <- C.stem + C.croot
  
  C.froot <- Pools.amb.mean[6]
  C.myco <- Pools.amb.mean[7]
  C.ag.lit <- Pools.amb.mean[8]
  C.bg.lit <- Pools.amb.mean[9]
  
  C.micr <- Pools.amb.mean[10]
  C.soil <- Pools.amb.mean[11]
  
  ### delta pools
  delta.C.ol <- Delta.amb.mean[1]
  delta.C.ua <- Delta.amb.mean[2]
  delta.C.ins <- Delta.amb.mean[3]
  delta.C.leaf <- delta.C.ol + delta.C.ua + delta.C.ins
  
  delta.C.stem <- Delta.amb.mean[4]
  delta.C.croot <- Delta.amb.mean[5]
  delta.C.wood <- delta.C.stem + delta.C.croot
  
  delta.C.froot <- Delta.amb.mean[6]
  delta.C.myco <- Delta.amb.mean[7]
  delta.C.ag.lit <- Delta.amb.mean[8]
  delta.C.bg.lit <- Delta.amb.mean[9]
  delta.C.micr <- Delta.amb.mean[10]
  delta.C.soil <- Delta.amb.mean[11]
  
  ### turnover rate of pools
  tau.leaf <- (NPP.leaf - delta.C.leaf) / C.leaf
  tau.wood <- (NPP.wood - delta.C.wood) / C.wood
  tau.froot <- (NPP.froot - delta.C.froot) / C.froot
  tau.myco <- (NPP.myco - delta.C.myco) / C.myco
  
  tau.ag.lit <- ((tau.leaf * C.leaf) - delta.C.ag.lit) / C.ag.lit
  tau.bg.lit <- ((tau.froot * C.froot) - delta.C.bg.lit) / C.bg.lit
  
  
  ######################################################################
  ### pools matrix
  X2 <- matrix(c(C.leaf,
                 C.wood,
                 C.froot,
                 C.myco,
                 C.ag.lit,
                 C.bg.lit,
                 C.micr,
                 C.soil),                
               nrow = 8) 
  
  ### return in kg m-2
  X_obs <- round(sum(X2)/1000, 2)
  
  ### partitioning coefficients to plants, B
  B2 <- t(matrix(c(alloc.leaf,
                   alloc.wood,
                   alloc.froot,
                   alloc.myco,
                   0,0,0,0), nrow=1))
  
  ### A matrix: Carbon transfer matrix among pools
  ###           determined by lignin/nitrogen ratio from plant to litter pools,
  ###           lignin fraction from litter to soil pools
  ###           and soil texture among soil pools
  A2 <- diag(1, 8, 8)
  
  A2[5,1] <- -1.0            # leaf to AG               
  A2[6,3] <- -1.0            # froot to BG
  A2[7,4] <- -as.numeric(frac.myco)      # mycorrhizae to microbe 
  A2[7,5] <- -as.numeric(frac.ag)        # AGlitter to microbe 
  A2[7,6] <- -as.numeric(frac.bg)        # BGlitter to microbe 
  A2[8,7] <- -as.numeric(frac.micr)      # microbe to soil 
  
  #browser()
  
  ### matrix C, fraction of carbon left from pool after each time step
  ###           potential decay rates of differen carbon pools
  ###           firstly preset and then modified by lgnin fraction and soil texture in CABLE
  C2 <- diag(c(tau.leaf,
               tau.wood,
               tau.froot,
               tau.myco,
               tau.ag.lit,
               tau.bg.lit,
               tau.micr,
               tau.soil))        
  
  ### E: environmental scalar
  E2 <- diag(c(1,1,1,1,1,1,1,1))
  
  ### ecosystem carbon residence time
  tauE_t <- solve(C2) %*% solve(A2) %*% B2
  
  #browser()
  
  
  ### E2-1 * tauE_t
  tauE <- solve(E2) %*% tauE_t
  
  ### U: NPP input 
  U <- NPP.tot
  
  ### ecosystem carbon storage capacity
  Xss <- tauE * U
  
  ### total ecosystem carbon storage capacity (kg m-2)
  tot_C <- round(sum(Xss) / 1000,2)
  
  ### C residence time
  tot_tau <- round(sum(tauE),2)
  
  ### total Rhet
  Rhet <- round(C.ag.lit * (1 - frac.ag) * tau.ag.lit +
                  C.bg.lit * (1 - frac.bg) * tau.bg.lit +
                  C.micr * (1 - frac.micr) * tau.micr +
                  C.myco * (1 - frac.myco) * tau.myco + 
                  C.soil * tau.soil, 2)
  
  Rhet.diff <- abs(Rhet.amb.mean - Rhet)
  
  ### prepare output
  outDF <- data.frame(tot_C, tot_tau, Rhet)
  colnames(outDF) <- c("tot.C", "tot.tau", "Rhet")
  
  return(outDF)
}
