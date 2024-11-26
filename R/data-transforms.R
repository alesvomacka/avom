#' Count and Compute Relative Frequencies
#' 
#' @description
#' This is like [dplyr::count()] but also computes relative frequencies.
#' 
#' @details
#' Uses [dplyr::count()] to compute absolute, possibly weighted, frequencies. Also computes relative frequencies and possibly labels for plots.
#' 
#' @param data Dataset
#' @param wt Optional weights
#' @param .by Optional variable to compute grouped percentages
#' @param labels If `TRUE`, returns values formatted for plotting`
#' @param suffix Set suffix for labels
#' @param ... Additional arguments to be passed to [dplyr::count()], including variables.
#' 
#' @export
#' @return Dataframe with absolute and relative frequencies.
#' 
#' @examples
#' count_pct(mtcars, cyl, labels = TRUE)
count_pct <- function(data, ..., wt = NULL, .by = NULL, labels = FALSE, suffix = "") {
  data <- dplyr::count(data, ..., wt = {{wt}})
  data <- dplyr::mutate(data, percent = n / sum(n), .by = {{.by}})

  if(labels) {
    data$label <- round(data$percent * 100)
    data$label <- paste0(data$label, suffix)
    }
  return(data)
}
