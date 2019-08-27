read_in_cabl <- function() {

    ##################################################
    ##Read in output data and prepare data format
    ##################################################
    ## read cn amb obs
    inDF1 <- read.csv("model_output/CABL/D1CABLEUCAMBAVG.csv",
                      skip = 7, header=T)
    
    inDF2 <- read.csv("model_output/CABL/D1CABLEUCELEAVG.csv",
                      skip = 7, header=T)
    
    ### prepare a output df
    yr <- unique(inDF1$YEAR)
    yr2 <- yr[1:11]
    
    annDF1 <- summaryBy(NEP+GPP+NPP+RECO+RAUTO+RLEAF+RWOOD+RROOT+RGROW+RHET+RSOIL+GL+GW+GCR+GR+GREPR+CLLFALL+CCRLIN+CFRLIN+CWIN+CVOC~YEAR,
                        data=inDF1, keep.names=T, FUN=sum)
    
    annDF2 <- summaryBy(NEP+GPP+NPP+RECO+RAUTO+RLEAF+RWOOD+RROOT+RGROW+RHET+RSOIL+GL+GW+GCR+GR+GREPR+CLLFALL+CCRLIN+CFRLIN+CWIN+CVOC~YEAR,
                        data=inDF2, keep.names=T, FUN=sum)
    
    ### pools
    for (i in yr) {
        annDF1$CL[annDF1$YEAR == i] <- inDF1$CL[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CW[annDF1$YEAR == i] <- inDF1$CW[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CCR[annDF1$YEAR == i] <- inDF1$CCR[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CFR[annDF1$YEAR == i] <- inDF1$CFR[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CLIT1[annDF1$YEAR == i] <- inDF1$CLIT1[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CLIT2[annDF1$YEAR == i] <- inDF1$CLIT2[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CLIT3[annDF1$YEAR == i] <- inDF1$CLIT3[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CLIT4[annDF1$YEAR == i] <- inDF1$CLIT4[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CSOIL[annDF1$YEAR == i] <- inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$TNC[annDF1$YEAR == i] <- inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==1]
    }
    
    
    for (i in yr) {
        annDF2$CL[annDF2$YEAR == i] <- inDF2$CL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CW[annDF2$YEAR == i] <- inDF2$CW[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CCR[annDF2$YEAR == i] <- inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CFR[annDF2$YEAR == i] <- inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CLIT1[annDF2$YEAR == i] <- inDF2$CLIT1[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CLIT2[annDF2$YEAR == i] <- inDF2$CLIT2[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CLIT3[annDF2$YEAR == i] <- inDF2$CLIT3[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CLIT4[annDF2$YEAR == i] <- inDF2$CLIT4[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CSOIL[annDF2$YEAR == i] <- inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$TNC[annDF2$YEAR == i] <- inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==1]
    }
    
    ### delta pools
    for (i in yr2) {
        annDF1$delta_CL[annDF1$YEAR == i] <- inDF1$CL[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CL[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CW[annDF1$YEAR == i] <- inDF1$CW[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CW[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CCR[annDF1$YEAR == i] <- inDF1$CCR[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CCR[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CFR[annDF1$YEAR == i] <- inDF1$CFR[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CFR[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CLIT1[annDF1$YEAR == i] <- inDF1$CLIT1[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CLIT1[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CLIT2[annDF1$YEAR == i] <- inDF1$CLIT2[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CLIT2[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CLIT3[annDF1$YEAR == i] <- inDF1$CLIT3[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CLIT3[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CLIT4[annDF1$YEAR == i] <- inDF1$CLIT4[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CLIT4[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CSOIL[annDF1$YEAR == i] <- inDF1$CSOIL[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_TNC[annDF1$YEAR == i] <- inDF1$TNC[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==1]
    }
    
    for (i in yr2) {
        annDF2$delta_CL[annDF2$YEAR == i] <- inDF2$CL[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CW[annDF2$YEAR == i] <- inDF2$CW[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CW[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CCR[annDF2$YEAR == i] <- inDF2$CCR[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CFR[annDF2$YEAR == i] <- inDF2$CFR[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CLIT1[annDF2$YEAR == i] <- inDF2$CLIT1[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CLIT1[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CLIT2[annDF2$YEAR == i] <- inDF2$CLIT2[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CLIT2[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CLIT3[annDF2$YEAR == i] <- inDF2$CLIT3[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CLIT3[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CLIT4[annDF2$YEAR == i] <- inDF2$CLIT4[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CLIT4[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CSOIL[annDF2$YEAR == i] <- inDF2$CSOIL[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_TNC[annDF2$YEAR == i] <- inDF2$TNC[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==1]
    }
    
    i <- "2023"
    
    annDF1$delta_CL[annDF1$YEAR == i] <- inDF1$CL[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CL[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CW[annDF1$YEAR == i] <- inDF1$CW[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CW[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CCR[annDF1$YEAR == i] <- inDF1$CCR[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CCR[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CFR[annDF1$YEAR == i] <- inDF1$CFR[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CFR[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CLIT1[annDF1$YEAR == i] <- inDF1$CLIT1[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CLIT1[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CLIT2[annDF1$YEAR == i] <- inDF1$CLIT2[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CLIT2[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CLIT3[annDF1$YEAR == i] <- inDF1$CLIT3[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CLIT3[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CLIT4[annDF1$YEAR == i] <- inDF1$CLIT4[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CLIT4[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CSOIL[annDF1$YEAR == i] <- inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_TNC[annDF1$YEAR == i] <- inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==1]
    
    
    annDF2$delta_CL[annDF2$YEAR == i] <- inDF2$CL[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CL[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CW[annDF2$YEAR == i] <- inDF2$CW[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CW[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CCR[annDF2$YEAR == i] <- inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CFR[annDF2$YEAR == i] <- inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CLIT1[annDF2$YEAR == i] <- inDF2$CLIT1[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CLIT1[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CLIT2[annDF2$YEAR == i] <- inDF2$CLIT2[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CLIT2[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CLIT3[annDF2$YEAR == i] <- inDF2$CLIT3[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CLIT3[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CLIT4[annDF2$YEAR == i] <- inDF2$CLIT4[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CLIT4[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CSOIL[annDF2$YEAR == i] <- inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_TNC[annDF2$YEAR == i] <- inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==1]
    
    ### force to zero
    annDF1$GR <- annDF2$GR <- 0
    annDF1$GREPR <- annDF2$GREPR <- 0
    annDF1$CVOC <- annDF2$CVOC <- 0
    annDF1$CFRLIN <- annDF2$CFRLIN <- 0
    
    annDF1$CFR <- annDF2$CFR <- 0
    annDF1$CLIT4 <- annDF2$CLIT4 <- 0
    annDF1$delta_CFR <- annDF2$delta_CFR <- 0
    annDF1$delta_CLIT4 <- annDF2$delta_CLIT4 <- 0
    
    ### assign CO2 treatment
    annDF1$CO2 <- "aCO2"
    annDF2$CO2 <- "eCO2"
    
    outDF1 <- rbind(annDF1, annDF2)
    
    names(outDF1)[names(outDF1) == "CLIT1"] <- "CFLIT"
    names(outDF1)[names(outDF1) == "CLIT2"] <- "CFLITA"
    names(outDF1)[names(outDF1) == "CLIT3"] <- "CFLITB"
    names(outDF1)[names(outDF1) == "CLIT4"] <- "CCLITB"
    
    names(outDF1)[names(outDF1) == "delta_CLIT1"] <- "delta_CFLIT"
    names(outDF1)[names(outDF1) == "delta_CLIT2"] <- "delta_CFLITA"
    names(outDF1)[names(outDF1) == "delta_CLIT3"] <- "delta_CFLITB"
    names(outDF1)[names(outDF1) == "delta_CLIT4"] <- "delta_CCLITB"
    
    ### allocation coefficients
    outDF1$ALEAF <- round(outDF1$GL / outDF1$NPP, 3)
    outDF1$AWOOD <- round(outDF1$GW / outDF1$NPP,3)
    outDF1$AFROOT <- round(outDF1$GR / outDF1$NPP,3)
    outDF1$ACROOT <- round(outDF1$GCR / outDF1$NPP,3)
    outDF1$AOTHER <- round(1 - outDF1$ALEAF - outDF1$AWOOD - outDF1$AFROOT - outDF1$ACROOT, 2)
    
    ### turnover rates
    outDF1$tau_LEAF <- round(outDF1$CLLFALL/outDF1$CL,3)
    outDF1$tau_WOOD <- round(outDF1$CWIN/outDF1$CW,3)
    outDF1$tau_FROOT <- round(outDF1$CFRLIN/outDF1$CFR,3)
    outDF1$tau_CROOT <- round(outDF1$CCRLIN/outDF1$CCR,3)
    outDF1$tau_SOIL <- round(outDF1$RHET/outDF1$CSOIL, 3)
    
    outDF2 <- summaryBy(.~CO2, keep.names=T, data=outDF1, FUN=mean)
    
    outDF2$YEAR <- NULL
    
    return(outDF2)
    
}