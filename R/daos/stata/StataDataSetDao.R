modules::import_package(package = "readstata13", attach = TRUE)

modules::import("/R/domain/I18nString", attach = TRUE)
modules::import("/R/daos/stata/utils/calculate_valid_responses", attach = TRUE)
modules::import("/R/daos/stata/utils/calculate_missings", attach = TRUE)
modules::import("/R/daos/stata/utils/calculate_statistics", attach = TRUE)
modules::import("/R/daos/stata/utils/calculate_frequencies", attach = TRUE)

StataDataSetDao <- R6Class("StataDataSetDao", # nolint
  private = list(
    original_data_set = NULL,
    variable_names = NULL,
    variable_labels = NULL,
    value_label_container = NULL,
    languages = NULL,
    missing_conditions = NULL,
    label_table = NULL,
    variables_no_distribution = NULL,
    extract_languages = function(ds) {
      # available languages in data set
      private$languages <- get.lang(ds, print = FALSE)
      # languages in some stata data sets are not correctly specified
      lang_try_en <- try(get.label.name(ds, colnames(ds[1]), "en"),
        silent = TRUE
      )
      if (class(lang_try_en) == "try-error") {
        private$languages[["languages"]] <- "de"
      } else {
        lang_try_de <- try(get.label.name(ds, colnames(ds[1]), "de"), silent = TRUE)
        if (class(lang_try_de) == "try-error") {
          private$languages[["languages"]] <- "en"
        }
      }
    },
    extract_variable_labels = function(ds) {
      # get variable labels of variables in stata data set
      private$variable_labels <- list()
      if ("de" %in% private$languages[["languages"]]) {
        varlabel_de <- varlabel(ds, lang = "de")
        if (!is.null(varlabel_de)) {
          private$variable_labels[["de"]] <- varlabel_de
        } else {
          private$variable_labels[["de"]] <- NULL
        }
      } else {
        private$variable_labels[["de"]] <- NULL
      }
      if ("en" %in% private$languages[["languages"]]) {
        private$variable_labels[["en"]] <- varlabel(ds, lang = "en")
        varlabel_en <- varlabel(ds, lang = "en")
        if (!is.null(varlabel_en)) {
          private$variable_labels[["en"]] <- varlabel_en
        } else {
          private$variable_labels[["en"]] <- NULL
        }
      } else {
        private$variable_labels[["en"]] <- NULL
      }
    },
    # get value label container of variables in stata data set
    extract_value_label_container = function(ds) {
      private$value_label_container <- list()
      if (private$languages[["default"]] == "de" &&
        "en" %in% private$languages[["languages"]]) {
        private$value_label_container[["de"]] <- setNames(
          names(attr(ds, "val.labels")),
          attr(ds, "names")
        )
        private$value_label_container[["en"]] <- get.label.name(ds, NULL, "en")
      }
      else if (private$languages[["default"]] == "de"
      && !("en" %in% private$languages[["languages"]])) {
        private$value_label_container[["de"]] <- setNames(names(attr(ds, "val.labels")), attr(ds, "names"))
        private$value_label_container[["en"]] <- NULL
      }
      else if (private$languages[["default"]] == "en" && "de" %in% private$languages[["languages"]]) {
        private$value_label_container[["en"]] <- setNames(names(attr(ds, "val.labels")), attr(ds, "names"))
        private$value_label_container[["de"]] <- get.label.name(ds, NULL, "de")
      }
      else if (private$languages[["default"]] == "en" && (!"de" %in% private$languages[["languages"]])) {
        private$value_label_container[["en"]] <- setNames(names(attr(ds, "val.labels")), attr(ds, "names"))
        private$value_label_container[["de"]] <- NULL
      }
    },
    evaluate_missing_conditions = function(values, condition) {
      temp <- data.frame(matrix(nrow = length(condition), ncol = length(values)))
      for (i in 1:length(condition)) {
        temp[i, ] <- eval(parse(text = condition[i]))
      }
      out <- unname(apply(temp, MARGIN = 2, any))
      return(out)
    }, is_valid_variable_name = function(variable_name) {
      if (variable_name %in% private$variable_names) {
        return(TRUE)
      } else {
        cat(paste0("WARNING: Data Set does not contain variable: \"", variable_name, "\"\n"))
        return(FALSE)
      }
    }
  ),
  public = list(
    initialize = function(data_set_location,
      missing_conditions_string =
        c("values %in% \"-966 nicht bestimmbar\"",
        "values %in% \"-968 unplausibler Wert\"",
        "values %in% \"-995 keine Teilnahme (Panel)\"",
        "values %in% \"-998 keine Angabe\"",
        "values %in% \"-989 filterbedingt fehlend\""),
      missing_conditions_numeric = "values <= -800",
      variables_no_distribution = c("pid","id")) {
      private$missing_conditions[["string"]] = missing_conditions_string
      private$missing_conditions[["numeric"]] = missing_conditions_numeric
      cat(paste0("Read stata file \"", data_set_location, "\n"))
      private$original_data_set <- readstata13::read.dta13(data_set_location,
        convert.factors = FALSE
      )
      private$variable_names <- colnames(private$original_data_set)
      private$extract_languages(private$original_data_set)
      private$extract_variable_labels(private$original_data_set)
      private$extract_value_label_container(private$original_data_set)
      private$label_table <- attr(private$original_data_set, "label.table")
      private$variables_no_distribution <- variables_no_distribution
    },
    get_storage_type = function(variable_name) {
      if (private$is_valid_variable_name(variable_name)) {
        return(typeof(private$original_data_set[[variable_name]]))
      }
    },
    get_data_type = function(variable_name) {
      if (private$is_valid_variable_name(variable_name)) {
        data_type <- I18nString$new()
        data_type$set_de(ifelse(typeof(
          private$original_data_set[[variable_name]]) == "character", "string", "numerisch"))
        data_type$set_en(ifelse(typeof(
          private$original_data_set[[variable_name]]) == "character", "string", "numeric"))
        return(data_type)
      }
    },
    get_variable_label = function(variable_name) {
      if (private$is_valid_variable_name(variable_name)) {
        variable_label <- I18nString$new()
        variable_label$set_de(private$variable_labels[["de"]][[variable_name]])
        variable_label$set_en(private$variable_labels[["en"]][[variable_name]])
        return(variable_label)
      }
    },
    get_distribution = function(variable_name, scale_level_en, access_ways) {
      if (!("not-accessible" %in% access_ways) &&
        !(variable_name %in% private$variables_no_distribution)) {
        if (private$is_valid_variable_name(variable_name)) {
          data_type_en <- self$get_data_type(variable_name)$get_en()
          original_values <- private$original_data_set[[variable_name]]
          de <- ""
          en <- ""
          if ("de" %in% private$languages[["languages"]]) {
            de <- private$label_table[[private$value_label_container$de[variable_name]]]
          }
          if ("en" %in% private$languages[["languages"]]) {
            en <- private$label_table[[private$value_label_container$en[variable_name]]]
          }
          value_labels <- list(
            de = de,
            en = en
          )
          valid_values <- original_values[!(
            private$evaluate_missing_conditions(original_values, private$missing_conditions[[data_type_en]])
          )]
          missing_values <- original_values[
            private$evaluate_missing_conditions(original_values, private$missing_conditions[[data_type_en]])
          ]
          # attach S3 class attributes to data set column for further calculations
          class(original_values) <- c(class(original_values), data_type_en, scale_level_en)
          class(valid_values) <- c(class(valid_values), data_type_en, scale_level_en)
          distribution <- calculate_frequencies(original_values, valid_values)
          distribution$set_valid_responses(calculate_valid_responses(
            original_values, valid_values, value_labels
          ))
          distribution$set_missings(calculate_missings(
            original_values, missing_values, value_labels
          ))
          distribution$set_statistics(calculate_statistics(valid_values))
          return(distribution)
        }
      }
    },
    get_index_in_data_set = function(variable_name) {
      if (private$is_valid_variable_name(variable_name)) {
        return(which(private$variable_names == variable_name) - 1)
      }
    }
  )
)
