library(testthat)
# Needed for subshells openend in tests, and does no harm otherwise.
# See <https://github.com/hadley/testthat/issues/144> for details.
Sys.setenv(R_TESTS = "")
options(testthat.use_colours = TRUE)
test_dir("./tests/testthat")
