suppressPackageStartupMessages(suppressWarnings(library(here)))

script_basename <- here("R")
source(paste0(script_basename, "/domain/JSONSerializableDomainObject.R"))
source(paste0(script_basename, "/domain/I18nString.R"))

ValidResponse <- R6Class("ValidResponse", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    initialize = function() {
      private$label <- I18nString$new()
    },
    get_value = function() {
      return(private$value)
    },
    set_value = function(value) {
      private$value <- unbox(value)
    },
    get_absolute_frequency = function() {
      return(private$absoluteFrequency)
    },
    set_absolute_frequency = function(absolute_frequency) {
      private$absoluteFrequency <- unbox(absolute_frequency) # nolint
    },
    get_relative_frequency = function() {
      return(private$relativeFrequency)
    },
    set_relative_frequency = function(relative_frequency) {
      private$relativeFrequency <- unbox(relative_frequency) # nolint
    },
    get_valid_relative_frequency = function() {
      return(private$validRelativeFrequency)
    },
    set_valid_relative_frequency = function(valid_relative_frequency) {
      private$validRelativeFrequency <- unbox(valid_relative_frequency) # nolint
    },
    get_label = function() {
      return(private$label)
    },
    set_label = function(label) {
      private$label <- label
    }
  ),
  private = list(
    value = NULL,
    absoluteFrequency = NULL,
    relativeFrequency = NULL,
    validRelativeFrequency = NULL,
    label = NULL
  )
)
