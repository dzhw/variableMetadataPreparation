suppressPackageStartupMessages(suppressWarnings(library(here)))

script_basename <- here("R")
source(paste0(script_basename, "/domain/JSONSerializableDomainObject.R"))
source(paste0(script_basename, "/domain/I18nString.R"))

Missing <- R6Class("Missing", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    initialize = function() {
      private$label <- I18nString$new()
    },
    get_code = function() {
      return(private$code)
    },
    set_code = function(code) {
      private$code <- unbox(code)
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
    get_label = function() {
      return(private$label)
    },
    set_label = function(label) {
      private$label <- label
    }
  ),
  private = list(
    code = NULL,
    absoluteFrequency = NULL,
    relativeFrequency = NULL,
    label = NULL
  )
)
