suppressPackageStartupMessages(suppressWarnings(library(here)))
suppressPackageStartupMessages(suppressWarnings(library(moments)))

script_basename <- here("R")
source(paste0(script_basename, "/domain/Statistics.R"))

to_character = function(x) {
  out <- format(x)
  if (out == "NULL") return(NULL)
    return(out)
}

set_nominal_measures <- function(statistics, table_valid_values) {
  out <- statistics
  mode <- names(table_valid_values[which(
      table_valid_values == max(table_valid_values))])
  out$set_mode(to_character(ifelse(length(mode) > 1, "multimodal", mode)))
  return(out)
}

set_ordinal_measures <- function(statistics, valid_values, table_valid_values) {
  out <- set_nominal_measures(statistics, table_valid_values)
  minimum <- min(as.numeric(names(table_valid_values)))
  maximum <- max(as.numeric(names(table_valid_values)))
  first_quartile <- unname(quantile(valid_values, probs = 0.25))
  third_quartile <- unname(quantile(valid_values, probs = 0.75))
  low_whisker <- first_quartile - 1.5 * (third_quartile - first_quartile)
  low_whisker <- ifelse(low_whisker > minimum, low_whisker, minimum)
  high_whisker <- third_quartile + 1.5 * (third_quartile - first_quartile)
  high_whisker <- ifelse(high_whisker > maximum, maximum, high_whisker)
  median <- median(valid_values)
  mean_deviation <- unname(mad(valid_values))
  out$set_maximum(to_character(maximum))
  out$set_minimum(to_character(minimum))
  out$set_median(to_character(median))
  out$set_mean_deviation(mean_deviation)
  out$set_first_quartile(to_character(first_quartile))
  out$set_third_quartile(to_character(third_quartile))
  out$set_low_whisker(low_whisker)
  out$set_high_whisker(high_whisker)
  return(out)
}

set_interval_measures <- function(statistics, valid_values, table_valid_values) {
  out <- set_ordinal_measures(statistics, valid_values, table_valid_values)
  out$set_mean_value(mean(valid_values))
  out$set_standard_deviation(sd(valid_values))
  out$set_skewness(skewness(valid_values))
  out$set_kurtosis(kurtosis(valid_values))
  return(out)
}

set_ratio_measures <- function(statistics, valid_values, table_valid_values) {
  return(set_interval_measures(statistics, valid_values, table_valid_values))
}

# calculate statistics for variables with data type numeric or string
calculate_statistics <- function(valid_values)
  UseMethod("calculate_statistics")

# default
calculate_statistics.default <- function(valid_values) {
  warning(paste0("calculate_statistics() does not know how to handle",
  "objects of class ", class(valid_values), ". "))
}

# numeric
calculate_statistics.numeric <- function(valid_values) {
  calculate_statistics_numeric(valid_values)
}

# string
calculate_statistics.string <- function(valid_values) {
  out <- Statistics$new()
  table_valid_responses <- table(valid_values)
  if (length(table_valid_responses) != 0) {
    out <- set_nominal_measures(out, table(valid_values))
  }
  return(out)
}

# calculate statistics for numeric variables with scale levels
# nominal, ordinal, ratio, interval
calculate_statistics_numeric <- function(valid_values)
  UseMethod("calculate_statistics_numeric")

# default
calculate_statistics_numeric.default <- function(valid_values) {
  warning(paste0("calculate_statistics_numeric() does not know how to handle",
  "objects of class ", class(valid_values), ". "))
}

# nominal
calculate_statistics_numeric.nominal <- function(valid_values) {
  out <- Statistics$new()
  if (length(valid_values) != 0) {
    out <- set_nominal_measures(out, table(valid_values))
  }
  return(out)
}

# ordinal
calculate_statistics_numeric.ordinal <- function(valid_values) {
  out <- Statistics$new()
  if (length(valid_values) != 0) {
    out <- set_ordinal_measures(out, valid_values, table(valid_values))
  }
  return(out)
}

# interval
calculate_statistics_numeric.interval <- function(valid_values) {
  out <- Statistics$new()
  if (length(valid_values) != 0) {
    out <- set_interval_measures(out, valid_values, table(valid_values))
  }
  return(out)
}

# ratio
calculate_statistics_numeric.ratio <- function(valid_values) {
  out <- Statistics$new()
  if (length(valid_values) != 0) {
    out <- set_ratio_measures(out, valid_values, table(valid_values))
  }
  return(out)
}
