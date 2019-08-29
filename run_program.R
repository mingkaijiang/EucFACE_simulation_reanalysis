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

### EucFACE aCO2
### can save either 9 pool structure or 5 pool structure
traceability_framework_EucFACE_aCO2(pool.size = "9")
traceability_framework_EucFACE_aCO2(pool.size = "5")


