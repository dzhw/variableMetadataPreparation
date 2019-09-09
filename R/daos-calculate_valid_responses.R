
calculate_valid_responses <- function(original_values, valid_response_values, value_labels)
  UseMethod("calculate_valid_responses")

# default
calculate_valid_responses.default <- function(original_values, valid_response_values, value_labels) {
  warning(paste0(
    "calculate_valid_responses() does not know how to handle",
    "objects of class ", class(original_values), ". "
  ))
}

# numeric
calculate_valid_responses.numeric <- function(original_values, valid_response_values, value_labels) {
  out <- NULL
  table_values <- table(original_values)
  table_valid_responses <- table(valid_response_values)
  if (length(table_valid_responses) != 0) {
    for (i in 1:length(table_valid_responses)) {
      valid_response <- ValidResponse$new()
      valid_response$set_value(format(as.numeric(names(table_valid_responses)[i])))
      valid_response$set_absolute_frequency(round(table_valid_responses[i], 2))
      valid_response$set_relative_frequency(round((table_valid_responses[i] /
          sum(table_values)) * 100, 2))
      valid_response$set_valid_relative_frequency(round((table_valid_responses[i] /
          sum(table_valid_responses)) * 100, 2))
      valid_response$get_label()$set_de(ifelse(as.numeric(
        names(table_valid_responses)[i]
      ) %in% value_labels$de, names(
        value_labels$de[which(
          value_labels$de == names(table_valid_responses)[i]
        )]
      ), NA))
      valid_response$get_label()$set_en(ifelse(as.numeric(
        names(table_valid_responses)[i]
      ) %in% value_labels$en, names(
        value_labels$en[which(
          value_labels$en == names(table_valid_responses)[i]
        )]
      ), NA))
      out[[i]] <- valid_response
    }
  }
  return(out)
}

# string
calculate_valid_responses.string <- function(original_values, valid_response_values, value_labels) {
  out <- NULL
  table_values <- table(original_values)
  table_valid_responses <- table(valid_response_values)
  if (length(table_valid_responses) != 0) {
    for (i in 1:length(table_valid_responses)) {
      valid_response <- ValidResponse$new()
      valid_response$set_value(format(as.character(names(table_valid_responses)[i])))
      valid_response$set_absolute_frequency(round(table_valid_responses[i], 2))
      valid_response$set_relative_frequency(round((table_valid_responses[i] /
          sum(table_values)) * 100, 2))
      valid_response$set_valid_relative_frequency(round((table_valid_responses[i] /
          sum(table_valid_responses)) * 100, 2))
      out[[i]] <- valid_response
    }
  }
  return(out)
}
