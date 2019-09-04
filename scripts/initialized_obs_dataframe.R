initialize_obs_dataframe <- function(GPP.mean, NPP.mean, Pools.mean, delta.mean,
                                     GPP.sd, NPP.sd, Pools.sd, delta.sd,
                                     Rhet.mean, Rhet.sd) {
    
    ### prepare delta mean
    delta.C.ol.mean <- delta.mean[1]
    delta.C.ua.mean <- delta.mean[2]
    delta.C.ins.mean <- delta.mean[3]
    delta.C.leaf.mean <- delta.C.ol.mean + delta.C.ua.mean + delta.C.ins.mean
    
    delta.C.stem.mean <- delta.mean[4]
    delta.C.croot.mean <- delta.mean[5]
    delta.C.wood.mean <- delta.C.stem.mean + delta.C.croot.mean
    
    delta.C.froot.mean <- delta.mean[6]
    delta.C.myco.mean <- delta.mean[7]
    delta.C.ag.lit.mean <- delta.mean[8]
    delta.C.bg.lit.mean <- delta.mean[9]
    delta.C.micr.mean <- delta.mean[10]
    delta.C.soil.mean <- delta.mean[11]
    
    
    ### prepare delta sd
    delta.C.ol.sd <- delta.sd[1]
    delta.C.ua.sd <- delta.sd[2]
    delta.C.ins.sd <- delta.sd[3]
    delta.C.leaf.sd <- delta.C.ol.sd + delta.C.ua.sd + delta.C.ins.sd
    
    delta.C.stem.sd <- delta.sd[4]
    delta.C.croot.sd <- delta.sd[5]
    delta.C.wood.sd <- delta.C.stem.sd + delta.C.croot.sd
    
    delta.C.froot.sd <- delta.sd[6]
    delta.C.myco.sd <- delta.sd[7]
    delta.C.ag.lit.sd <- delta.sd[8]
    delta.C.bg.lit.sd <- delta.sd[9]
    delta.C.micr.sd <- delta.sd[10]
    delta.C.soil.sd <- delta.sd[11]
    
    ### set outDF
    out <- data.frame(delta.C.leaf.mean, delta.C.froot.mean, delta.C.myco.mean, 
                      delta.C.ag.lit.mean, delta.C.bg.lit.mean, delta.C.micr.mean,
                      delta.C.soil.mean,
                      delta.C.leaf.sd, delta.C.froot.sd, delta.C.myco.sd, 
                      delta.C.ag.lit.sd, delta.C.bg.lit.sd, delta.C.micr.sd,
                      delta.C.soil.sd,
                      Rhet.mean, Rhet.sd)
    
    ## colnames
    colnames(out) <- c("delta.Cleaf.amb.mean", "delta.Cfroot.amb.mean", "delta.Cmyco.amb.mean", "delta.Cag.amb.mean",
                       "delta.Cbg.amb.mean", "delta.Cmicr.amb.mean", "delta.Csoil.amb.mean",
                       "delta.Cleaf.amb.sd", "delta.Cfroot.amb.sd", "delta.Cmyco.amb.sd", "delta.Cag.amb.sd",
                       "delta.Cbg.amb.sd", "delta.Cmicr.amb.sd", "delta.Csoil.amb.sd",
                       "Rhet.amb.mean", "Rhet.amb.sd")

    return(out)
}