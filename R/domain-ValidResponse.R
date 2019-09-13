ValidResponse <- R6::R6Class("ValidResponse", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    initialize = function() {
      private$label <- I18nString$new()
    },
    get_value = function() {
      return(private$value)
    },
    set_value = function(value) {
      private$value <- jsonlite::unbox(value)
    },
    get_absolute_frequency = function() {
      return(private$absoluteFrequency) #nolint
    },
    set_absolute_frequency = function(absolute_frequency) {
      private$absoluteFrequency <- jsonlite::unbox(absolute_frequency) # nolint
    },
    get_relative_frequency = function() {
      return(private$relativeFrequency) #nolint
    },
    set_relative_frequency = function(relative_frequency) {
      private$relativeFrequency <- jsonlite::unbox(relative_frequency) # nolint
    },
    get_valid_relative_frequency = function() {
      return(private$validRelativeFrequency) #nolint
    },
    set_valid_relative_frequency = function(valid_relative_frequency) {
      private$validRelativeFrequency <- jsonlite::unbox(valid_relative_frequency) # nolint
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
