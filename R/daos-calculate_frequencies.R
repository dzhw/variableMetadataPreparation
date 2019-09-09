calculate_frequencies <- function(original_values, valid_values)
  UseMethod("calculate_frequencies")

# default
calculate_frequencies.default <- function(original_values, valid_values) {
  out <- Distribution$new()
  table_values <- table(original_values)
  table_valid_responses <- table(valid_values)
  out$set_total_absolute_frequency(round(sum(table_values), 2))
  out$set_total_valid_absolute_frequency(round(sum(table_valid_responses), 2))
  out$set_total_valid_relative_frequency(round((out$get_total_valid_absolute_frequency() /
      out$get_total_absolute_frequency()) * 100, 2))
  return(out)
}
