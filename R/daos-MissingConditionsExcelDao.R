MissingConditionsExcelDao <- R6::R6Class("MissingConditionsExcelDao", # nolint
  inherit = BaseExcelDao,
  private = list(
    missing_conditions_string = c(
      "values %in% \"-966 nicht bestimmbar\"",
      "values %in% \"-968 unplausibler Wert\"",
      "values %in% \"-995 keine Teilnahme (Panel)\"",
      "values %in% \"-998 keine Angabe\"",
      "values %in% \"-989 filterbedingt fehlend\""
    ),
    missing_conditions_date = c(),
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
        } else {
          stop("You need to specify correct missing conditions in the excel sheet missingConditionString. Aborting.") #nolint
        }
      }
      return(output)
    },
    create_missing_conditions_date = function(sheet) {
      output <- vector(length = nrow(sheet) + 1, mode = "character")
      output[1] <- "is.na(values)"
      for (i in seq_len(nrow(sheet))) {
        if (sheet$operator[i] == "equal to") {
          output[i + 1] <- paste0("values %in% lubridate::date(\"", sheet$value[i], "\")")
        }
        else if (sheet$operator[i] == "not equal to") {
          output[i + 1] <- paste0("!(values %in% lubridate::date(\"", sheet$value[i], "\")")
        } else {
          stop("You need to specify correct missing conditions in the excel sheet missingConditionDate. Aborting.") #nolint
        }
      }
      return(output)
    }
  ),
  public = list(
    initialize = function(excel_location = NA) {
      if (!is.na(excel_location)) {
        cat(paste0("Read excel file \"", excel_location,
          "\" sheet \"missingConditionNumeric\"\n"))
        excel_sheet <- private$read_and_trim_excel_sheet(excel_location, #nolint
          "missingConditionNumeric")
        private$missing_conditions_numeric <- private$create_missing_conditions_numeric(excel_sheet) #nolint
        cat(paste0("Read excel file \"", excel_location, #nolint
          "\" sheet \"missingConditionString\"\n"))
        excel_sheet <- private$read_and_trim_excel_sheet(excel_location,
          "missingConditionString")
        private$missing_conditions_string <- private$create_missing_conditions_string(excel_sheet) #nolint
        cat(paste0("Read excel file \"", excel_location, #nolint
          "\" sheet \"missingConditionDate\"\n"))
        excel_sheet <- private$read_and_trim_excel_sheet(excel_location,
          "missingConditionDate")
        private$missing_conditions_date <- private$create_missing_conditions_date(excel_sheet) #nolint
        print(private$missing_conditions_date)
      }
    },
    get_missing_conditions_string = function() {
      return(private$missing_conditions_string)
    },
    get_missing_conditions_numeric = function() {
      return(private$missing_conditions_numeric)
    },
    get_missing_conditions_date = function() {
      return(private$missing_conditions_date)
    }
  )
)
