read_in_EucFACE_output <- function() {
    
    var.list <- c("ALEAF", "AWOOD", "AFROOT", "ACROOT", "AOTHER",
                  "tau_LEAF", "tau_WOOD", "tau_FROOT", "tau_CROOT", "tau_LIT", "tau_SOIL")
    
    inDF <- data.frame(rep(c("aCO2", "eCO2"), each = 11),
                       rep(var.list, 2), NA)
    
    colnames(inDF) <- c("CO2", "variable", "value")
    
    ### basic values
    npp.aCO2 <- 192 + 107 + 43.4 + 5.2 + 89.6 + 25.5 + 146
    npp.eCO2 <- 182 + 118 + 38.8 + 5.0 + 94.6 + 27.8 + 201
    
    Cleaf.aCO2 <- 151 + 0.17 + 156
    Cleaf.eCO2 <- 157 + 0.07 + 140
    
    Cwood.aCO2 <- 4966
    Cwood.eCO2 <- 5091
    
    Cfroot.aCO2 <- 78.6 + 7.4
    Cfroot.eCO2 <- 79.3 + 6.1
    
    Ccroot.aCO2 <- 777
    Ccroot.eCO2 <- 821
    
    Clit.aCO2 <- 91
    Clit.eCO2 <- 64
    
    Csoil.aCO2 <- 2183
    Csoil.eCO2 <- 2282
    
    
    ### assign values
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="ALEAF"] <- round((192 + 25.5 + 146) / npp.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="AWOOD"] <- round( (43.4 + 107) / npp.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="AFROOT"] <- round(89.6 / npp.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="ACROOT"] <- round(5.2 / npp.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="AOTHER"] <- 0.0
    
    
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="ALEAF"] <- round((182 + 27.8 + 201) / npp.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="AWOOD"] <- round( (118 + 38.8) / npp.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="AFROOT"] <- round(94.6 / npp.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="ACROOT"] <- round(5.0 / npp.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="AOTHER"] <- 0.0
    
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="tau_LEAF"] <- round((192 + 25.5 + 146) / Cleaf.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="tau_WOOD"] <- round(43.4 / Cwood.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="tau_FROOT"] <- round(89.6 / Cfroot.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="tau_CROOT"] <- round(5.2 / Ccroot.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="tau_LIT"] <- round( (192 + 146) / Clit.aCO2, 3)
    inDF$value[inDF$CO2=="aCO2"&inDF$variable=="tau_SOIL"] <- round((192 + 146 + 10.5 + 5.2 + 43.4 + 89.6) / Csoil.aCO2, 3)
    

    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="tau_LEAF"] <- round((192 + 25.5 + 146) / Cleaf.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="tau_WOOD"] <- round(43.4 / Cwood.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="tau_FROOT"] <- round(89.6 / Cfroot.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="tau_CROOT"] <- round(5.2 / Ccroot.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="tau_LIT"] <- round( (192 + 146) / Clit.eCO2, 3)
    inDF$value[inDF$CO2=="eCO2"&inDF$variable=="tau_SOIL"] <- round((192 + 146 + 10.5 + 5.2 + 43.4 + 89.6) / Csoil.eCO2, 3)
    
    
    diff <- subset(inDF, CO2 == "aCO2")
    diff$CO2 <- "pct"
    for (i in var.list) {
        diff$value[diff$variable==i] <- inDF$value[inDF$CO2=="eCO2"&inDF$variable==i] / inDF$value[inDF$CO2=="aCO2"&inDF$variable==i]
    }
    
    outDF <- rbind(inDF, diff)
    
    return(outDF)
    
}