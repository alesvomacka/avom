#' Setup up Project Structure
#'
#' @description
#' Sets up project structure.
#'
#' @param air Sets up air.toml for Air formatter
#' @param pak Installs pak (sets it up to work with renv if present)
#'
#' @details
#' Creates folders I usually use. Optionally also sets up air and pak.
#'
#' @export
#' @return Nothing
#'
#' @examples
#' \dontrun{
#' setup_project()
#'}
setup_project <- function(air = TRUE, pak = TRUE) {
  # Setup Folders
  dir_names <- c(
    "01-data-input",
    "02-data-processed",
    "3-data-output",
    "04-scripts",
    "05-figures",
    "06-models",
    "07-tables",
    "08-documentation",
    "09-writing"
  )

  for (dir in dir_names) {
    dir.create(dir, showWarnings = FALSE)
  }

  #Air formatter: https://posit-dev.github.io/air/
  if (air) {
    file.create("air.toml")

    write(
      '[format]
      line-width = 120
      indent-width = 2
      indent-style = "space"
      line-ending = "auto"
      persistent-line-breaks = true',
      file = "air.toml"
    )
  }

  #Install pak and set it as default for renv (if present): https://pak.r-lib.org/
  if (pak) {
    utils::install.packages("pak")

    if (dir.exists("renv")) {
      contents = readLines(".Rprofile")
      newcontents = c("options(renv.config.pak.enabled = TRUE)", contents)
      writeLines(newcontents, ".Rprofile")
    }
  }
}
