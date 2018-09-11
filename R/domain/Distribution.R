suppressPackageStartupMessages(suppressWarnings(library(here)))

script_basename <- here("R")
source(paste0(script_basename, "/domain/JSONSerializableDomainObject.R"))
source(paste0(script_basename, "/domain/Statistics.R"))

Distribution <- R6Class("Distribution", #nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    get_total_absolute_frequency = function() {
      return(private$totalAbsoluteFrequency)
    },
    set_total_absolute_frequency = function(total_absolute_frequency) {
      private$totalAbsoluteFrequency <- unbox(total_absolute_frequency) #nolint
    },
    get_total_valid_absolute_frequency = function() {
      return(private$totalValidAbsoluteFrequency)
    },
    set_total_valid_absolute_frequency = function(total_valid_absolute_frequency) {
      private$totalValidAbsoluteFrequency <- unbox(total_valid_absolute_frequency) #nolint
    },
    get_total_valid_relative_frequency = function() {
      return(private$totalValidRelativeFrequency)
    },
    set_total_valid_relative_frequency = function(total_valid_relative_frequency) {
      private$totalValidRelativeFrequency <- unbox(total_valid_relative_frequency) #nolint
    },
    get_valid_responses = function() {
      return(private$validResponses)
    },
    set_valid_responses = function(valid_responses) {
      private$validResponses <- valid_responses #nolint
    },
    get_missings = function() {
      return(private$missings)
    },
    set_missings = function(missings) {
      private$missings <- missings
    },
    get_statistics = function() {
      return(private$statistics)
    },
    set_statistics = function(statistics) {
      private$statistics <- statistics
    }
  ),
  private = list(
    totalAbsoluteFrequency = NULL,
    totalValidAbsoluteFrequency = NULL,
    totalValidRelativeFrequency = NULL,
    validResponses = NULL,
    missings = NULL,
    statistics = NULL
  )
)
