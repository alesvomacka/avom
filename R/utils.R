#' Setup up Project Structure
#' 
#' @description
#' Sets up project structure.
#' 
#' @details
#' For now, just creates folders I usually use.
#'  
#' @export
#' @return Nothing
#' 
#' @examples
#' \dontrun{
#' setup_project()
#'}
setup_project <- function() {
  # Setup Folders
  dir_names <- c("01-data-input", "02-data-processed",
                 "3-data-output", "04-scripts",
                 "05-figures", "06-models", "07-tables",
                 "08-documentation", "09-writing")
  
  for (dir in dir_names) {
    dir.create(dir, showWarnings = FALSE)
  }
}
