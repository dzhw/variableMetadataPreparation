Missing <- R6::R6Class("Missing", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    initialize = function() {
      private$label <- I18nString$new()
    },
    get_code = function() {
      return(private$code)
    },
    set_code = function(code) {
      private$code <- jsonlite::unbox(code)
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
