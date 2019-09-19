  <!-- badges: start -->
  [![Travis build status](https://travis-ci.org/dzhw/variableMetadataPreparation.svg?branch=master)](https://travis-ci.org/dzhw/variableMetadataPreparation)
  [![Codecov test coverage](https://codecov.io/gh/dzhw/variableMetadataPreparation/branch/master/graph/badge.svg)](https://codecov.io/gh/dzhw/variableMetadataPreparation?branch=master)
  [![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable) [![Documentation](https://img.shields.io/badge/documentation--brightgreen)](https://dzhw.github.io/variableMetadataPreparation/)
  <!-- badges: end -->

# [variableMetadataPreparation](https://dzhw.github.io/variableMetadataPreparation/)
This repository contains [R](https://www.r-project.org/about.html) code which 
extracts metadata for variables from STATA (dta) files for the [MDM](https://metadata.fdz.dzhw.eu)
of the research data center of the dzhw. If you do not work for the research 
data center of the dzhw, this package will probably be only useful for learning 
purposes, as it is specifically designed to help with our internal processes.
You find the workflow to use it [here](file:///home/birkelbach/git/variableMetadataPreparation/docs/articles/How_to_use_variableMetadataPreparation.html).

# Development

Developers need to setup the R devtools on their machine.
``` r
install.packages("devtools", dependencies = TRUE)
devtools::install_github("dzhw/variableMetadataPreparation")
```

After setting up devtools you can install all required R packages with

``` bash
R -e 'devtools::install_deps(dep = T)'
```

You can build the package on you local machine with

``` bash
R CMD build .
```

Before pushing to Github (and thus kicking of CI) you should run

``` bash
R CMD check *tar.gz
```
# Deployment

## Creating the miniCRAN repository

In order to create the miniCRAN repository, please use the 
`create_minicran(minicran_path = "path_where_the_miniCRAN_directory_will_be", r_version = "3.5")` 
function found in `/bin/create_minicran.R`. The current R version in the secured
area is 3.5. The resulting minicran directory is supposed to be zipped.
The transfer directory is `smb://faust/gpd-transfer/username/username_out` and 
you find the zipped file in `Z://username/In_username`.
The zip file should go in `Q://Variablenexport/miniCRAN_VariableMetadataPreparation`. 
If at some point the transfer does not work properly, try splitting up the zip 
files to chunks of `<100mb`.

`variableMetadataPreparation` is to be installed in the library `Q://Variablenexport/variableMetadataPreparation_productive/library` and `options_parser.R` is 
supposed to be stored in `Q://Variablenexport/variableMetadataPreparation_productive/R`.

## Checking the package and creating binaries on windows

Run `rhub::check(platform="windows-x86_64-oldrel", email = "insertyouremail")`. 
You'll get an email where the windows binary of the build process is at.
Transfer the file just like you did with `miniCRAN` and store it 
here: `Q://Variablenexport/variableMetadataPreparation_productive/`

## Installation

Open an `R` session at `Q://Variablenexport/variableMetadataPreparation`, adjust the verison of `variableMetadataPreparation` in the file `install_packages.R` and 
run the command

```
source("./install_packages.R")
```
You're good to go.

# Having trouble?


Please file an issue in our [issue tracker](https://github.com/dzhw/metadatamanagement/issues)
