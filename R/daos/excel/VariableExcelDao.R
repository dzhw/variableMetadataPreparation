library(here)
options(import.path = here::here("R/daos/excel"))

modules::import("BaseExcelDao", attach = TRUE)
modules::import("../../domain/Variable", attach = TRUE)

VariableExcelDao <- R6Class("VariableExcelDao", # nolint
  inherit = BaseExcelDao,
  private = list(
    variables_map = NULL
  ),
  public = list(
    initialize = function(excel_location) {
      cat(paste0("Read excel file \"", excel_location, "\" sheet \"variables\"\n"))
      excel_sheet <- private$trim_vector_cols(
        private$read_and_trim_excel_sheet(excel_location, "variables"),
        c("surveyNumbers", "accessWays", "relatedVariables")
      )
      for (i in seq_len(nrow(excel_sheet))) {
        variable <- Variable$new()
        variable$get_scale_level()$set_de(excel_sheet$scaleLevel.de[i])
        variable$get_scale_level()$set_en(excel_sheet$scaleLevel.en[i])
        variable$get_annotations()$set_de(excel_sheet$annotations.de[i])
        variable$get_annotations()$set_en(excel_sheet$annotations.en[i])
        variable$set_access_ways(private$create_vector(excel_sheet$accessWays[i]))
        variable$set_survey_numbers(as.numeric(private$create_vector(excel_sheet$surveyNumbers[i])))
        variable$set_panel_identifier(excel_sheet$panelIdentifier[i])
        variable$set_derived_variables_identifier(excel_sheet$derivedVariablesIdentifier[i])
        variable$set_related_variables(private$create_vector(excel_sheet$relatedVariables[i]))
        variable$set_do_not_display_thousands_separator(
          as.logical(excel_sheet$doNotDisplayThousandsSeparator[i])
        )
        variable$get_filter_details()$get_description()$set_de(
          excel_sheet$filterDetails.description.de[i]
        )
        variable$get_filter_details()$get_description()$set_en(
          excel_sheet$filterDetails.description.en[i]
        )
        variable$get_filter_details()$set_expression(
          excel_sheet$filterDetails.expression[i]
        )
        variable$get_filter_details()$set_expression_language(
          excel_sheet$filterDetails.expressionLanguage[i]
        )
        variable$get_generation_details()$get_description()$set_de(
          excel_sheet$generationDetails.description.de[i]
        )
        variable$get_generation_details()$get_description()$set_en(
          excel_sheet$generationDetails.description.en[i]
        )
        variable$get_generation_details()$set_rule(
          excel_sheet$generationDetails.rule[i]
        )
        variable$get_generation_details()$set_rule_expression_language(
          excel_sheet$generationDetails.ruleExpressionLanguage[i]
        )
        private$variables_map[[excel_sheet$name[i]]] <- variable
      }
    },
    get_variable_names = function() {
      return(ls(private$variables_map))
    },
    get_variable = function(variable_name) {
      return(private$variables_map[[variable_name]])
    }
  )
)
