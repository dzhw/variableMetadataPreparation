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

# Installation for Users

If you want to play with it on your local machine, you can install it as 
explained below. However, please note that the production system is in the 
secured area ("geschützter Bereich").
You can install the released version of variableMetadataPreparation from [Github](https://github.com/dzhw/variableMetadataPreparation) within your [R](https://www.r-project.org/about.html) session:

``` r
install.packages("remotes", dependencies = TRUE)
remotes::install_github("dzhw/variableMetadataPreparation")
```

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

# Creating the miniCRAN repository

In order to create the miniCRAN repository, please use the `create_minicran()` 
function found in `/bin/create_minicran.R`. The current R version in the secured
area is 3.5. The resulting minicran directory is supposed to go in `Q://Variablenexport/miniCRAN_VariableMetadataPreparation`.
variableMetadataPreparation is to be installed in the library `Q://variableMetadataPreparation_productive/library` and `options_parser.R` is 
supposed to be stored in `Q://variableMetadataPreparation_productive/R`.

An example project with appropriate `variablesToJson.bat` can be found in `Q://Variablenexport/example_projects/cmp2014

# Checking on windows

Run `rhub::check(platform="windows-x86_64-oldrel")`.

Having trouble?
---------------

Please file an issue in our [issue tracker](https://github.com/dzhw/metadatamanagement/issues)
