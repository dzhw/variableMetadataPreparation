context("Stata Data Set")

modules::import("../../R/daos/stata/StataDataSetDao", attach = TRUE)

ds6_dao <- NULL

setup({
  ds6_dao <<- StataDataSetDao$new(here("data-raw/stata/ds6.dta"))
})

teardown({
  ds6_dao <<- NULL
})

test_that("total absolute frequency is correct", {
  distribution <- ds6_dao$get_distribution(
    "adem01a",
    scale_level_en = "nominal", access_ways = c("hurz")
  )
  expect_identical(distribution$get_total_absolute_frequency(), unbox(1622))
})
