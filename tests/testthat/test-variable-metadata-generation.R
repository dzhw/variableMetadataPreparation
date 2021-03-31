context("Variable Metadata Generation (Main)")

library(variableMetadataPreparation) #nolint

test_that("main script without option parser runs", {
  variable_metadata_generation(
    system.file("extdata/excel",
      package = "variableMetadataPreparation"),
    system.file("extdata/stata",
      package = "variableMetadataPreparation"),
    system.file("extdata/excel/conditions.xlsx",
      package = "variableMetadataPreparation"),
    "../../output",
    "pid, id"
  )
})
