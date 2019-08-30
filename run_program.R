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
traceability_framework_EucFACE_Medlyn_framework_aCO2()

## we need to fit the data to get the parameters so that Rhet matches observation. 
## some restructuring is still needed. 



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
