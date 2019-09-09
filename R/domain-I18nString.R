I18nString <- R6::R6Class("I18nString", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    get_en = function() {
      return(private$en)
    },
    set_en = function(en) {
      private$en <- jsonlite::unbox(en)
    },
    get_de = function() {
      return(private$de)
    },
    set_de = function(de) {
      private$de <- jsonlite::unbox(de)
    }
  ),
  private = list(
    de = NULL,
    en = NULL
  )
)
