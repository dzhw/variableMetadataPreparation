  <!-- badges: start -->
  [![Build Status](https://github.com/dzhw/variableMetadataPreparation/workflows/Build%20and%20Deploy/badge.svg)](https://github.com/dzhw/variableMetadataPreparation/actions)
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
```r
install.packages("devtools", dependencies = TRUE)
devtools::install_github("dzhw/variableMetadataPreparation")
```

After setting up devtools you can install all required R packages with

```bash
R -e 'devtools::install_deps(dep = T)'
```

You can build the package on you local machine with

```bash
R CMD build .
```

Before pushing to Github (and thus kicking of CI) you should run

```bash
R CMD check *tar.gz --no-manual
```
# Deployment

## Copy build artifacts into "geschützter Bereich"

First you should clear the following directories:
1. `Q:\Variablenexport\variableMetadataPreparation\miniCRAN`
2. `Q:\Variablenexport\variableMetadataPreparation\bin`
3. `Q:\Variablenexport\variableMetadataPreparation\library`

[Github actions](https://github.com/dzhw/variableMetadataPreparation/actions) currently creates a `bin-and-miniCRAN.zip`. This archive needs to be extracted in the "geschützter Bereich" to `Q:\Variablenexport\variableMetadataPreparation`.

## Installation

Run the R-script `install_packages.R` under `Q:\Variablenexport\variableMetadataPreparation\bin`

```
Rscript install_packages.R
```

The bin folder contains a template `.bat` (`variablesToJson.bat.tmpl`) which needs to be copied to and adjusted by every project.

# Having trouble?

Please file an issue in our [issue tracker](https://github.com/dzhw/metadatamanagement/issues)
