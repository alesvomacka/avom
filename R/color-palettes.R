# Color Palettes Definition -----------------------------------------------

#' Select a Color Palette
#'
#' @param palette Name of a palette.
#' @param n Number of colors to extract. If `NA`, extracts all.
#'
#' @description
#' Returns a vector of colors forming a cohesive palette. Current palettes include:
#' * Nominal: `gruvbox_light`, `gruvbox_dark`
#' * Diverging: `gruvbox_div`
#'
#' @return A vector of color hexcodes.
#'
#' @export
#'
#' @examples
#' avom_palettes(palette = "gruvbox_light")
#' avom_palettes(palette = "gruvbox_dark", n = 5)
avom_palettes <- function(palette = "gruvbox_light", n = NA) {

   if(!is.na(n) & !is.numeric(n)) stop("n has to be an integer")
   if(!is.na(n) & (n < 1L)) stop("n has to be positive integer")

  palettes <- list(
    # Nominal
    gruvbox_light = c("#fb4934", "#b8bb26", "#83a598", "#fabd2f", "#d3869b", "#8ec07c", "#fe8019"),
    gruvbox_dark  = c("#cc241d", "#98971a", "#458588", "#d79921", "#b16286", "#689d6a", "#d65d0e"),

    # Diverging
    gruvbox_div   = c("#b9211a", "#cc241d", "#fb4934", "#fac64c", "#83a598", "#649590", "#458588"),

    # Sequential
    gruvbox_seq   = c("#d65d0e", "#de702d", "#e68246", "#ed945e", "#f3a577", "#f8b790", "#fcc8aa", "#ffdac4")
    )

  if (!is.na(n)) {
    palettes[[palette]][1:n]
  } else {
    palettes[[palette]]
  }

}

# Helper Functions (Internal) ---------------------------------------------

#' Prepares Color Palette for ggplot2
#'
#' @param palette Name of a palette.
#' @param direction If `-1`, reverses the order of colors.
#'
#' @return A vector of color hex codes to use with ggplot2
#'
#' @keywords internal
#'
#' @examples \dontrun{
#'    avom_palette_generator()
#' }
avom_palette_generator <- function(palette = "gruvbox_light", direction = 1) {

  diverging <- "gruvbox_div"

  function(n) {

    if (n > length(avom_palettes(palette))) {
      stop("Not enough colors in this palette!")
    }

    if(diverging %in% palette) {
      colors <- diverging_color_extractor(palette = palette, n = n)
    } else {
      colors <- avom_palettes(palette)
      colors <- colors[1:n]
    }

    colors <- if (direction >= 0) colors else rev(colors)

  }
}

#' Diverging Color Palette Extractor
#'
#' @param palette Name of a palette.
#' @param n Number of colors to extract.
#'
#' @keywords internal
#'
#' @description
#' For diverging palettes, colors should be picked from the both ends, not sequentially.
#'
#' @return A vector of color hex codes
#'
#' @examples \dontrun{
#'    diverging_color_extractor(avom_palettes(palette = "gruvbox_div"), n = 3)
#' }
diverging_color_extractor <- function(palette, n) {

  palette <- avom_palettes(palette)

  if(n %% 2) {
    left <- c(1:floor(n/2))
    mid <- ceiling(length(palette) / 2)
    right <- c((length(palette) - floor(n/2) + 1): length(palette))

    palette[c(left, mid, right)]

  } else {
    left <- c(1:floor(n/2))
    right <- c((length(palette) - floor(n/2) + 1): length(palette))

    palette[c(left, right)]

  }

}

# ggplot2 Scale Functions -------------------------------------------------

#' Sequential, diverging and qualitative color scales from avom
#'
#' @param palette Name of a palette to use.
#' @param direction Orientation of the palette. If `-1`, the order of colors is reversed.
#' @param ... Additional arguments to be passed to [ggplot2::discrete_scale()]
#'
#' @description
#' Returns a vector of colors forming a cohesive palette. Current palettes include:
#' * Nominal: `gruvbox_light`, `gruvbox_dark`
#' * Diverging: `gruvbox_div`
#'
#' @export
#'
#' @examples
#' ggplot2::ggplot(data = mtcars,
#'        mapping = ggplot2::aes(x = mpg, y = hp, color = as.factor(am))) +
#'        ggplot2::geom_point() +
#'        scale_color_avom()
scale_colour_avom <- function(palette = "gruvbox_light", direction = 1, ...) {

  ggplot2::discrete_scale(
    "colour", "avom",
    avom_palette_generator(palette, direction),
    ...
  )
}

#' @rdname scale_colour_avom
#' @export
scale_color_avom <- scale_colour_avom

#' @rdname scale_colour_avom
#' @export
scale_fill_avom <- function(palette = "gruvbox_light", direction = 1, ...) {

  ggplot2::discrete_scale(
    "fill", "avom",
    avom_palette_generator(palette, direction),
    ...
  )
}
