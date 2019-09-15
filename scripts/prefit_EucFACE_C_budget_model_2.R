prefit_EucFACE_C_budget_model_2 <- function(params, 
                                            obs) {
  
  ######################################################################
  #### read in params and data
  ### params these are parameters we need to constrain
  alloc.leaf <- params[1]
  alloc.wood <- params[2]
  alloc.froot <- params[3]
  alloc.myco <- 1 - alloc.leaf - alloc.froot - alloc.wood
  
  ### get total NPP
  NPP.tot <- obs$GPP.mean - obs$Ra.mean
  
  ### CUE
  CUE <- NPP.tot / obs$GPP.mean
  
  ### individual NPP fluxes
  NPP.leaf <- NPP.tot * alloc.leaf
  NPP.wood <- NPP.tot * alloc.wood
  NPP.froot <- NPP.tot * alloc.froot
  NPP.myco <- NPP.tot * alloc.myco
  
  
  ### prepare output
  outDF <- data.frame(alloc.myco, obs$GPP.mean, NPP.tot, CUE,
                      NPP.leaf, NPP.wood, NPP.froot, NPP.myco)
  
  colnames(outDF) <- c("alloc.myco", "GPP", "NPP", "CUE",
                       "NPP.leaf", "NPP.wood", "NPP.froot", "NPP.myco")
  
  return(outDF)
  
}
