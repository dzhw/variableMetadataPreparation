
to_character <- function(x) {
  out <- format(x)
  if (out == "NULL") return(NULL)
  return(out)
}

set_nominal_measures <- function(statistics, table_valid_values) {
  out <- statistics
  mode <- names(table_valid_values[which(
    table_valid_values == max(table_valid_values)
  )])
  out$set_mode(to_character(ifelse(length(mode) > 1, "multimodal", mode)))
  return(out)
}

#'@importFrom stats mad
#'@importFrom stats quantile
#'@importFrom stats median
set_ordinal_measures <- function(statistics, valid_values, table_valid_values) {
  out <- set_nominal_measures(statistics, table_valid_values)
  minimum <- min(as.numeric(names(table_valid_values)))
  maximum <- max(as.numeric(names(table_valid_values)))
  first_quartile <- unname(quantile(valid_values, probs = 0.25))
  third_quartile <- unname(quantile(valid_values, probs = 0.75))
  median_value <- median(valid_values)
  mean_deviation <- unname(mad(valid_values))
  out$set_maximum(to_character(maximum))
  out$set_minimum(to_character(minimum))
  out$set_median(to_character(median_value))
  out$set_mean_deviation(mean_deviation)
  out$set_first_quartile(to_character(first_quartile))
  out$set_third_quartile(to_character(third_quartile))
  return(out)
}

#'@importFrom stats sd
set_interval_measures <- function(statistics, valid_values,
  table_valid_values) {
  out <- set_ordinal_measures(statistics, valid_values, table_valid_values)
  out$set_mean_value(mean(valid_values))
  out$set_standard_deviation(sd(valid_values))
  out$set_skewness(moments::skewness(valid_values))
  out$set_kurtosis(moments::kurtosis(valid_values))
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
  warning(paste0(
    "calculate_statistics() does not know how to handle",
    "objects of class ", class(valid_values), ". "
  ))
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

# date
calculate_statistics.date <- function(valid_values) {
  out <- Statistics$new()
  valid_values_numeric <- as.numeric(valid_values)
  table_valid_values_numeric <- table(valid_values_numeric)
  minimum <- min(as.numeric(names(table_valid_values_numeric)))
  maximum <- max(as.numeric(names(table_valid_values_numeric)))
  first_quartile <- unname(quantile(valid_values_numeric, probs = 0.25, na.rm = TRUE))
  third_quartile <- unname(quantile(valid_values_numeric, probs = 0.75, na.rm = TRUE))
  median_value <- median(valid_values_numeric, na.rm = TRUE)
  mode <- lubridate::as_date(as.numeric(names(table_valid_values_numeric[which(
    table_valid_values_numeric == max(table_valid_values_numeric)
  )])))
  out$set_mode(ifelse(length(mode) > 1, "multimodal", to_character(mode)))
  out$set_maximum(to_character(lubridate::as_date(maximum)))
  out$set_minimum(to_character(lubridate::as_date(minimum)))
  out$set_median(to_character(lubridate::as_date(median_value)))
  out$set_first_quartile(to_character(lubridate::as_date(first_quartile)))
  out$set_third_quartile(to_character(lubridate::as_date(third_quartile)))
  return(out)
}


# calculate statistics for numeric variables with scale levels
# nominal, ordinal, ratio, interval
calculate_statistics_numeric <- function(valid_values)
  UseMethod("calculate_statistics_numeric")

# default
calculate_statistics_numeric.default <- function(valid_values) { #nolint
  warning(paste0(
    "calculate_statistics_numeric() does not know how to handle",
    "objects of class ", class(valid_values), ". "
  ))
}

# nominal
calculate_statistics_numeric.nominal <- function(valid_values) { #nolint
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
