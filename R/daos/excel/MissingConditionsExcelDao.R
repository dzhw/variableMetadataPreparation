suppressPackageStartupMessages(suppressWarnings(library(here)))

script_basename <- here("R")
source(paste0(script_basename, "/daos/excel/BaseExcelDao.R"))

MissingConditionsExcelDao <- R6Class("MissingConditionsExcelDao", #nolint
  inherit = BaseExcelDao,
  private = list(
    missing_conditions_string = c("values %in% \"-966 nicht bestimmbar\"",
                                           "values %in% \"-968 unplausibler Wert\"",
                                           "values %in% \"-995 keine Teilnahme (Panel)\"",
                                           "values %in% \"-998 keine Angabe\"",
                                           "values %in% \"-989 filterbedingt fehlend\""),
    missing_conditions_numeric = "values <= -800",
    create_missing_conditions_numeric = function(sheet) {
      output <- vector(length = nrow(sheet), mode = "character")
      for (i in 1:nrow(sheet)) {
        if (sheet$operator[i] == "equal to") {
          output[i] <- paste0("values %in% ", sheet$value[i])
        }
        else if (sheet$operator[i] == "not equal to") {
          output[i] <- paste0("!(values %in% ", sheet$value[i], ")")
        }
        else if (sheet$operator[i] == "less than") {
          output[i] <- paste0("values < ", sheet$value[i])
        }
        else if (sheet$operator[i] == "greater than") {
          output[i] <- paste0("values > ", sheet$value[i])
        }
        else if (sheet$operator[i] == "less than or equal to") {
          output[i] <- paste0("values <= ", sheet$value[i])
        }
        else if (sheet$operator[i] == "greater than or equal to") {
          output[i] <- paste0("values >= ", sheet$value[i])
        }
      }
      return(output)
    },
    create_missing_conditions_string = function(sheet) {
      output <- vector(length = nrow(sheet), mode = "character")
      for (i in 1:nrow(sheet)) {
        if (sheet$operator[i] == "equal to") {
          output[i] <- paste0("values %in% \"", sheet$value[i], "\"")
        }
        else if (sheet$operator[i] == "not equal to") {
          output[i] <- paste0("!(values %in% \"", sheet$value[i], "\")")
        }
      }
      return(output)
    }
  ),
  public = list(
    initialize = function(excel_location = NA) {
      if (!is.na(excel_location)) {
        cat(paste0("Read excel file \"", excel_location, "\" sheet \"missingConditionNumeric\"\n"))
        excel_sheet <- private$read_and_trim_excel_sheet(excel_location, "missingConditionNumeric")
        private$missing_conditions_numeric <- private$create_missing_conditions_numeric(excel_sheet)
        cat(paste0("Read excel file \"", excel_location, "\" sheet \"missingConditionString\"\n"))
        excel_sheet <- private$read_and_trim_excel_sheet(excel_location, "missingConditionString")
        private$missing_conditions_string <- private$create_missing_conditions_string(excel_sheet)
      }
    },
    get_missing_conditions_string = function() {
      return(private$missing_conditions_string)
    },
    get_missing_conditions_numeric = function() {
      return(private$missing_conditions_numeric)
    }
  )
)
