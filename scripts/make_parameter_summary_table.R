make_parameter_summary_table <- function() {
    r1 <- predict_final_output_2(pChain = pChain.aCO2, 
                                 obs = obsDF[4,],
                                 return.option = "Return final parameter")
    
    r2 <- predict_final_output_2(pChain = pChain.eCO2, 
                                 obs = eco2DF[4,],
                                 return.option = "Return final parameter")
    
    
    out <- rbind(r1, r2)
    out$Trt <- c("aCO2", "eCO2")
    
    write.csv(out, "output/parameter_summary_table.csv", row.names=F)
    
    print(out)
    
}