context("Variable Metadata Generation (Main)")

library(variableMetadataExtractor)

test_that("main script without option parser runs", {
  variable_metadata_generation(
    here("data-raw/excel"),
    here("data-raw/stata"),
    here("data-raw/excel/conditions.xlsx"),
    here("output"),
    "pid, id"
  )
})
