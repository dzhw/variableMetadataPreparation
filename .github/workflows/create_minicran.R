#' Create miniCRAN instance including only Imports packages of the current package
#' @param minicran_path The path where the miniCRAN instance is created
#' @param r_version String containing the R version, e.g. "3.5"
create_minicran <- function(minicran_path = "./miniCRAN", r_version = "3.5.1") {
  cran_server <- c(CRAN = "https://cran.rstudio.com")
  description <- desc::desc_get_deps(".")
  pkgs <- description$package[which(description$type=="Imports")]
  versions <- description$version[which(description$type=="Imports")]
  pkgList <-
    miniCRAN::pkgDep(pkgs,
      repos = cran_server,
      type = "source",
      suggests = FALSE)
  dir.create(pth <- file.path(minicran_path))
  miniCRAN::makeRepo(
    pkgList,
    path = pth,
    repos = cran_server,
    type = c("source", "win.binary"),
    Rversion = r_version
  )
  version <- desc::desc_get_field("Version", ".")
  miniCRAN::addLocalPackage(paste0("variableMetadataPreparation_", version, ".tar.gz"),
    pkgPath = ".", path = minicran_path)
}

create_minicran()
