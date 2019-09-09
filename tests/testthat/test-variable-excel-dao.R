context("Variable Excel Sheet")

library(variableMetadataExtractor) #nolint

variable_excel_dao <- NULL

setup({
  variable_excel_dao <<- VariableExcelDao$new(
    system.file("extdata/excel/vimport_ds3.xlsx",
    package = "variableMetadataExtractor"))
})

teardown({
  variable_excel_dao <<- NULL
})

test_that("scale level of pid is correct", {
  variable <- variable_excel_dao$get_variable("pid")
  expect_identical(variable$get_scale_level()$get_de(),
    jsonlite::unbox("nominal"))
})
