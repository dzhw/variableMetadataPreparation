suppressPackageStartupMessages(suppressWarnings(library(R6)))
suppressPackageStartupMessages(suppressWarnings(library(jsonlite)))

JSONSerializableDomainObject <- R6Class("JSONSerializableDomainObject", # nolint
  public = list(
    to_json = function(filename) {
      con <- file(filename, open = "w", encoding = "UTF-8")
      write(toJSON(self$to_nested_lists(),
        pretty = TRUE, na = "null", null = "null"), file = con)
      close(con)
    },
    to_nested_lists = function() {
      out <- as.list(private)
      convert_to_list <- function(x) {
        if (inherits(x, "JSONSerializableDomainObject")) {
          out <- x$to_nested_lists()
          return(out)
        } else if (is.list(x)) {
          return(lapply(x, convert_to_list))
        } else if (is.environment(x)) {
          return(lapply(as.list(x), convert_to_list))
        } else {
          return(x)
        }
      }
      out <- lapply(out, convert_to_list)
      return(out)
    }
  )
)
