context("Related Questions Excel Sheet")

script_basename <- here("R")
source(paste0(script_basename, "/daos/excel/RelatedQuestionExcelDao.R"))

related_questions_excel_dao <- NULL

setup({
  related_questions_excel_dao <<- RelatedQuestionExcelDao$new(
    here("data-raw/excel/vimport_ds3.xlsx"))
})

teardown({
  related_questions_excel_dao <<- NULL
})

test_that("pid has no related questions", {
  related_questions <- related_questions_excel_dao$get_related_questions("pid")
  expect_identical(related_questions, NULL)
})
