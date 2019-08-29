traceability_framework_EucFACE_aCO2 <- function(pool.size) {
    
    if (pool.size == 5) {
        print("pool size = 5")
        
        ### Pool vector X
        X2 <- matrix(c(151 + 156 + 0.17, # leaf 
                       4966,             # wood
                       78.6 + 7.4,       # froot + mycorrhizae
                       777,              # coarseroot
                       2183),            # soil
                     nrow = 5) 
        
        X_obs <- round(sum(X2)/1000, 2)
        print(paste0("C storage observed = ", X_obs, " kg m-2" ))
        
        ### partitioning coefficients to plants, B
        B2 <- t(matrix(c(0.597, 0.247, 0.147, 0.009, 0), nrow=1))
        
        ### A matrix: Carbon transfer matrix among pools
        ###           determined by lignin/nitrogen ratio from plant to litter pools,
        ###           lignin fraction from litter to soil pools
        ###           and soil texture among soil pools
        A2 <- diag(5)
        
        A2[5,1] <- -1
        A2[5,2] <- -1
        A2[5,3] <- -1
        A2[5,4] <- -1
        
        ### matrix C, fraction of carbon left from pool after each time step
        ###           potential decay rates of differen carbon pools
        ###           firstly preset and then modified by lgnin fraction and soil texture
        C2 <- diag(c(1.183, 0.009, 1.042, 0.007, 0.223))
        
        ### E
        E2 <- diag(c(1,1,1,1,1))
        
        ### ecosystem carbon residence time
        tauE_t <- solve(C2) %*% solve(A2) %*% B2
        
        ### E2-1 * tauE_t
        tauE <- solve(E2) %*% tauE_t
        
        
        ### ecosystem C residence time
        tauE_t <- solve(C2) %*% solve(A2) %*% B2
        
        tauE <- solve(E2) %*% tauE_t
        
        ### U: NPP inputA
        U <- 608.7
        
        
        ### ecosystem carbon storage capacity
        Xss <- tauE * U
        
        ### total ecosystem carbon storage capacity (kg m-2)
        tot_C <- round(sum(Xss) / 1000,2)
        print(paste0("C storage = ", tot_C, " kg m-2" ))
        
        tot_tau <- round(sum(tauE),2)
        print(paste0("C residence time = ", tot_tau, " yr" ))
        
        
    } else if (pool.size == 9) {
        print("pool size = 9")
        
        ### Pool vector X
        X2 <- matrix(c(151 + 156 + 0.17,      # leaf 
                       78.6 + 7.4,            # froot + mycorrhizae
                       4966 + 777,            # wood
                       151 + 156 + 0.17 - 91, # metabolic
                       91,                    # structural
                       1000,                  # cwd
                       64,                    # microbial - fast
                       2183/2,                # slow 
                       2183/2),               # passive
                     nrow = 9) 
        
        X_obs <- round(sum(X2)/1000, 2)
        print(paste0("C storage observed = ", X_obs, " kg m-2" ))
        
        ### partitioning coefficients to plants, B
        B2 <- t(matrix(c(0.597,               # leaf
                         0.147,               # root
                         0.247+0.009,         # stem
                         0,0,0,0,0,0), nrow=1))
        
        ### A matrix: Carbon transfer matrix among pools
        ###           determined by lignin/nitrogen ratio from plant to litter pools,
        ###           lignin fraction from litter to soil pools
        ###           and soil texture among soil pools
        A2 <- diag(9)
        
        A2[4,1] <- -0.67     # CABLE
        A2[5,1] <- -0.33     # CABLE
        A2[4,2] <- -0.58     # CABLE
        A2[5,2] <- -0.42     # CABLE
        A2[6,3] <- -1.0      # CABLE
        A2[7,4] <- -0.45     # CABLE
        A2[7,5] <- -0.36     # CABLE
        A2[8,5] <- -0.14     # CABLE
        A2[7,6] <- -0.24     # CABLE
        A2[8,6] <- -0.28     # CABLE
        A2[8,7] <- -0.39     # CABLE
        A2[9,7] <- -0.006    # CABLE
        A2[9,8] <- -0.003    # CABLE
        
        ### matrix C, fraction of carbon left from pool after each time step
        ###           potential decay rates of differen carbon pools
        ###           firstly preset and then modified by lgnin fraction and soil texture
        C2 <- diag(c(1.183,            # leaf, FACE result
                     1.042,            # root, FACE result
                     0.008,            # wood, FACE result
                     10,               # metabolic, CABLE
                     0.95,             # structural, CABLE
                     0.49,             # cwd, CABLE
                     1.97,             # fast, CABLE
                     0.223,            # slow, FACE
                     0.223))           # passive, FACE
        

        
        ### E
        E2 <- diag(c(1,1,1,1,1,1,1,1,1))
        
        ### ecosystem carbon residence time
        tauE_t <- solve(C2) %*% solve(A2) %*% B2
        
        ### E2-1 * tauE_t
        tauE <- solve(E2) %*% tauE_t
        
        
        ### ecosystem C residence time
        tauE_t <- solve(C2) %*% solve(A2) %*% B2
        
        tauE <- solve(E2) %*% tauE_t
        
        ### U: NPP inputA
        U <- 608.7
        
        
        ### ecosystem carbon storage capacity
        Xss <- tauE * U
        
        ### total ecosystem carbon storage capacity (kg m-2)
        tot_C <- round(sum(Xss) / 1000,2)
        print(paste0("C storage = ", tot_C, " kg m-2" ))
        
        tot_tau <- round(sum(tauE),2)
        print(paste0("C storage = ", tot_tau, " yr" ))
        
        
        
    }
    
    
}