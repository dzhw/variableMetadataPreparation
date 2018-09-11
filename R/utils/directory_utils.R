
# create folders ds1, ds2,... or delete old jsons if already exist
create_export_directories <- function(path_to_json_directory, stata_files) {
  for (data_set in stata_files) {
    ds <- sub("\\.dta$", "", data_set)
    # if directory "path_to_json_directory/dsXX" doesn't exist
    if (!dir.exists(file.path(paste0(path_to_json_directory, "/", ds)))) {
      dir.create(file.path(paste0(path_to_json_directory, "/", ds)))
      cat(paste0("Created new directory ", ds, "\n"))
    }
    # if directory "path_to_json_directory/dsXX" does exist
    else {
      # if directory already contains json files
      if (length(list.files(paste0(path_to_json_directory, "/", ds))) > 0) {
        do.call(file.remove, as.list(
          list.files(paste0(path_to_json_directory, "/", ds),
            pattern = "*.json", full.names = TRUE)))
        cat(paste0("Deleted old json files from ",
          paste0(path_to_json_directory, "\\", ds, "\n")))
      }
    }
  }
}
