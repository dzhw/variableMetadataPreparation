RelatedQuestionExcelDao <- R6::R6Class("RelatedQuestionExcelDao", # nolint
  inherit = BaseExcelDao,
  private = list(
    related_questions_map = NULL
  ),
  public = list(
    initialize = function(excel_location) {
      private$related_questions_map <- new.env()
      cat(paste0("Read excel file \"", excel_location,
        "\" sheet \"relatedQuestions\"\n"))
      excel_sheet <- private$read_and_trim_excel_sheet(excel_location,
        "relatedQuestions")
      for (i in seq_len(nrow(excel_sheet))) {
        name <- excel_sheet$name[i]
        related_question <- RelatedQuestion$new()
        related_question$set_question_number(
          as.character(excel_sheet$questionNumber[i])) #nolint
        related_question$set_instrument_number(
          as.numeric(excel_sheet$instrumentNumber[i])) #nolint
        related_question$get_related_question_strings()$set_de(
          excel_sheet$relatedQuestionStrings.de[i] #nolint
        )
        related_question$get_related_question_strings()$set_en(
          excel_sheet$relatedQuestionStrings.en[i] #nolint
        )
        private$related_questions_map[[name]] <-
          c(private$related_questions_map[[name]], related_question)
      }
    },
    get_related_questions = function(variable_name) {
      return(private$related_questions_map[[variable_name]])
    }
  )
)
