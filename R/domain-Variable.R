Variable <- R6::R6Class("Variable", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    initialize = function() {
      private$dataType <- I18nString$new() # nolint
      private$scaleLevel <- I18nString$new() # nolint
      private$label <- I18nString$new()
      private$annotations <- I18nString$new()
      private$filterDetails <- FilterDetails$new() # nolint
      private$generationDetails <- GenerationDetails$new() # nolint
      private$distribution <- Distribution$new()
    },
    get_data_type = function() {
      return(private$dataType) #nolint
    },
    set_data_type = function(data_type) {
      private$dataType <- data_type # nolint
    },
    get_scale_level = function() {
      return(private$scaleLevel) #nolint
    },
    set_scale_level = function(scale_level) {
      private$scaleLevel <- scale_level # nolint
    },
    get_label = function() {
      return(private$label)
    },
    set_label = function(label) {
      private$label <- label
    },
    get_annotations = function() {
      return(private$annotations)
    },
    set_annotations = function(annotations) {
      private$annotations <- annotations
    },
    get_access_ways = function() {
      return(private$accessWays) #nolint
    },
    set_access_ways = function(access_ways) {
      private$accessWays <- access_ways # nolint
    },
    get_index_in_data_set = function() {
      return(private$indexInDataSet) #nolint
    },
    set_index_in_data_set = function(index_in_data_set) {
      private$indexInDataSet <- jsonlite::unbox(index_in_data_set) # nolint
    },
    get_survey_numbers = function() {
      return(private$surveyNumbers) #nolint
    },
    set_survey_numbers = function(survey_numbers) {
      private$surveyNumbers <- survey_numbers # nolint
    },
    get_panel_identifier = function() {
      return(private$panelIdentifier) #nolint
    },
    set_panel_identifier = function(panel_identifier) {
      private$panelIdentifier <- jsonlite::unbox(panel_identifier) # nolint
    },
    get_derived_variables_identifier = function() {
      return(private$derivedVariablesIdentifier) #nolint
    },
    set_derived_variables_identifier = function(derived_variables_identifier) {
      private$derivedVariablesIdentifier <- jsonlite::unbox(derived_variables_identifier) # nolint
    },
    get_do_not_display_thousands_separator = function() {
      return(private$doNotDisplayThousandsSeparator) #nolint
    },
    set_do_not_display_thousands_separator = function(do_not_display_thousands_separator) { #nolint
      private$doNotDisplayThousandsSeparator <- jsonlite::unbox(do_not_display_thousands_separator) # nolint
    },
    get_related_variables = function() {
      return(private$relatedVariables) #nolint
    },
    set_related_variables = function(related_variables) {
      private$relatedVariables <- related_variables # nolint
    },
    get_storage_type = function() {
      return(private$storageType) #nolint
    },
    set_storage_type = function(storage_type) {
      private$storageType <- jsonlite::unbox(storage_type) # nolint
    },
    get_generation_details = function() {
      return(private$generationDetails) #nolint
    },
    set_generation_details = function(generation_details) {
      private$generationDetails <- generation_details # nolint
    },
    get_filter_details = function() {
      return(private$filterDetails) #nolint
    },
    set_filter_details = function(filter_details) {
      private$filterDetails <- filter_details # nolint
    },
    get_distribution = function() {
      return(private$distribution)
    },
    set_distribution = function(distribution) {
      private$distribution <- distribution
    },
    get_related_questions = function() {
      return(private$relatedQuestions) #nolint
    },
    set_related_questions = function(related_questions) {
      private$relatedQuestions <- related_questions # nolint
    }
  ),
  private = list(
    dataType = NULL,
    scaleLevel = NULL,
    label = NULL,
    annotations = NULL,
    accessWays = NULL,
    indexInDataSet = NULL,
    surveyNumbers = NULL,
    panelIdentifier = NULL,
    derivedVariablesIdentifier = NULL,
    doNotDisplayThousandsSeparator = NULL,
    relatedVariables = NULL,
    storageType = NULL,
    generationDetails = NULL,
    filterDetails = NULL,
    distribution = NULL,
    relatedQuestions = NULL
  )
)
