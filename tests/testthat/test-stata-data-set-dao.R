context("Stata Data Set")

library(variableMetadataExtractor)

ds3_dao <- NULL

setup({
  ds3_dao <<- StataDataSetDao$new(
    system.file("extdata/stata/ds3.dta",
      package = "variableMetadataExtractor"))
})

teardown({
  ds3_dao <<- NULL
})

test_that("total absolute frequency is correct", {
  distribution <- ds3_dao$get_distribution(
    "adem01a",
    scale_level_en = "nominal", access_ways = c("hurz")
  )
  expect_identical(distribution$get_total_absolute_frequency(),
    jsonlite::unbox(1622))
})
