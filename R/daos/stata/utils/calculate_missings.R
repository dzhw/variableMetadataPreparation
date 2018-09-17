modules::import_package(package = "stringr", attach = TRUE)

modules::import("/R/domain/Missing", attach = TRUE)

calculate_missings <- function(original_values, missing_values, value_labels)
  UseMethod("calculate_missings")

# default
calculate_missings.default <- function(original_values, missing_values, value_labels) {
  warning(paste0(
    "calculate_missings() does not know how to handle",
    "objects of class ", class(original_values), ". "
  ))
}

# numeric
calculate_missings.numeric <- function(original_values, missing_values, value_labels) {
  out <- NULL
  table_values <- table(original_values)
  table_missings <- table(missing_values)
  if (length(table_missings) != 0) {
    for (i in 1:length(table_missings)) {
      missing <- Missing$new()
      missing$set_code(as.numeric(names(table_missings)[i]))
      missing$set_absolute_frequency(table_missings[i])
      missing$set_relative_frequency(round((table_missings[i] / sum(table_values)) * 100, 2))
      missing$get_label()$set_de(ifelse(as.numeric(
        names(table_missings[i])) %in% value_labels$de,
        names(value_labels$de[which(
          value_labels$de == as.numeric(names(table_missings[i])))]), NA))
      missing$get_label()$set_en(ifelse(as.numeric(
        names(table_missings[i])) %in% value_labels$en,
        names(value_labels$en[which(
          value_labels$en == as.numeric(names(table_missings[i])))]), NA))
      out[[i]] <- missing
    }
  }
  return(out)
}

# string
calculate_missings.string <- function(original_values, missing_values, value_labels) {
  out <- NULL
  table_values <- table(original_values)
  table_missings <- table(missing_values)
  if (length(table_missings) != 0) {
    for (i in 1:length(table_missings)) {
      missing <- Missing$new()
      missing$set_code(as.numeric(
        str_extract(names(table_missings)[i], "\\-[0-9]+")
      ))
      missing$set_absolute_frequency(table_missings[i])
      missing$set_relative_frequency(round((table_missings[i] / sum(table_values)) * 100, 2))
      missing$get_label()$set_de(as.character(str_extract(
        names(table_missings)[i], "[:alpha:]+.*"
      )))
      missing$get_label()$set_en(NA)
      out[[i]] <- missing
    }
  }
  return(out)
}
