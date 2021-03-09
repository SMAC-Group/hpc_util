# hpc_util

Provide a simple GUI to generate `.sh` scripts to launch tasks on Baobab and Yggdrasil HPC cluster ([HPC@UNIGE](https://www.unige.ch/eresearch/en/services/hpc/)) for researchers at the University of Geneva, Switzerland. 

![:scale 10%](img/hpc_util_screenshort.png)

## Installation and use

### Web access
You can access and use the application directly on your browser via [Shinyapp.io](https://www.shinyapps.io/#). Find the app [here](https://data-analytics-lab.shinyapps.io/golembash/).

### Installing the package with GitHub and `R`

In your `R` console, first install the **remotes** package. Then **hpc_util** with the following
code:

``` r
## if not installed
## install.packages("remotes")

remotes::install_github("SMAC-Group/hpc_util")

library(hpc_util) # load the new package
hpc_util::run_app() # run the app
```
