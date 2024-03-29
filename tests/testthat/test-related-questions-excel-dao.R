context("Related Questions Excel Sheet")

library(variableMetadataPreparation) #nolint

related_questions_excel_dao <- NULL

setup({
  related_questions_excel_dao <<- RelatedQuestionExcelDao$new(
    system.file("extdata/excel/vimport_ds3.xlsx",
      package = "variableMetadataPreparation")
  )
})

teardown({
  related_questions_excel_dao <<- NULL
})

test_that("pid has no related questions", {
  related_questions <- related_questions_excel_dao$get_related_questions("pid")
  expect_identical(related_questions, NULL)
})
