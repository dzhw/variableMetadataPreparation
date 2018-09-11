suppressPackageStartupMessages(suppressWarnings(library(here)))
suppressPackageStartupMessages(suppressWarnings(library(optparse)))

script_basename <- here("R")
source(paste0(script_basename, "/variable_metadata_generation.R"))

option_list <- list(
  make_option(c("-e", "--excel-directory"),
    type = "character",
    action = "store", default = NA,
    help = paste0("Path to the directory containing the input ",
      "excel files: files must be named vimport_dsXX.xlsx"),
    dest = "exceldirectory"),
  make_option(c("-s", "--stata-directory"),
    type = "character",
    action = "store", default = NA,
    help = paste0("Path to the directory containing the input ",
      "stata dataset files: files must be named dsXX.dta"),
    dest = "statadirectory"),
  make_option(c("-o", "--output-directory"),
    type = "character",
    action = "store", default = NA,
    help = "Path to the directory of output files",
    dest = "outputdirectory"),
  make_option(c("-m", "--missing-conditions"),
    type = "character",
    action = "store", default = NA,
    help = "Path to excel file containing the missing conditions",
    dest = "missing_conditions"),
  make_option(c("-n", "--variables-no-distribution"),
    type = "character",
    action = "store", default = "pid,id",
    help = paste0("Names of variables without distribution: ",
      "default = \"pid,id\", variables with accessWays not-accessible ",
      "should not be included in this list"),
    dest = "variables_no_distribution")
)

option_parser <- OptionParser(option_list = option_list)

opt <- parse_args(option_parser)

if (is.na(opt$exceldirectory)) {
  print_help(option_parser)
  stop("EXCEL-DIRECTORY must not be empty!")
}

if (length(dir(opt$exceldirectory, pattern = "vimport_ds[0-9]+\\.xlsx")) == 0) {
  print_help(option_parser)
  stop(paste0("EXCEL-DIRECTORY must contain excel files (.xlsx)",
    " named vimport_ds1, vimport_ds2,...!"))
}

if (is.na(opt$statadirectory)) {
  print_help(option_parser)
  stop("STATA-DIRECTORY must not be empty!")
}

if (length(dir(opt$statadirectory, pattern = "ds[0-9]+\\.dta")) == 0) {
  print_help(option_parser)
  stop(paste0("STATA-DIRECTORY must contain stata files (.dta)",
  " named ds1.dta, ds2.dta,...!"))
}

if (is.na(opt$outputdirectory)) {
  print_help(option_parser)
  stop("OUTPUT-DIRECTORY must not be empty!")
}

variable_metadata_generation(
  opt$exceldirectory, opt$statadirectory, opt$missing_conditions,
  opt$outputdirectory, opt$variables_no_distribution)
