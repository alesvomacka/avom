#' Custom ggplot2 theme with warm, paper-like aesthetics
#'
#' A minimal ggplot2 theme based on `theme_minimal()` with customized fonts,
#' colors, and legend positioning. Designed for a warm, paper-like aesthetic
#' with configurable typography and color scheme.
#'
#' @param base_size Base font size in points. Default is 12.
#' @param base_family Base font family for plot text. Default is "Fira Sans".
#' @param header_family Font family for headers and titles. Default is "Arvo".
#' @param ink Color for text and lines (analogous to ink on paper). Default is "#665c54".
#' @param paper Background color (analogous to paper). Default is "cornsilk".
#' @param accent Accent color for highlights and emphasis. Default is "#d65d0e".
#' @param geom_ink Color for geoms, defaults to "#458588".
#'
#' @return A ggplot2 theme object that can be added to a ggplot.
#'
#' @details
#' The theme removes minor grid lines and positions the legend at the bottom
#' with text above the legend keys. The function checks for font availability
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_avom()
#'
#' # With custom colors
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_avom(ink = "#333333", paper = "white", accent = "#0066cc")
#' }
#'
#' @export
theme_avom <- function(
  base_size = 12,
  base_family = "Fira Sans",
  header_family = "Arvo",
  ink = "#665c54",
  paper = "cornsilk",
  accent = "#d65d0e",
  geom_ink = "#458588"
) {
  ggplot2::theme_minimal(
    base_size = base_size,
    base_family = base_family,
    header_family = header_family,
    base_line_size = base_size / 22,
    base_rect_size = base_size / 22,
    ink = ink,
    paper = paper,
    accent = accent
  ) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      legend.position = "bottom",
      legend.text.position = "top",
      plot.title = marquee::element_marquee(),
      plot.subtitle = marquee::element_marquee(),
      geom = ggplot2::element_geom(
        family = base_family,
        ink = geom_ink
      )
    )
}
