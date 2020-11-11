options(repos =
    c(CRAN = "file:///variablenexport/miniCRAN_VariableMetadataPreparation"))
.libPaths(c("./library", "z:/R/win-library-3.5",
  "C:/Program Files/R/R-3.5.1/library"))



option_list <- list(
  optparse::make_option(c("-i", "--input-directory"),
    type = "character",
    action = "store", default = NA,
    help = paste0(
      "Path to the directory containing the input ",
      "project directory with excel sheets, Json directory, and stata data."
    ),
    dest = "inputdirectory"
  ),
  optparse::make_option(c("-o", "--destination-directory"),
    type = "character",
    action = "store", default = NA,
    help = paste0(
      "Path to the directory where the work should",
      "be stored after succesful runs."
    ),
    dest = "destinationdirectory"
  )
)

option_parser <- optparse::OptionParser(option_list = option_list)

copy_opts <- optparse::parse_args(option_parser)

if (is.na(copy_opts$inputdirectory)) {
  optparse::print_help(option_parser)
  stop("INPUT-DIRECTORY must not be empty!")
}


if (is.na(copy_opts$destinationdirectory)) {
  optparse::print_help(option_parser)
  stop("DESTINATION-DIRECTORY must not be empty!")
}


copy_files_to_project_dir <- function(inputdirectory = copy_opts$inputdirectory,
  destinationdirectory = copy_opts$destinationdirectory) {
  file.copy(inputdirectory, destinationdirectory, recursive = TRUE)
}


copy_files_to_project_dir(opt$inputdirectory, opt$destinationdirectory)
