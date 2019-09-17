context("Missings Excel File")

library(variableMetadataPreparation) #nolint

missing_conditions_excel_dao <- NULL

setup({
  missing_conditions_excel_dao <<- MissingConditionsExcelDao$new(
    system.file("extdata/excel/conditions.xlsx",
      package = "variableMetadataPreparation")
  )
})

teardown({
  missing_conditions_excel_dao <<- NULL
})

test_that("numeric missing condition is correct", {
  numeric_missing_condition <- missing_conditions_excel_dao$get_missing_conditions_numeric() #nolint
  expect_identical(numeric_missing_condition, "values <= -800")
})
