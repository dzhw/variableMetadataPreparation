context("Missings Excel File")

script_basename <- here("R")
source(paste0(script_basename, "/daos/excel/MissingConditionsExcelDao.R"))

missing_conditions_excel_dao <- NULL

setup({
  missing_conditions_excel_dao <<- MissingConditionsExcelDao$new(
    here("data-raw/excel/conditions.xlsx"))
})

teardown({
  missing_conditions_excel_dao <<- NULL
})

test_that("numeric missing condition is correct", {
  numeric_missing_condition <- missing_conditions_excel_dao$get_missing_conditions_numeric()
  expect_identical(numeric_missing_condition, "values <= -800")
})
