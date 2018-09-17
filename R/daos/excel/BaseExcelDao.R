modules::import_package(package = "R6", attach = TRUE)
modules::import_package(package = "readxl", attach = TRUE)
modules::import_package(package = "stringr", attach = TRUE)

modules::import("/R/utils/character_parsing", attach = TRUE)

BaseExcelDao <- R6Class("BaseExcelDao", # nolint
  private = list(
    trim = function(x) {
      trimws(x, which = c("both"))
    },
    delete_na_cols_and_rows = function(excel) {
      na_col <- str_detect(colnames(excel), "NA.")
      na_row <- apply(excel, 1, function(x) all(is.na(x)))
      return(excel[!na_row, !na_col])
    },
    read_and_trim_excel_sheet = function(path, sheet) {
      # read excel
      excel <- read_xlsx(path, sheet = sheet, col_types = "text")
      # remove multiple, leading and trailing whitespaces
      excel <- data.frame(lapply(excel, private$trim), stringsAsFactors = FALSE)
      # delete NA rows and columns
      excel <- private$delete_na_cols_and_rows(excel)
      return(excel)
    },
    create_vector = create_vector,
    trim_vector_cols = function(excel, colnames) {
      cbind(excel[, !(names(excel) %in% colnames)],
        lapply(excel[colnames],
          FUN = function(x) {
            # remove whitespaces
            gsub(pattern = "\\s+", replacement = "", x = x)
            # replace "." by ","
            gsub(pattern = ".", replacement = ",", x = x, fixed = TRUE)
          }
        ),
        stringsAsFactors = FALSE
      )
    }
  )
)
