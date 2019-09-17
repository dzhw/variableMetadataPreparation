RelatedQuestion <- R6::R6Class("RelatedQuestion", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    initialize = function() {
      private$relatedQuestionStrings <- I18nString$new() # nolint
    },
    get_instrument_number = function() {
      return(private$instrumentNumber) #nolint
    },
    set_instrument_number = function(instrument_number) {
      private$instrumentNumber <- jsonlite::unbox(instrument_number) # nolint
    },
    get_question_number = function() {
      return(private$questionNumber) #nolint
    },
    set_question_number = function(question_number) {
      private$questionNumber <- jsonlite::unbox(question_number) # nolint
    },
    get_related_question_strings = function() {
      return(private$relatedQuestionStrings) #nolint
    },
    set_related_question_strings = function(related_question_strings) {
      private$relatedQuestionStrings <- related_question_strings # nolint
    }
  ),
  private = list(
    instrumentNumber = NULL,
    questionNumber = NULL,
    relatedQuestionStrings = NULL
  )
)
