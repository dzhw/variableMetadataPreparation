context("Variable Excel Sheet")

script_basename <- here("R")
source(paste0(script_basename, "/daos/excel/VariableExcelDao.R"))

variable_excel_dao <- NULL

setup({
  variable_excel_dao <<- VariableExcelDao$new(here("data-raw/excel/vimport_ds3.xlsx"))
})

teardown({
  variable_excel_dao <<- NULL
})

test_that("scale level of pid is correct", {
  variable <- variable_excel_dao$get_variable("pid")
  expect_identical(variable$get_scale_level()$get_de(), unbox("nominal"))
})
