#' Convenient wrapper around ggsave
#'
#'A simple wrapper around [ggplot2::ggsave()], which uses metric unit system and AGG graphical device by default.
#'
#' @param filename Name of the exported file.
#' @param plot Exported plot
#' @param width Width of the plot. Defaults to 17 cm.
#' @param height Height of the plot. Defaults to 8 cm.
#' @param scaling Scaling factor for text. Defaults to 1.
#' @param device Graphical device to use. Defaults to [ragg::agg_png()].
#' @param ... Other arguments passed to [ggplot2::ggsave()].
#'
#' @export
#'
#' @examples \dontrun{
#' mtcars_plot <- ggplot2::ggplot(mtcars,
#'                 mapping = ggplot2::aes(x = mpg,
#'                                        y = hp)) +
#' ggplot2::geom_point()
#'
#' avom_ggsave("mtcars-plot.png", mtcars_plot)
#' }
avom_ggsave <- function(filename,
                        plot = ggplot2::last_plot(),
                        width = 17, height = 8,
                        scaling = 1, device = ragg::agg_png,
                        ...) {
  ggplot2::ggsave(filename = filename,
                  plot = plot,
                  width = width,
                  height = height,
                  scaling = scaling,
                  units = "cm",
                  device = device,
                  ...)
}
