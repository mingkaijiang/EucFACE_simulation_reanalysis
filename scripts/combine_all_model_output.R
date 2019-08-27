combine_all_model_output <- function() {
    
    cablDF$model <- "CABL"
    clm4DF$model <- "CLM4"
    clmpDF$model <- "CLMP"
    gdayDF$model <- "GDAY"
    lpjwDF$model <- "LPJW"
    lpjxDF$model <- "LPJX"
    ocnxDF$model <- "OCNX"
    sdvmDF$model <- "SDVM"
    
    #outDF <- rbind(cablDF, clm4DF, clmpDF, gdayDF, lpjwDF, lpjxDF, ocnxDF, sdvmDF)
    outDF <- rbind(cablDF, clm4DF, clmpDF, gdayDF, lpjxDF, ocnxDF, sdvmDF)
    
    outDF[outDF<="-9999"] <- 0
    
    ### summary of problems:
    ### 1. we need to group coarseroot and stem together, but some models (CABLE) don't report fineroot C.
    ### 2. what to do with the deltas?
    ### 3. LPJW has a very large allocation fraction to other!
    ### 4. Csoil are large in all model output, and therefore tau soil is large. 
    ### 5. Is the simulated GPP overstorey only? 

}