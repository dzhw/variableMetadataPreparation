  <!-- badges: start -->
  [![Travis build status](https://travis-ci.org/dzhw/variableMetadataExtractor.svg?branch=master)](https://travis-ci.org/dzhw/variableMetadataExtractor)
  [![Codecov test coverage](https://codecov.io/gh/dzhw/variableMetadataExtractor/branch/master/graph/badge.svg)](https://codecov.io/gh/dzhw/variableMetadataExtractor?branch=master)
  [![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable) [![Documentation](https://img.shields.io/badge/documentation--brightgreen)](https://dzhw.github.io/variableMetadataExtractor/)
  <!-- badges: end -->

# [variableMetadataExtractor](https://dzhw.github.io/variableMetadataExtractor/)
This repository contains [R](https://www.r-project.org/about.html) code which 
extracts metadata for variables from STATA (dta) files for the [MDM](https://metadata.fdz.dzhw.eu)
of the research data center of the dzhw. If you do not work for the research 
data center of the dzhw, this package will probably be only useful for learning 
purposes, as it is specifically designed to help with our internal processes.

# Installation for Users

If you want to play with it on your local machine, you can install it as 
explained below. However, please note that the production system is in the 
secured area ("geschützter Bereich").
You can install the released version of variableMetadataExtractor from [Github](https://github.com/dzhw/variableMetadataExtractor) within your [R](https://www.r-project.org/about.html) session:

``` r
install.packages("remotes", dependencies = TRUE)
remotes::install_github("dzhw/variableMetadataExtractor")
```

# Development

Developers need to setup the R devtools on their machine.
``` r
install.packages("devtools", dependencies = TRUE)
devtools::install_github("dzhw/variableMetadataExtractor")
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

Having trouble?
---------------

Please file an issue in our [issue tracker](https://github.com/dzhw/metadatamanagement/issues)
