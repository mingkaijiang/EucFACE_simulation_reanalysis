read_in_EucFACE_output <- function() {
    
    ### prepare dataframe
    var.list <- c("ALEAF", "AWOOD", "AFROOT", "AOTHER",
                  "tau_LEAF", "tau_FROOT", "tau_MYCO",
                  "tau_CFLITA", "tau_CFLITB", "tau_MICR", "tau_SOIL")
    
    outDF <- data.frame(rep(c("aCO2", "eCO2"), each = 11),
                       rep(var.list, 2), NA, NA)
    
    colnames(outDF) <- c("CO2", "variable", "value", "sd")
    
    ### read in MCMC output
    inDF <-read.csv("output/set_aside_runs/parameter_summary_table.csv")
    inDF$tau.ag.lit[1] <- 365 * mean(c(0.0059, 0.0035, 0.0072))
    inDF$tau.ag.lit[2] <- 365 * mean(c(0.0056, 0.0079, 0.0083))
    
    inDF$tau.ag.lit.sd[1] <- 365 * sd(c(0.0059, 0.0035, 0.0072))
    inDF$tau.ag.lit.sd[2] <- 365 * sd(c(0.0056, 0.0079, 0.0083))
    
    ### assign values
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="ALEAF"] <- round(inDF$alloc.leaf[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="AWOOD"] <- round(inDF$alloc.wood[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="AFROOT"] <- round(inDF$alloc.froot[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="AOTHER"] <- round(inDF$alloc.myco[1], 3)
    
    
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="ALEAF"] <- round(inDF$alloc.leaf[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="AWOOD"] <- round(inDF$alloc.wood[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="AFROOT"] <- round(inDF$alloc.froot[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="AOTHER"] <- round(inDF$alloc.myco[2], 3)
    
    
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="ALEAF"] <- round(inDF$alloc.leaf.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="AWOOD"] <- round(inDF$alloc.wood.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="AFROOT"] <- round(inDF$alloc.froot.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="AOTHER"] <- round(inDF$alloc.myco.sd[1], 3)
    
    
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="ALEAF"] <- round(inDF$alloc.leaf.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="AWOOD"] <- round(inDF$alloc.wood.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="AFROOT"] <- round(inDF$alloc.froot.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="AOTHER"] <- round(inDF$alloc.myco.sd[2], 3)
    
    
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="tau_LEAF"] <- round(inDF$tau.leaf[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="tau_FROOT"] <- round(inDF$tau.froot[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="tau_MYCO"] <- round(inDF$tau.myco[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="tau_CFLITA"] <- round(inDF$tau.ag.lit[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="tau_CFLITB"] <- round(inDF$tau.bg.lit[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="tau_MICR"] <- round(inDF$tau.micr[1], 3)
    outDF$value[outDF$CO2=="aCO2"&outDF$variable=="tau_SOIL"] <- round(inDF$tau.soil[1], 3)
    
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="tau_LEAF"] <- round(inDF$tau.leaf[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="tau_FROOT"] <- round(inDF$tau.froot[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="tau_MYCO"] <- round(inDF$tau.myco[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="tau_CFLITA"] <- round(inDF$tau.ag.lit[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="tau_CFLITB"] <- round(inDF$tau.bg.lit[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="tau_MICR"] <- round(inDF$tau.micr[2], 3)
    outDF$value[outDF$CO2=="eCO2"&outDF$variable=="tau_SOIL"] <- round(inDF$tau.soil[2], 3)
    
    
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="tau_LEAF"] <- round(inDF$tau.leaf.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="tau_FROOT"] <- round(inDF$tau.froot.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="tau_MYCO"] <- round(inDF$tau.myco.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="tau_CFLITA"] <- round(inDF$tau.ag.lit.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="tau_CFLITB"] <- round(inDF$tau.bg.lit.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="tau_MICR"] <- round(inDF$tau.micr.sd[1], 3)
    outDF$sd[outDF$CO2=="aCO2"&outDF$variable=="tau_SOIL"] <- round(inDF$tau.soil.sd[1], 3)
    
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="tau_LEAF"] <- round(inDF$tau.leaf.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="tau_FROOT"] <- round(inDF$tau.froot.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="tau_MYCO"] <- round(inDF$tau.myco.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="tau_CFLITA"] <- round(inDF$tau.ag.lit.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="tau_CFLITB"] <- round(inDF$tau.bg.lit.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="tau_MICR"] <- round(inDF$tau.micr.sd[2], 3)
    outDF$sd[outDF$CO2=="eCO2"&outDF$variable=="tau_SOIL"] <- round(inDF$tau.soil.sd[2], 3)
    
    
    diff <- subset(outDF, CO2 == "aCO2")
    diff$CO2 <- "pct"
    for (i in var.list) {
        diff$value[diff$variable==i] <- outDF$value[outDF$CO2=="eCO2"&outDF$variable==i] / outDF$value[outDF$CO2=="aCO2"&outDF$variable==i]
    }
    
    diff$sd <- NA
    
    outDF <- rbind(outDF, diff)
    
    return(outDF)
    
}