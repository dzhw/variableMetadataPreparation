FilterDetails <- R6::R6Class("FilterDetails", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    initialize = function() {
      private$description <- I18nString$new()
    },
    get_description = function() {
      return(private$description)
    },
    set_description = function(description) {
      private$description <- description
    },
    get_expression = function() {
      return(private$expression)
    },
    set_expression = function(expression) {
      private$expression <- jsonlite::unbox(expression)
    },
    get_expression_language = function() {
      return(private$expressionLanguage)
    },
    set_expression_language = function(expression_language) {
      private$expressionLanguage <- jsonlite::unbox(expression_language) # nolint
    }
  ),
  private = list(
    expression = NULL,
    description = NULL,
    expressionLanguage = NULL
  )
)
