traceability_EucFACE_aCO2 <- function(params) {
    
    
    ### params
    tau.micr.amb <- params[1]
    tau.soil.amb <- params[2]
    tau.bg.lit.amb <- params[3]
    
    frac.myco.amb <- params[4]
    frac.ag.amb <- params[5]
    frac.bg.amb <- params[6]
    frac.micr.amb <- params[7]
    
    
    ### pools
    X2 <- matrix(c(C.leaf.amb,
                   C.wood.amb,
                   C.froot.amb,
                   C.myco.amb,
                   C.ag.lit.amb,
                   C.bg.lit.amb,
                   C.micr.amb,
                   C.soil.amb),                
                 nrow = 8) 
    
    X_obs <- round(sum(X2)/1000, 2)

    
    ### partitioning coefficients to plants, B
    B2 <- t(matrix(c(alloc.leaf.amb,
                     alloc.wood.amb,
                     alloc.froot.amb,
                     alloc.myco.amb,
                     0,0,0,0), nrow=1))
    
    ### A matrix: Carbon transfer matrix among pools
    ###           determined by lignin/nitrogen ratio from plant to litter pools,
    ###           lignin fraction from litter to soil pools
    ###           and soil texture among soil pools
    A2 <- diag(8)
    
    
    A2[5,1] <- -1.0            # leaf to AG               
    A2[6,3] <- -1.0            # froot to BG
    A2[7,4] <- -frac.myco.amb      # mycorrhizae to microbe 
    A2[7,5] <- -frac.ag.amb        # AGlitter to microbe 
    A2[7,6] <- -frac.bg.amb        # BGlitter to microbe 
    A2[8,7] <- -frac.micr.amb      # microbe to soil 
    
    
    ### matrix C, fraction of carbon left from pool after each time step
    ###           potential decay rates of differen carbon pools
    ###           firstly preset and then modified by lgnin fraction and soil texture in CABLE
    C2 <- diag(c(tau.leaf.amb,
                 tau.wood.amb,
                 tau.froot.amb,
                 tau.myco.amb,
                 tau.ag.lit.amb,
                 tau.bg.lit.amb,
                 tau.micr.amb,
                 tau.soil.amb))        
    
    ### E: environmental scalar
    E2 <- diag(c(1,1,1,1,1,1,1,1))
    
    ### ecosystem carbon residence time
    tauE_t <- solve(C2) %*% solve(A2) %*% B2
    
    ### E2-1 * tauE_t
    tauE <- solve(E2) %*% tauE_t
    
    ### ecosystem C residence time
    tauE_t <- solve(C2) %*% solve(A2) %*% B2
    
    tauE <- solve(E2) %*% tauE_t
    
    ### U: NPP inputA
    U <- NPP.amb
    
    
    ### ecosystem carbon storage capacity
    Xss <- tauE * U
    
    ### total ecosystem carbon storage capacity (kg m-2)
    tot_C <- round(sum(Xss) / 1000,2)
    
    ### C residence time
    tot_tau <- round(sum(tauE),2)
    
    
    ### total Rhet
    Rhet <- round(C.ag.lit.amb * (1 - frac.ag.amb) * tau.ag.lit.amb +
                      C.bg.lit.amb * (1 - frac.bg.amb) * tau.bg.lit.amb +
                      C.micr.amb * (1 - frac.micr.amb) * tau.micr.amb +
                      C.myco.amb * (1 - frac.myco.amb) * tau.myco.amb + 
                      C.soil.amb * tau.soil.amb, 2)
    
    Rhet.diff <- abs(Rhet.obs.amb - Rhet)
    
    
    return(Rhet.diff)
  

    
}