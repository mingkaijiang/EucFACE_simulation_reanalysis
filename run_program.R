##### This is the code repository for re-analyzing EucFACE modeling simulation output
#####
#####
##### Mingkai Jiang
##### m.jiang@westernsydney.edu.au

########################################################################################
#### clear wk space
rm(list=ls(all=TRUE))

#### prepare
source("prepare.R")

source("initialize_constants.R")


### EucFACE aCO2
params <- c(0.1,          # tau.micr.amb
            0.02,          # tau.soil.amb
            1.55,         # tau.bg.lit.amb
            0.5,          # frac.myco.amb
            0.5,          # frac.ag.amb
            0.5,          # frac.bg.amb
            0.5           # frac.micr.amb
)
params.lower <- c(0.01,
                  0.0001,
                  0.1,
                  0,
                  0,
                  0,
                  0)


params.upper <- c(100.0,
                  1.0,
                  5,
                  1.0,
                  1.0,
                  1.0,
                  1.0)
            

test <- Nelder_Mead(traceability_EucFACE_aCO2, 
                    params, 
                    lower=params.lower, 
                    upper=params.upper,
                    control=list(verbose=1))

### check results
## the minimum function achieved
test$fval

## the value of the parameters providing the minimum
test$par


## check storage and heterotrophic respiration
traceability_EucFACE_aCO2_output(test$par)



###################################### Don't go to here for now!
#### read in different model outputs
cablDF <- read_in_cabl()
clm4DF <- read_in_clm4()
clmpDF <- read_in_clmp()
gdayDF <- read_in_gday()
lpjwDF <- read_in_lpjw()
lpjxDF <- read_in_lpjx()
ocnxDF <- read_in_ocnx()
sdvmDF <- read_in_sdvm()

#### read in EucFACE stuff
eucDF <- read_in_EucFACE_output()

#### combine all model results together
#### save a figure
combine_all_model_output()

#### traceability
### CABLE
### can save either CN model or C only
traceability_framework_CABLE(CN.couple = "C only")

traceability_framework_CABLE(CN.couple = "CN model")
