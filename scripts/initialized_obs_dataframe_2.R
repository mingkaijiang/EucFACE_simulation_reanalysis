initialize_obs_dataframe_2 <- function() {
    #### This script reads in csv files from C budget
    #### and make them into the format ready for MCMC modeling
    
    #### read csv
    deltaDF <- read.csv("initial_constants/delta_pool.csv")
    
    ### prepare delta mean
    delta.C.leaf.mean <- delta.mean[1]
    delta.C.wood.mean <- delta.mean[2]
    delta.C.froot.mean <- delta.mean[3]
    delta.C.myco.mean <- delta.mean[4]
    delta.C.ag.lit.mean <- delta.mean[5]
    delta.C.micr.mean <- delta.mean[6]
    delta.C.soil.mean <- delta.mean[7]
    
    
    ### prepare delta sd
    delta.C.leaf.sd <- delta.sd[1]
    delta.C.wood.sd <- delta.sd[2]
    delta.C.froot.sd <- delta.sd[3]
    delta.C.myco.sd <- delta.sd[4]
    delta.C.ag.lit.sd <- delta.sd[5]
    delta.C.micr.sd <- delta.sd[6]
    delta.C.soil.sd <- delta.sd[7]
    
    
    ### set outDF
    out <- data.frame(NPP.mean, NPP.sd,
                      delta.C.leaf.mean, delta.C.froot.mean, delta.C.myco.mean, 
                      delta.C.ag.lit.mean, delta.C.micr.mean, delta.C.soil.mean,
                      delta.C.leaf.sd, delta.C.froot.sd, delta.C.myco.sd, 
                      delta.C.ag.lit.sd, delta.C.micr.sd, delta.C.soil.sd,
                      Rhet.mean, Rhet.sd)

    
    ## colnames
    colnames(out) <- c("NPP.leaf.mean", "NPP.wood.mean", "NPP.froot.mean", 
                       "NPP.leaf.sd", "NPP.wood.sd", "NPP.froot.sd",
                       "delta.Cleaf.mean", "delta.Cfroot.mean", "delta.Cmyco.mean", "delta.Cag.mean",
                       "delta.Cmicr.mean", "delta.Csoil.mean",
                       "delta.Cleaf.sd", "delta.Cfroot.sd", "delta.Cmyco.sd", "delta.Cag.sd",
                       "delta.Cmicr.sd", "delta.Csoil.sd",
                       "Rhet.mean", "Rhet.sd")

    return(out)
}