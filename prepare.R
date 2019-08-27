#### Create output folder
if(!dir.exists("output")) {
    dir.create("output", showWarnings = FALSE)
}

#### Install packages
if(!require(pacman))install.packages("pacman")
pacman::p_load(doBy, 
               ggplot2,
               grid,
               cowplot)  

#### Sourcing all R files in the modules subdirectory
source_basic_scripts <- dir("scripts", pattern="[.]R$", recursive = TRUE, full.names = TRUE)
for(z1 in source_basic_scripts)source(z1)


