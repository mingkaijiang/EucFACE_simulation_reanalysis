##### This is the code repository for re-analyzing EucFACE modeling simulation output
#####
#####
##### Mingkai Jiang
##### m.jiang@westernsydney.edu.au

########################################################################################
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


