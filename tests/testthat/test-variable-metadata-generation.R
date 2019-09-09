context("Variable Metadata Generation (Main)")

library(variableMetadataExtractor)

test_that("main script without option parser runs", {
  variable_metadata_generation(
    system.file("extdata/excel",
      package="variableMetadataExtractor"),
    system.file("extdata/stata",
      package="variableMetadataExtractor"),
    system.file("extdata/excel/conditions.xlsx",
      package="variableMetadataExtractor"),
    tempdir("output"),
    "pid, id"
  )
})
