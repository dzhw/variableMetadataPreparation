#' create_vector
create_vector <- function(comma_separated_string) {
  x_list <- unlist(strsplit(comma_separated_string, ",", fixed = TRUE))
  if (all(is.na(x_list) == FALSE)) {
    return(x_list)
  }
}
