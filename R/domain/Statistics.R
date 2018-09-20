options(import.path = here::here("R/domain"))

modules::import("JSONSerializableDomainObject", attach = TRUE)

Statistics <- R6Class("Statistics", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    get_mean_value = function() {
      return(private$meanValue)
    },
    set_mean_value = function(mean_value) {
      private$meanValue <- unbox(mean_value) # nolint
    },
    get_minimum = function() {
      return(private$minimum)
    },
    set_minimum = function(minimum) {
      private$minimum <- unbox(minimum)
    },
    get_maximum = function() {
      return(private$maximum)
    },
    set_maximum = function(maximum) {
      private$maximum <- unbox(maximum)
    },
    get_skewness = function() {
      return(private$skewness)
    },
    set_skewness = function(skewness) {
      private$skewness <- unbox(skewness)
    },
    get_kurtosis = function() {
      return(private$kurtosis)
    },
    set_kurtosis = function(kurtosis) {
      private$kurtosis <- unbox(kurtosis)
    },
    get_median = function() {
      return(private$median)
    },
    set_median = function(median) {
      private$median <- unbox(median)
    },
    get_standard_deviation = function() {
      return(private$standardDeviation)
    },
    set_standard_deviation = function(standard_deviation) {
      private$standardDeviation <- unbox(standard_deviation) # nolint
    },
    get_first_quartile = function() {
      return(private$firstQuartile)
    },
    set_first_quartile = function(first_quartile) {
      private$firstQuartile <- unbox(first_quartile) # nolint
    },
    get_third_quartile = function() {
      return(private$thirdQuartile)
    },
    set_third_quartile = function(third_quartile) {
      private$thirdQuartile <- unbox(third_quartile) # nolint
    },
    get_low_whisker = function() {
      return(private$lowWhisker)
    },
    set_low_whisker = function(low_whisker) {
      private$lowWhisker <- unbox(low_whisker) # nolint
    },
    get_high_whisker = function() {
      return(private$highWhisker)
    },
    set_high_whisker = function(high_whisker) {
      private$highWhisker <- unbox(high_whisker) # nolint
    },
    get_mode = function() {
      return(private$mode)
    },
    set_mode = function(mode) {
      private$mode <- unbox(mode)
    },
    get_mean_deviation = function() {
      return(private$meanDeviation)
    },
    set_mean_deviation = function(mean_deviation) {
      private$meanDeviation <- unbox(mean_deviation) # nolint
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
