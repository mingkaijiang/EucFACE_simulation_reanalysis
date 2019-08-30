traceability_framework_EucFACE_Medlyn_framework_aCO2 <- function() {
    
        
        ### Pool vector X
        X2 <- matrix(c(151 + 156 + 0.17,      # leaf 
                       4966 + 777,            # wood
                       78.6,                  # froot
                       7.4,                   # mycorrhizae
                       91,                    # AG litter
                       7.86,                  # BG litter - guess value, same as froot pool
                       64,                    # microbial - fast
                       2183),                 # soil
                     nrow = 8) 
        
        X_obs <- round(sum(X2)/1000, 2)
        print(paste0("C storage observed = ", X_obs, " kg m-2" ))
        
        
        ### Rhetero
        Rhet_obs <- 631
        
        ### GPP 
        GPP <- 1563 + 497
        
        ### NPP
        NPP <- 192 +    # overstorey leaf
            107 +       # other
            43.4 +      # stem
            5.2 +       # croot
            89.6 +      # froot
            91 +        # mycorrhizae - estimated
            25.5 +      # insect
            146         # understorey aboveground
        
        ### CUE
        CUE <- NPP / GPP
        
        ### allocation coefficients
        alloc_leaf <- (192 + 146 + 25.5) / NPP
        alloc_wood <- (107 + 43.4 + 5.2) / NPP
        alloc_froot <- 89.6 / NPP
        alloc_myco <- 91 / NPP
        
        ### partitioning coefficients to plants, B
        B2 <- t(matrix(c(alloc_leaf,
                         alloc_wood,
                         alloc_froot,
                         alloc_myco,
                         0,0,0,0), nrow=1))
        
        ### A matrix: Carbon transfer matrix among pools
        ###           determined by lignin/nitrogen ratio from plant to litter pools,
        ###           lignin fraction from litter to soil pools
        ###           and soil texture among soil pools
        A2 <- diag(8)
        
        ### fractions of pool moved to the next pool
        ### the rest goes to Rhetero
        frac_myco <- 0.5          
        frac_ag <- 0.5
        frac_bg <- 0.5
        frac_micr <- 0.5
        
        A2[5,1] <- -1.0            # leaf to AG               
        A2[6,3] <- -1.0            # froot to BG
        A2[7,4] <- -frac_myco      # mycorrhizae to microbe 
        A2[7,5] <- -frac_ag        # AGlitter to microbe 
        A2[7,6] <- -frac_bg        # BGlitter to microbe 
        A2[8,7] <- -frac_micr      # microbe to soil 

        
        ### matrix C, fraction of carbon left from pool after each time step
        ###           potential decay rates of differen carbon pools
        ###           firstly preset and then modified by lgnin fraction and soil texture in CABLE
        tau_ag <- 3.71
        tau_bg <- tau_ag
        tau_micr <- 12.3     # same as mycorrhizae? 
        tau_soil <- 0.01     # guess
            
        C2 <- diag(c(1.183,            # leaf, FACE result
                     0.008,            # wood, FACE result
                     1.042,            # froot, FACE result
                     12.3,             # mycorrhizae - estimated
                     tau_ag,           # ag litter
                     tau_bg,           # bg litter
                     tau_micr,         # microbe
                     tau_soil))        # soil
        
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
        U <- NPP
        
        
        ### ecosystem carbon storage capacity
        Xss <- tauE * U
        
        ### total ecosystem carbon storage capacity (kg m-2)
        tot_C <- round(sum(Xss) / 1000,2)
        print(paste0("C storage = ", tot_C, " kg m-2" ))
        
        tot_tau <- round(sum(tauE),2)
        print(paste0("C storage = ", tot_tau, " yr" ))
        
        
        
    
    
    
}