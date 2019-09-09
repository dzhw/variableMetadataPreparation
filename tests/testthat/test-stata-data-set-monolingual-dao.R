context("Stata Data Set")

library(variableMetadataExtractor) #nolint

ds6_dao <- NULL

setup({
  ds6_dao <<- StataDataSetDao$new(system.file("extdata/stata/ds6.dta",
    package = "variableMetadataExtractor"))
})

teardown({
  ds6_dao <<- NULL
})

test_that("total absolute frequency is correct", {
  distribution <- ds6_dao$get_distribution(
    "adem01a",
    scale_level_en = "nominal", access_ways = c("hurz")
  )
  expect_identical(distribution$get_total_absolute_frequency(),
    jsonlite::unbox(1622))
})
