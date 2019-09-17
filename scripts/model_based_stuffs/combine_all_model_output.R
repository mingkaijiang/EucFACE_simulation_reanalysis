combine_all_model_output <- function() {
    
    
    ### read in model output
    cablDF <- read_in_cabl()
    clm4DF <- read_in_clm4()
    clmpDF <- read_in_clmp()
    gdayDF <- read_in_gday()
    lpjwDF <- read_in_lpjw()
    lpjxDF <- read_in_lpjx()
    ocnxDF <- read_in_ocnx()
    sdvmDF <- read_in_sdvm()
    
    eucDF <- read_in_EucFACE_output()
    
    ### assign names
    cablDF$model <- "CABL"
    clm4DF$model <- "CLM4"
    clmpDF$model <- "CLMP"
    gdayDF$model <- "GDAY"
    lpjwDF$model <- "LPJW"
    lpjxDF$model <- "LPJX"
    ocnxDF$model <- "OCNX"
    sdvmDF$model <- "SDVM"
    
    ### we can effectively ignore lpjw because it's not included in the Medlyn 2016 paper
    outDF <- rbind(cablDF, clm4DF, clmpDF, gdayDF, lpjxDF, ocnxDF, sdvmDF)
    
    
    ### grouping allocation
    outDF$AWOOD_2 <- outDF$AWOOD + outDF$ACROOT  # CABLE has a large Froot pool, so Croot is part of it!
    outDF$tau_MYCO <- NA
    outDF$tau_MICR <- NA
    
    outDF[mapply(is.infinite, outDF)] <- NA

    ### summary of problems:
    ### 1. we need to group coarseroot and stem together,
    ###    but actually we can't, because for models that don't differ croot and froot, froot biomass is huge, 
    ###    so a fraction of that must be croot.
    ### 2. we haven't add delta into the calculations.
    ### 3. LPJW has a very large allocation fraction to other, which includes NTC and reproductive organs! Do we just ignore it?
    ### 4. Csoil and Cwood are large in all model output, and therefore tau soil and tau wood is problematic. 
    ### 5. The simulated GPP is overstorey only (in theory). 
    
    ### calculate multi-model mean
    subDF1 <- subset(outDF, CO2=="aCO2")
    subDF2 <- subset(outDF, CO2=="eCO2")
    
    subDF1 <- subDF1[,c("ALEAF", "AWOOD_2", "AFROOT", "AOTHER", 
                        "tau_LEAF", "tau_FROOT", "tau_MYCO",
                        "tau_CFLITA", "tau_CFLITB", "tau_MICR",
                        "tau_SOIL", "model")]
    
    subDF2 <- subDF2[,c("ALEAF", "AWOOD_2", "AFROOT", "AOTHER", 
                        "tau_LEAF", "tau_FROOT", "tau_MYCO",
                        "tau_CFLITA", "tau_CFLITB", "tau_MICR",
                        "tau_SOIL", "model")]
    
    mmDF1 <- colMeans(subDF1[,1:11], na.rm=T)
    mmDF2 <- colMeans(subDF2[,1:11], na.rm=T)
    
    sdDF1 <- apply(subDF1[ ,1:11], 2, sd, na.rm=T)
    sdDF2 <- apply(subDF2[ ,1:11], 2, sd, na.rm=T)
    
    mmDF <- as.data.frame(rbind(mmDF1, mmDF2))
    mmDF$Source <- "multi-mean"
    mmDF$CO2 <- c("aCO2", "eCO2")
    
    rsDF <- melt(mmDF, id.vars = c("Source", "CO2"))
    
    sdDF <- as.data.frame(rbind(sdDF1, sdDF2))
    sdDF$Source <- "multi-model"
    sdDF$CO2 <- c("aCO2", "eCO2")
    
    tDF <- melt(sdDF, id.vars = c("Source", "CO2"))
    
    rsDF$sd <- tDF$value
    
    ### eucDF
    eucDF$Source <- "data"
    rsDF$variable <- gsub("AWOOD_2", "AWOOD", rsDF$variable)
    rsDF <- rsDF[,c("CO2", "variable", "value", "sd", "Source")]
    
    plotDF <- rbind(rsDF, eucDF)
    plotDF <- subset(plotDF, CO2 != "pct")
    
    
    ### get the dataframes
    plotDF1 <- plotDF[plotDF$CO2 == "aCO2" & plotDF$variable %in%c("ALEAF", "AWOOD", "AFROOT", "AOTHER"), ]
    plotDF2 <- plotDF[plotDF$CO2 == "aCO2" & plotDF$variable %in%c("tau_LEAF", "tau_FROOT", #"tau_MYCO", 
                                                                   "tau_CFLITA", "tau_CFLITB", #"tau_MICR", 
                                                                   "tau_SOIL"), ]
    
    plotDF3 <- plotDF[plotDF$CO2 == "eCO2" & plotDF$variable %in%c("ALEAF", "AWOOD", "AFROOT", "AOTHER"), ]
    plotDF4 <- plotDF[plotDF$CO2 == "eCO2" & plotDF$variable %in%c("tau_LEAF", "tau_FROOT", #"tau_MYCO", 
                                                                   "tau_CFLITA", "tau_CFLITB", #"tau_MICR", 
                                                                   "tau_SOIL"), ]
    
    plotDF2$value[plotDF2$variable=="tau_SOIL"] <- plotDF2$value[plotDF2$variable=="tau_SOIL"] * 10
    plotDF4$value[plotDF4$variable=="tau_SOIL"] <- plotDF4$value[plotDF4$variable=="tau_SOIL"] * 10
    
    
    ### make the bar plot
    p1 <- ggplot(plotDF1,
                 aes(x=variable, y=value, fill=Source)) + 
        geom_point(aes(x=variable, y=value, fill=Source), 
                   size=4, shape=21,position = position_dodge(0.6))+
        geom_errorbar(aes(x=variable, ymin=value-sd, ymax=value+sd), 
                   position = position_dodge(0.6), width=0.2)+
        xlab("") + ylab(expression(aCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              #axis.text.x = element_blank(),
              axis.text.x = element_text(size=14),
              axis.text.y=element_text(size=14),
              axis.title.y=element_text(size=16),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none",
              plot.title = element_text(hjust = 0.5),
              axis.title = element_text(size = 20, face="bold"))+
        scale_x_discrete("",  
                         limits=c("ALEAF",
                                  "AWOOD",
                                  "AFROOT",
                                  "AOTHER"),
                         labels=c("Leaf",
                                  "Wood",
                                  "Froot",
                                  "Other"))+
        scale_y_continuous(limits=c(-0.02, 0.8), 
                           breaks=c(0.0, 0.2, 0.4, 0.6, 0.8),
                           labels=c(0.0, 0.2, 0.4, 0.6, 0.8))+
        ggtitle("Allocation coefficients")
    
    p3 <- ggplot(plotDF3,
                 aes(x=variable, y=value, fill=Source)) + 
        geom_point(aes(x=variable, y=value, fill=Source), 
                   size=4, shape=21,position = position_dodge(0.6))+
        geom_errorbar(aes(x=variable, ymin=value-sd, ymax=value+sd), 
                      position = position_dodge(0.6), width=0.2)+
        xlab("") + ylab(expression(eCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              #axis.text.x = element_blank(),
              axis.text.x = element_text(size=14),
              axis.text.y=element_text(size=14),
              axis.title.y=element_text(size=16),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none",
              plot.title = element_text(hjust = 0.5),
              axis.title = element_text(size = 20, face="bold"))+
        scale_x_discrete("",  
                         limits=c("ALEAF",
                                  "AWOOD",
                                  "AFROOT",
                                  "AOTHER"),
                         labels=c("Leaf",
                                  "Wood",
                                  "Froot",
                                  "Other"))+
        scale_y_continuous(limits=c(-0.02, 0.8), 
                           breaks=c(0.0, 0.2, 0.4, 0.6, 0.8),
                           labels=c(0.0, 0.2, 0.4, 0.6, 0.8))
    
    
    p2 <- ggplot(plotDF2,
                 aes(x=variable, y=value, fill=Source)) + 
        geom_point(aes(x=variable, y=value, fill=Source), 
                   size=4, shape=21,position = position_dodge(0.6))+
        geom_errorbar(aes(x=variable, ymin=value-sd, ymax=value+sd), 
                      position = position_dodge(0.6), width=0.2)+
        xlab("") + ylab(expression(aCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_text(size=14),
              axis.text.y=element_text(size=14),
              axis.title.y=element_blank(),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none",
              plot.title = element_text(hjust = 0.5),
              axis.title = element_text(size = 20, face="bold"))+
        scale_x_discrete("",  
                         limits=c("tau_LEAF",
                                  "tau_FROOT",
                                  "tau_CFLITA",
                                  "tau_CFLITB",
                                  "tau_SOIL"),
                         labels=c("Leaf",
                                  "Froot",
                                  "Aglit",
                                  "Bglit",
                                  "Soil*10"))+
        scale_y_continuous(limits=c(0, 5), 
                           breaks=c(0, 2.5, 5.0),
                           labels=c(0, 2.5, 5.0))+
        ggtitle(expression("Turnover rates ( " * yr^-1 * " )"))
    

    p4 <- ggplot(plotDF4,
                 aes(x=variable, y=value, fill=Source)) + 
        geom_point(aes(x=variable, y=value, fill=Source), 
                   size=4, shape=21,position = position_dodge(0.6))+
        geom_errorbar(aes(x=variable, ymin=value-sd, ymax=value+sd), 
                      position = position_dodge(0.6), width=0.2)+
        xlab("") + ylab(expression(eCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_text(size=14),
              axis.text.y=element_text(size=14),
              axis.title.y=element_blank(),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none",
              plot.title = element_text(hjust = 0.5),
              axis.title = element_text(size = 20, face="bold"))+
        scale_x_discrete("",  
                         limits=c("tau_LEAF",
                                  "tau_FROOT",
                                  "tau_CFLITA",
                                  "tau_CFLITB",
                                  "tau_SOIL"),
                         labels=c("Leaf",
                                  "Froot",
                                  "Aglit",
                                  "Bglit",
                                  "Soil*10"))+
        scale_y_continuous(limits=c(0, 5), 
                           breaks=c(0, 2.5, 5.0),
                           labels=c(0, 2.5, 5.0))
    
    
    
    ### combined plots + shared legend
    legend_shared <- get_legend(p1 + theme(legend.position="bottom",
                                           legend.box = 'vertical',
                                           legend.box.just = 'left'))
    
    combined_plots <- plot_grid(p1, p2, p3, p4,
                                labels="AUTO", ncol=2, align="v", axis = "l")
    
    
    ### output
    pdf("output/model_data_comparison.pdf", width=8, height=10)
    plot_grid(combined_plots, legend_shared, ncol=1, rel_heights=c(1,0.1))
    dev.off()    
    
    

}