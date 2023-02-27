#' ggplot2 theme from avom
#'
#' @description
#' ggplot2 theme based on gruvbox color palette and Fira Sans font.
#'
#' @param panel.grid.major Controls major leading lines. Expects [ggplot2::element_line()] line function.
#' @param panel.grid.minor Controls minor leading lines.
#' @param ... Other arguments to be passed to [ggplot2::theme()].
#'
#' @export
#'
#' @examples
#' ggplot2::ggplot(data = mtcars,
#'                 mapping = ggplot2::aes(x = mpg, y = hp)) +
#'          ggplot2::geom_point() +
#'          theme_avom()
theme_avom <- function(panel.grid.major = ggplot2::element_line(),
                       panel.grid.minor = ggplot2::element_blank(),
                       ...) {
  ggplot2::theme(rect = ggplot2::element_rect(fill = "#f9f5d7", color = NA),
        panel.background = ggplot2::element_rect(fill = "#f9f5d7"),
        strip.background = ggplot2::element_rect(fill = "#fbf1c7"),
        legend.key = element_rect(fill = "#f9f5d7"),
        panel.grid.minor = panel.grid.minor,
        panel.grid.major = panel.grid.major,
        text  = ggplot2::element_text(family = "Fira Sans"),
        title = ggplot2::element_text(face = "bold"),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        axis.ticks = ggplot2::element_line(color = "white")) +
    ggplot2::theme(...)
}
