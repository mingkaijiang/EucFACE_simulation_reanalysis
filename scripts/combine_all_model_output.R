combine_all_model_output <- function() {
    
    cablDF$model <- "CABL"
    clm4DF$model <- "CLM4"
    clmpDF$model <- "CLMP"
    gdayDF$model <- "GDAY"
    lpjwDF$model <- "LPJW"
    lpjxDF$model <- "LPJX"
    ocnxDF$model <- "OCNX"
    sdvmDF$model <- "SDVM"
    
    ### we can effectively ignore lpjw because it's not included in the Medlyn 2016 paper
    #outDF <- rbind(cablDF, clm4DF, clmpDF, gdayDF, lpjwDF, lpjxDF, ocnxDF, sdvmDF)
    outDF <- rbind(cablDF, clm4DF, clmpDF, gdayDF, lpjxDF, ocnxDF, sdvmDF)
    

    ### summary of problems:
    ### 1. we need to group coarseroot and stem together,
    ###    but actually we can't, because for models that don't differ croot and froot, froot biomass is huge, 
    ###    so a fraction of that must be croot.
    ### 2. we haven't add delta into the calculations.
    ### 3. LPJW has a very large allocation fraction to other, which includes NTC and reproductive organs! Do we just ignore it?
    ### 4. Csoil and Cwood are large in all model output, and therefore tau soil and tau wood is problematic. 
    ### 5. The simulated GPP is overstorey only (in theory). 
    
    
    ### get the dataframes
    plotDF1 <- outDF[outDF$CO2 == "aCO2",c("ALEAF", "AWOOD", "AFROOT", "ACROOT", "AOTHER", "model")]
    plotDF2 <- outDF[outDF$CO2 == "aCO2",c("tau_LEAF", "tau_WOOD", "tau_FROOT", "tau_CROOT", "tau_SOIL", "model")]
    
    plotDF3 <- outDF[outDF$CO2 == "eCO2",c("ALEAF", "AWOOD", "AFROOT", "ACROOT", "AOTHER", "model")]
    plotDF4 <- outDF[outDF$CO2 == "eCO2",c("tau_LEAF", "tau_WOOD", "tau_FROOT", "tau_CROOT", "tau_SOIL", "model")]
    
    plotDF5 <- outDF[outDF$CO2 == "pct",c("ALEAF", "AWOOD", "AFROOT", "ACROOT", "AOTHER", "model")]
    plotDF6 <- outDF[outDF$CO2 == "pct",c("tau_LEAF", "tau_WOOD", "tau_FROOT", "tau_CROOT", "tau_SOIL", "model")]
    
    ### reshape
    plotDF1 <- melt(plotDF1, id.vars = "model")
    plotDF2 <- melt(plotDF2, id.vars = "model")
    plotDF3 <- melt(plotDF3, id.vars = "model")
    plotDF4 <- melt(plotDF4, id.vars = "model")
    plotDF5 <- melt(plotDF5, id.vars = "model")
    plotDF6 <- melt(plotDF6, id.vars = "model")
    
    ### make the bar plot
    p1 <- ggplot(plotDF1,
                 aes(variable, value)) + 
        geom_boxplot(fill="grey", outlier.size = 0, outlier.color="white") +
        geom_point(mapping=aes(x=variable, y=value, fill=model), 
                   size=4, shape=21,position = position_dodge(0.6))+
        xlab("") + ylab(expression(aCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_blank(),
              axis.text.y=element_text(size=14),
              axis.title.y=element_text(size=16),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none",
              plot.title = element_text(hjust = 0.5),
              axis.title = element_text(size = 20, face="bold"))+
        scale_x_discrete("",  
                         labels=c("Leaf",
                                  "Stem",
                                  "Froot",
                                  "Croot",
                                  "Other"))+
        scale_y_continuous(limits=c(0, 0.8), 
                           breaks=c(0.2, 0.4, 0.6, 0.8),
                           labels=c(0.2, 0.4, 0.6, 0.8))+
        ggtitle("Allocation coeffients")
    
    
    p3 <- ggplot(plotDF3,
                 aes(variable, value)) + 
        geom_boxplot(fill="grey", outlier.size = 0, outlier.color="white") +
        geom_point(mapping=aes(x=variable, y=value, fill=model), 
                   size=4, shape=21,position = position_dodge(0.6))+
        xlab("") + ylab(expression(eCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_blank(),
              axis.text.y=element_text(size=14),
              axis.title.y=element_text(size=16),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none")+
        scale_x_discrete("",  
                         labels=c("Leaf",
                                  "Stem",
                                  "Froot",
                                  "Croot",
                                  "Other"))+
        #theme(legend.justification=c(1,0), legend.position=c(0.9,0.7))+
        scale_y_continuous(limits=c(0, 0.8), 
                           breaks=c(0.2, 0.4, 0.6, 0.8),
                           labels=c(0.2, 0.4, 0.6, 0.8))
    
    
    p5 <- ggplot(plotDF5,
                 aes(variable, value)) + 
        geom_boxplot(fill="grey", outlier.size = 0, outlier.color="white") +
        geom_point(mapping=aes(x=variable, y=value, fill=model), 
                   size=4, shape=21,position = position_dodge(0.6))+
        xlab("") + ylab(expression(eCO[2] * " / " * aCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_text(size=14),
              axis.text.y=element_text(size=14),
              axis.title.y=element_text(size=16),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none")+
        scale_x_discrete("",  
                         labels=c("Leaf",
                                  "Stem",
                                  "Froot",
                                  "Croot",
                                  "Other"))+
        #theme(legend.justification=c(1,0), legend.position=c(0.9,0.7))+
        scale_y_continuous(limits=c(0.8, 1.22))
    
    
    p2 <- ggplot(plotDF2,
                 aes(variable, value)) + 
        geom_boxplot(fill="grey", outlier.size = 0, outlier.color="white") +
        geom_point(mapping=aes(x=variable, y=value, fill=model), 
                   size=4, shape=21,position = position_dodge(0.6))+
        xlab("") + ylab(expression(aCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_blank(),
              axis.text.y=element_blank(),
              axis.title.y=element_blank(),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none",
              plot.title = element_text(hjust = 0.5),
              axis.title = element_text(size = 20, face="bold"))+
        scale_x_discrete("",  
                         labels=c("Leaf",
                                  "Stem",
                                  "Froot",
                                  "Croot",
                                  "Soil"))+
        scale_y_continuous(limits=c(0, 0.8), 
                           breaks=c(0.2, 0.4, 0.6, 0.8),
                           labels=c(0.2, 0.4, 0.6, 0.8))+
        ggtitle(expression("Turnover rates ( " * yr^-1 * " )"))
    
    
    p4 <- ggplot(plotDF4,
                 aes(variable, value)) + 
        geom_boxplot(fill="grey", outlier.size = 0, outlier.color="white") +
        geom_point(mapping=aes(x=variable, y=value, fill=model), 
                   size=4, shape=21,position = position_dodge(0.6))+
        xlab("") + ylab(expression(eCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_blank(),
              axis.text.y=element_blank(),
              axis.title.y=element_blank(),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none")+
        scale_x_discrete("",  
                         labels=c("Leaf",
                                  "Stem",
                                  "Froot",
                                  "Croot",
                                  "Soil"))+
        scale_y_continuous(limits=c(0, 0.8), 
                           breaks=c(0.2, 0.4, 0.6, 0.8),
                           labels=c(0.2, 0.4, 0.6, 0.8))
    
    
    p6 <- ggplot(plotDF6,
                 aes(variable, value)) + 
        geom_boxplot(fill="grey", outlier.size = 0, outlier.color="white") +
        geom_point(mapping=aes(x=variable, y=value, fill=model), 
                   size=4, shape=21,position = position_dodge(0.6))+
        xlab("") + ylab(expression(eCO[2] * " / " * aCO[2]))+
        theme_linedraw() +
        theme(panel.grid.minor=element_blank(),
              axis.title.x = element_text(size=16), 
              axis.text.x = element_text(size=14),
              axis.text.y=element_blank(),
              axis.title.y=element_blank(),
              legend.text=element_text(size=14),
              legend.title=element_text(size=16),
              panel.grid.major=element_blank(),
              legend.position="none")+
        scale_x_discrete("",  
                         labels=c("Leaf",
                                  "Stem",
                                  "Froot",
                                  "Croot",
                                  "Soil"))+
        scale_y_continuous(limits=c(0.8, 1.22))
    
    
    ### combined plots + shared legend
    legend_shared <- get_legend(p1 + theme(legend.position="bottom",
                                           legend.box = 'vertical',
                                           legend.box.just = 'left'))
    
    combined_plots <- plot_grid(p1, p2, p3, p4, p5, p6, 
                                labels="AUTO", ncol=2, align="v", axis = "l")
    
    
    ### output
    pdf("output/all_model_allocation_turnover_plot.pdf", width=8, height=10)
    plot_grid(combined_plots, legend_shared, ncol=1, rel_heights=c(1,0.1))
    dev.off()    
    
    

}