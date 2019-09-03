traceability_EucFACE_eCO2_output <- function(params) {
    
    
    ### params
    tau.micr.ele <- params[1]
    tau.soil.ele <- params[2]
    tau.bg.lit.ele <- params[3]
    
    frac.myco.ele <- params[4]
    frac.ag.ele <- params[5]
    frac.bg.ele <- params[6]
    frac.micr.ele <- params[7]
    
    
    ### pools
    X2 <- matrix(c(C.leaf.ele,
                   C.wood.ele,
                   C.froot.ele,
                   C.myco.ele,
                   C.ag.lit.ele,
                   C.bg.lit.ele,
                   C.micr.ele,
                   C.soil.ele),                
                 nrow = 8) 
    
    X_obs <- round(sum(X2)/1000, 2)

    
    ### partitioning coefficients to plants, B
    B2 <- t(matrix(c(alloc.leaf.ele,
                     alloc.wood.ele,
                     alloc.froot.ele,
                     alloc.myco.ele,
                     0,0,0,0), nrow=1))
    
    ### A matrix: Carbon transfer matrix among pools
    ###           determined by lignin/nitrogen ratio from plant to litter pools,
    ###           lignin fraction from litter to soil pools
    ###           and soil texture among soil pools
    A2 <- diag(8)
    
    
    A2[5,1] <- -1.0            # leaf to AG               
    A2[6,3] <- -1.0            # froot to BG
    A2[7,4] <- -frac.myco.ele      # mycorrhizae to microbe 
    A2[7,5] <- -frac.ag.ele        # AGlitter to microbe 
    A2[7,6] <- -frac.bg.ele        # BGlitter to microbe 
    A2[8,7] <- -frac.micr.ele      # microbe to soil 
    
    
    ### matrix C, fraction of carbon left from pool after each time step
    ###           potential decay rates of differen carbon pools
    ###           firstly preset and then modified by lgnin fraction and soil texture in CABLE
    C2 <- diag(c(tau.leaf.ele,
                 tau.wood.ele,
                 tau.froot.ele,
                 tau.myco.ele,
                 tau.ag.lit.ele,
                 tau.bg.lit.ele,
                 tau.micr.ele,
                 tau.soil.ele))        
    
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
    U <- NPP.ele
    
    
    ### ecosystem carbon storage capacity
    Xss <- tauE * U
    
    ### total ecosystem carbon storage capacity (kg m-2)
    tot_C <- round(sum(Xss) / 1000,2)
    
    ### C residence time
    tot_tau <- round(sum(tauE),2)
    
    
    ### total Rhet
    Rhet <- round(C.ag.lit.ele * (1 - frac.ag.ele) * tau.ag.lit.ele +
                      C.bg.lit.ele * (1 - frac.bg.ele) * tau.bg.lit.ele +
                      C.micr.ele * (1 - frac.micr.ele) * tau.micr.ele +
                      C.myco.ele * (1 - frac.myco.ele) * tau.myco.ele + 
                      C.soil.ele * tau.soil.ele, 2)
    
    Rhet.diff <- abs(Rhet.obs.ele - Rhet)
    
    #### output stuffs
    print(paste0("C storage observed = ", X_obs, " kg m-2" ))
    
    print(paste0("C storage = ", tot_C, " kg m-2" ))
    
    print(paste0("Rhet observed = ", Rhet.obs.ele, " g m-2 yr-1"))
    
    print(paste0("Rhet = ", Rhet, " g m-2 yr-1"))
    
    print(paste0("C residence time = ", tot_tau, " yr" ))
    
    
    
}