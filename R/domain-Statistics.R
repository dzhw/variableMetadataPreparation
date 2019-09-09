Statistics <- R6::R6Class("Statistics", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    get_mean_value = function() {
      return(private$meanValue) #nolint
    },
    set_mean_value = function(mean_value) {
      private$meanValue <- jsonlite::unbox(mean_value) # nolint
    },
    get_minimum = function() {
      return(private$minimum)
    },
    set_minimum = function(minimum) {
      private$minimum <- jsonlite::unbox(minimum)
    },
    get_maximum = function() {
      return(private$maximum)
    },
    set_maximum = function(maximum) {
      private$maximum <- jsonlite::unbox(maximum)
    },
    get_skewness = function() {
      return(private$skewness)
    },
    set_skewness = function(skewness) {
      private$skewness <- jsonlite::unbox(skewness)
    },
    get_kurtosis = function() {
      return(private$kurtosis)
    },
    set_kurtosis = function(kurtosis) {
      private$kurtosis <- jsonlite::unbox(kurtosis)
    },
    get_median = function() {
      return(private$median)
    },
    set_median = function(median) {
      private$median <- jsonlite::unbox(median)
    },
    get_standard_deviation = function() {
      return(private$standardDeviation) #nolint
    },
    set_standard_deviation = function(standard_deviation) {
      private$standardDeviation <- jsonlite::unbox(standard_deviation) # nolint
    },
    get_first_quartile = function() {
      return(private$firstQuartile) #nolint
    },
    set_first_quartile = function(first_quartile) {
      private$firstQuartile <- jsonlite::unbox(first_quartile) # nolint
    },
    get_third_quartile = function() {
      return(private$thirdQuartile) #nolint
    },
    set_third_quartile = function(third_quartile) {
      private$thirdQuartile <- jsonlite::unbox(third_quartile) # nolint
    },
    get_low_whisker = function() {
      return(private$lowWhisker) #nolint
    },
    set_low_whisker = function(low_whisker) {
      private$lowWhisker <- jsonlite::unbox(low_whisker) # nolint
    },
    get_high_whisker = function() {
      return(private$highWhisker) #nolint
    },
    set_high_whisker = function(high_whisker) {
      private$highWhisker <- jsonlite::unbox(high_whisker) # nolint
    },
    get_mode = function() {
      return(private$mode)
    },
    set_mode = function(mode) {
      private$mode <- jsonlite::unbox(mode)
    },
    get_mean_deviation = function() {
      return(private$meanDeviation) #nolint
    },
    set_mean_deviation = function(mean_deviation) {
      private$meanDeviation <- jsonlite::unbox(mean_deviation) # nolint
    }
  ),
  private = list(
    meanValue = NULL,
    minimum = NULL,
    maximum = NULL,
    skewness = NULL,
    kurtosis = NULL,
    median = NULL,
    standardDeviation = NULL,
    firstQuartile = NULL,
    thirdQuartile = NULL,
    lowWhisker = NULL,
    highWhisker = NULL,
    mode = NULL,
    meanDeviation = NULL
  )
)
