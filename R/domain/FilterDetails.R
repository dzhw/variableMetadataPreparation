suppressPackageStartupMessages(suppressWarnings(library(here)))

script_basename <- here("R")
source(paste0(script_basename, "/domain/JSONSerializableDomainObject.R"))
source(paste0(script_basename, "/domain/I18nString.R"))

FilterDetails <- R6Class("FilterDetails", #nolint
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
      private$expression <- unbox(expression)
    },
    get_expression_language = function() {
      return(private$expressionLanguage)
    },
    set_expression_language = function(expression_language) {
      private$expressionLanguage <- unbox(expression_language) #nolint
    }
  ),
  private = list(
    expression = NULL,
    description = NULL,
    expressionLanguage = NULL
  )
)
