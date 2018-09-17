context("Variable Excel Sheet")

modules::import("../../R/daos/excel/VariableExcelDao", attach = TRUE)

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
