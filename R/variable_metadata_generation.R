#' Create variable metadata json files for the mdm
#' @param path_to_excel_directory the path to the excel directory containing
#'    vimport_ds1.xlsx, vimport_ds2.xlsx, ...
#' @param path_to_stata_directory the path to the stata directory containing
#'    ds1.dta, ds2.dta, ...
#' @param missing_conditions_file the path to the missing conditions file
#' @param path_to_output_directory where the output jsons should be stored
#' @param variables_no_distribution variables which should not get summary statistics (e.g. pid)
#' @example variable_metadata_generation(path_to_excel_directory =
#'    system.file("extdata/excel", variableMetadataGeneration),
#'    path_to_stata_directory = system.file("extdata/stata",
#'      variableMetadataGeneration),
#'    missing_conditions_file = system.file("extdata/excel/conditions.xlsx",
#'      variableMetadataGeneration),
#'    path_to_output_directory = "path_to_output_directory",
#'    variables_no_distribution = "pid")
#' @export

variable_metadata_generation <- function(path_to_excel_directory,
  path_to_stata_directory, missing_conditions_file,
  path_to_output_directory, variables_no_distribution) {
  missingConditionsExcelDao <- MissingConditionsExcelDao$new(missing_conditions_file) #nolint

  cat(paste0("exceldirectory:", path_to_excel_directory, "\n"))
  cat(paste0("statadirectory:", path_to_stata_directory, "\n"))
  cat(paste0("outputdirectory:", path_to_output_directory, "\n"))
  cat(paste0("missing-conditions-numeric:",
    missingConditionsExcelDao$get_missing_conditions_numeric(), #nolint
    "\n"
    ))
  cat(paste0("missing-conditions-string:",
    missingConditionsExcelDao$get_missing_conditions_string(), #nolint
    "\n"
  ))
  cat(paste0("missing-conditions-date:",
    missingConditionsExcelDao$get_missing_conditions_date(), #nolint
    "\n"
  ))
  cat(paste0("variables-no-distribution:", variables_no_distribution, "\n"))
  stata_files <- list.files(path_to_stata_directory, pattern = "*.dta")

  create_export_directories(
    path_to_json_directory = path_to_output_directory,
    stata_files = stata_files
  )
  variables_no_distribution <- create_vector(variables_no_distribution) # nolint
  for (data_set in stata_files) {
    data_set_number <- sub("\\.dta$", "", data_set)
    variable_excel_dao <- VariableExcelDao$new(paste0(
      path_to_excel_directory, "/vimport_", #nolint
      data_set_number, ".xlsx"
    ))
    related_question_excel_dao <- RelatedQuestionExcelDao$new(
      paste0(path_to_excel_directory, "/vimport_", data_set_number, ".xlsx") #nolint
    )
    stata_data_set_dao <- StataDataSetDao$new(
      paste0(path_to_stata_directory, "/", data_set),
      missingConditionsExcelDao$get_missing_conditions_string(), #nolint
      missingConditionsExcelDao$get_missing_conditions_date(), #nolint
      missingConditionsExcelDao$get_missing_conditions_numeric(), #nolint
      variables_no_distribution
    )
    cat(paste0(
      "Assembling variables and exporting them to json for data set ",
      data_set_number, ".\n"
    ))
    for (variable_name in variable_excel_dao$get_variable_names()) {
      variable <- variable_excel_dao$get_variable(variable_name)
      variable$set_related_questions(
        related_question_excel_dao$get_related_questions(variable_name)
      )
      variable$set_storage_type(
        stata_data_set_dao$get_storage_type(variable_name)
      )
      variable$set_data_type(stata_data_set_dao$get_data_type(variable_name))
      variable$set_label(stata_data_set_dao$get_variable_label(variable_name))
      variable$set_index_in_data_set(
        stata_data_set_dao$get_index_in_data_set(variable_name)
      )
      variable$set_distribution(
        stata_data_set_dao$get_distribution(
          variable_name,
          variable$get_scale_level()$get_en(), variable$get_access_ways()
        )
      )
      variable$to_json(paste0(
        path_to_output_directory, "/", data_set_number, "/",
        variable_name, ".json"
      ))
    }
  }
}
