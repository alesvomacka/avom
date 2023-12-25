#' ggplot2 theme from avom
#'
#' @description
#' ggplot2 theme based on gruvbox color palette and Fira Sans font.
#'
#' @param font_family Font family. Defaults to "Fira Sans".
#' @param font_size Baseline size for text. Defaults to 10.
#' @param ... Other arguments passed to [ggplot2::theme_minimal()].
#' @export
#'
#' @examples \dontrun{
#' ggplot2::ggplot(data = mtcars,
#'                 mapping = ggplot2::aes(x = mpg, y = hp)) +
#'          ggplot2::geom_point() +
#'          theme_avom()
#'          }

theme_avom <- function(font_family = "Fira Sans", font_size = 10, ...){
  ggplot2::theme_minimal() +
    ggplot2::theme(
      # Text
      text = ggplot2::element_text(family = font_family,
                                   size = font_size),
      plot.title = ggtext::element_textbox_simple(size = ggplot2::rel(1.3)),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      plot.subtitle = ggtext::element_textbox_simple(size = ggplot2::rel(1.1),
                                                     padding = ggplot2::margin(4, 0, 0, 0)),
      axis.title = ggplot2::element_text(hjust = 0.9,
                                         size = ggplot2::rel(1)),
      axis.text = ggplot2::element_text(size = ggplot2::rel(0.9)),
      plot.caption = ggtext::element_markdown(hjust = 0,
                                              size = ggplot2::rel(0.8)),
      # Backround
      panel.background = ggplot2::element_rect(fill = "#fbf1c7", colour = NA),
      plot.background = ggplot2::element_rect(fill = "#fbf1c7"),
      # Grid Lines
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(colour = "#d1c8c0",
                                               linetype = "dashed"),
      ...)
}
