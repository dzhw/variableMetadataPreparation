options(import.path = here::here("R/domain"))

modules::import("JSONSerializableDomainObject", attach = TRUE)
modules::import("I18nString", attach = TRUE)

GenerationDetails <- R6Class("GenerationDetails", # nolint
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
    get_rule = function() {
      return(private$rule)
    },
    set_rule = function(rule) {
      private$rule <- unbox(rule)
    },
    get_rule_expression_language = function() {
      return(private$ruleExpressionLanguage)
    },
    set_rule_expression_language = function(rule_expression_language) {
      private$ruleExpressionLanguage <- unbox(rule_expression_language) # nolint
    }
  ),
  private = list(
    description = NULL,
    rule = NULL,
    ruleExpressionLanguage = NULL
  )
)
