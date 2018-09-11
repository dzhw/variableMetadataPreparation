create_vector <- function(comma_seperated_string) {
  x_list <- unlist(strsplit(comma_seperated_string, ",", fixed = TRUE))
  if (all(is.na(x_list) == FALSE)) {
    return(x_list)
  }
}
