context("Variable Metadata Generation (Main)")

script_basename <- here("R")
source(paste0(script_basename, "/variable_metadata_generation.R"))

test_that("main script without option parser runs", {
  variable_metadata_generation(here("data-raw/excel"),
    here("data-raw/stata"),
    here("data-raw/excel/conditions.xlsx"),
    here("output"),
    "pid, id")
})
