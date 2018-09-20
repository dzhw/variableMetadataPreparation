options(import.path = here::here("R/domain"))

suppressPackageStartupMessages(suppressWarnings(library(here)))

modules::import("JSONSerializableDomainObject", attach = TRUE)

I18nString <- R6Class("I18nString", # nolint
  inherit = JSONSerializableDomainObject,
  public = list(
    get_en = function() {
      return(private$en)
    },
    set_en = function(en) {
      private$en <- unbox(en)
    },
    get_de = function() {
      return(private$de)
    },
    set_de = function(de) {
      private$de <- unbox(de)
    }
  ),
  private = list(
    de = NULL,
    en = NULL
  )
)
