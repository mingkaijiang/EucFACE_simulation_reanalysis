read_in_ocnx <- function() {

    ##################################################
    ##Read in output data and prepare data format
    ##################################################
    ## read cn amb obs
    inDF1 <- read.csv("model_output/OCNX/D1OCNXEUCAMBAVG.csv")
    
    inDF2 <- read.csv("model_output/OCNX/D1OCNXEUCELEAVG.csv")
    
    inDF1[inDF1=="-9999"] <- 0
    inDF2[inDF2=="-9999"] <- 0
    
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
        annDF1$CFLIT[annDF1$YEAR == i] <- inDF1$CFLIT[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CFLITA[annDF1$YEAR == i] <- inDF1$CFLITA[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CFLITB[annDF1$YEAR == i] <- inDF1$CFLITB[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CCLITB[annDF1$YEAR == i] <- inDF1$CCLITB[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$CSOIL[annDF1$YEAR == i] <- inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$TNC[annDF1$YEAR == i] <- inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==1]
    }
    
    
    for (i in yr) {
        annDF2$CL[annDF2$YEAR == i] <- inDF2$CL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CW[annDF2$YEAR == i] <- inDF2$CW[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CCR[annDF2$YEAR == i] <- inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CFR[annDF2$YEAR == i] <- inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CFLIT[annDF2$YEAR == i] <- inDF2$CFLIT[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CFLITA[annDF2$YEAR == i] <- inDF2$CFLITA[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CFLITB[annDF2$YEAR == i] <- inDF2$CFLITB[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CCLITB[annDF2$YEAR == i] <- inDF2$CCLITB[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$CSOIL[annDF2$YEAR == i] <- inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$TNC[annDF2$YEAR == i] <- inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==1]
    }
    
    ### delta pools
    for (i in yr2) {
        annDF1$delta_CL[annDF1$YEAR == i] <- inDF1$CL[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CL[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CW[annDF1$YEAR == i] <- inDF1$CW[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CW[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CCR[annDF1$YEAR == i] <- inDF1$CCR[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CCR[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CFR[annDF1$YEAR == i] <- inDF1$CFR[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CFR[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CFLIT[annDF1$YEAR == i] <- inDF1$CFLIT[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CFLIT[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CFLITA[annDF1$YEAR == i] <- inDF1$CFLITA[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CFLITA[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CFLITB[annDF1$YEAR == i] <- inDF1$CFLITB[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CFLITB[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CCLITB[annDF1$YEAR == i] <- inDF1$CCLITB[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CCLITB[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_CSOIL[annDF1$YEAR == i] <- inDF1$CSOIL[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==1]
        annDF1$delta_TNC[annDF1$YEAR == i] <- inDF1$TNC[inDF1$YEAR==(i+1)&inDF1$DOY==1]-inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==1]
    }
    
    for (i in yr2) {
        annDF2$delta_CL[annDF2$YEAR == i] <- inDF2$CL[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CW[annDF2$YEAR == i] <- inDF2$CW[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CW[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CCR[annDF2$YEAR == i] <- inDF2$CCR[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CFR[annDF2$YEAR == i] <- inDF2$CFR[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CFLIT[annDF2$YEAR == i] <- inDF2$CFLIT[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CFLIT[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CFLITA[annDF2$YEAR == i] <- inDF2$CFLITA[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CFLITA[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CFLITB[annDF2$YEAR == i] <- inDF2$CFLITB[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CFLITB[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CCLITB[annDF2$YEAR == i] <- inDF2$CCLITB[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CCLITB[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_CSOIL[annDF2$YEAR == i] <- inDF2$CSOIL[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==1]
        annDF2$delta_TNC[annDF2$YEAR == i] <- inDF2$TNC[inDF2$YEAR==(i+1)&inDF2$DOY==1]-inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==1]
    }
    
    i <- "2023"
    
    annDF1$delta_CL[annDF1$YEAR == i] <- inDF1$CL[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CL[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CW[annDF1$YEAR == i] <- inDF1$CW[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CW[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CCR[annDF1$YEAR == i] <- inDF1$CCR[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CCR[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CFR[annDF1$YEAR == i] <- inDF1$CFR[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CFR[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CFLIT[annDF1$YEAR == i] <- inDF1$CFLIT[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CFLIT[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CFLITA[annDF1$YEAR == i] <- inDF1$CFLITA[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CFLITA[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CFLITB[annDF1$YEAR == i] <- inDF1$CFLITB[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CFLITB[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CCLITB[annDF1$YEAR == i] <- inDF1$CCLITB[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CCLITB[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_CSOIL[annDF1$YEAR == i] <- inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$CSOIL[inDF1$YEAR==i&inDF1$DOY==1]
    annDF1$delta_TNC[annDF1$YEAR == i] <- inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==365]-inDF1$TNC[inDF1$YEAR==i&inDF1$DOY==1]
    
    
    annDF2$delta_CL[annDF2$YEAR == i] <- inDF2$CL[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CL[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CW[annDF2$YEAR == i] <- inDF2$CW[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CW[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CCR[annDF2$YEAR == i] <- inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CCR[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CFR[annDF2$YEAR == i] <- inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CFR[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CFLIT[annDF2$YEAR == i] <- inDF2$CFLIT[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CFLIT[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CFLITA[annDF2$YEAR == i] <- inDF2$CFLITA[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CFLITA[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CFLITB[annDF2$YEAR == i] <- inDF2$CFLITB[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CFLITB[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CCLITB[annDF2$YEAR == i] <- inDF2$CCLITB[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CCLITB[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_CSOIL[annDF2$YEAR == i] <- inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$CSOIL[inDF2$YEAR==i&inDF2$DOY==1]
    annDF2$delta_TNC[annDF2$YEAR == i] <- inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==365]-inDF2$TNC[inDF2$YEAR==i&inDF2$DOY==1]
    
    
    ### assign CO2 treatment
    annDF1$CO2 <- "aCO2"
    annDF2$CO2 <- "eCO2"
    
    outDF1 <- rbind(annDF1, annDF2)
    
    outDF2 <- summaryBy(.~CO2, keep.names=T, data=outDF1, FUN=mean)
    
    outDF2$YEAR <- NULL
    
    return(outDF2)
    
}