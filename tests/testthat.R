library(testthat)
library(here)
# Needed for subshells openend in tests, and does no harm otherwise.
# See <https://github.com/hadley/testthat/issues/144> for details.
Sys.setenv(R_TESTS = "")
options(testthat.use_colours = TRUE)
setwd(here::here())
test_dir("./tests/testthat")
