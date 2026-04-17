#' avom S7 palette class
#' @description
#' Internal S7 class used to define and validate color palettes. Not intended for direct use;
#' use `avom_palette()` to retrieve palette colors.
#'
#' @param name Character. Identifier name for the palette.
#' @param type Character. Palette type: `"nominal"`, `"diverging"`, or `"sequential"`.
#' @param colors Character vector of hex color codes.
#'
#' @return S7 object of class `"avom_palette"`.
#' @keywords internal

avom_colors <- S7::new_class(
  name = "avom_palette",
  properties = list(
    name = S7::class_character,
    type = S7::class_character,
    colors = S7::class_vector
  ),
  validator = function(self) {
    if (!self@type %in% c("nominal", "diverging", "sequential")) {
      "@type must be one of 'nominal', 'diverging', 'sequential'"
    }
  }
)

#' Registry of all avom color palettes
#'
#' @description
#' A named list of S7 objects of class `avom_palette`, one entry per palette.
#' This is the single source of truth for all palette definitions in the package.
#' Both `avom_palette()` and `avom_palettes_all()` derive their data from this object.
#'
#' To add a new palette to the package, append an entry here using `avom_colors()`.
#'
#' @format A named list of `avom_palette` S7 objects. Each element has three properties:
#' \describe{
#'   \item{`name`}{Character. The palette identifier, matching the list name.}
#'   \item{`type`}{Character. One of `"nominal"`, `"diverging"`, or `"sequential"`.}
#'   \item{`colors`}{Character vector of hex color codes.}
#' }
#'
#' @keywords internal
.avom_palettes <- list(
  #Nominal palettes
  catpuccin_latte = avom_colors(
    name = "catpuccin_latte",
    type = "nominal",
    colors = c(
      "#d20f39",
      "#40a02b",
      "#1e66f5",
      "#fe640b",
      "#209fb5",
      "#ea76cb"
    )
  ),
  catpuccin_frappe = avom_colors(
    name = "catpuccin_frappe",
    type = "nominal",
    colors = c(
      "#e78284",
      "#a6d189",
      "#8caaee",
      "#ef9f76",
      "#85c1dc",
      "#f4b8e4"
    )
  ),
  catpuccin_macchiato = avom_colors(
    name = "catpuccin_macchiato",
    type = "nominal",
    colors = c(
      "#ed8796",
      "#a6da95",
      "#8aadf4",
      "#f5a97f",
      "#7dc4e4",
      "#f5bde6"
    )
  ),
  catpuccin_mocha = avom_colors(
    name = "catpuccin_mocha",
    type = "nominal",
    colors = c(
      "#f38ba8",
      "#a6e3a1",
      "#89b4fa",
      "#fab387",
      "#74c7ec",
      "#f5c2e7"
    )
  ),
  gruvbox = avom_colors(
    name = "gruvbox",
    type = "nominal",
    colors = c(
      "#cc241d",
      "#98971a",
      "#458588",
      "#d79921",
      "#b16286",
      "#d65d0e",
      "#689d6a"
    )
  ),
  gruvbox_light = avom_colors(
    name = "gruvbox_light",
    type = "nominal",
    colors = c(
      "#fb4934",
      "#b8bb26",
      "#83a598",
      "#fabd2f",
      "#d3869b",
      "#fe8019",
      "#8ec07c"
    )
  ),
  #Diverging palettes
  redblue = avom_colors(
    name = "RdYlBu",
    type = "diverging",
    colors = c(
      "#D73027",
      "#F46D43",
      "#FDAE61",
      "#FEE090",
      "#FFFFBF",
      "#E0F3F8",
      "#ABD9E9",
      "#74ADD1",
      "#4575B4"
    )
  ),
  beach = avom_colors(
    name = "beach",
    type = "diverging",
    colors = c("#264653", "#2a9d8f", "#e3ba54", "#f4a261", "#e76f51")
  ),
  royal_orange = avom_colors(
    name = "royal_orange",
    type = "diverging",
    colors = c("#663399", "#7851a9", "#fed6ae", "#e86100", "#ba160c")
  ),
  #Sequential palettes
  rising_reds = avom_colors(
    name = "rising_reds",
    type = "sequential",
    colors = c("#461220", "#8c2f39", "#b23a48", "#fed0bb")
  ),
  rising_blues = avom_colors(
    name = "rising_blues",
    type = "sequential",
    colors = c("#0d1321", "#1d2d44", "#3e5c76", "#f0ebd8")
  ),
  greys = avom_colors(
    name = "greys",
    type = "sequential",
    colors = c(
      "#BDBDBD",
      "#969696",
      "#737373",
      "#525252",
      "#252525",
      "#000000"
    )
  )
)

#' Retrieve an avom color palette
#'
#' @description
#' Returns a character vector of hex color codes for the requested palette. The vector carries
#' a `type` attribute (`"nominal"`, `"diverging"`, or `"sequential"`) used internally by
#' [palette_gen()].
#'
#' @param palette Name of the palette. One of:
#'
#' **Nominal** (categorical, unordered data):
#' \describe{
#'   \item{`"catpuccin_latte"`}{6 colors. Catppuccin Latte — warm, pastel light theme.}
#'   \item{`"catpuccin_frappe"`}{6 colors. Catppuccin Frappé — muted pastel mid-tone theme.}
#'   \item{`"catpuccin_macchiato"`}{6 colors. Catppuccin Macchiato — darker pastel theme.}
#'   \item{`"catpuccin_mocha"`}{6 colors. Catppuccin Mocha — dark-mode pastel theme.}
#'   \item{`"gruvbox"`}{7 colors. Gruvbox dark — retro, earthy dark theme.}
#'   \item{`"gruvbox_light"`}{7 colors. Gruvbox light — retro, earthy light theme.}
#' }
#'
#' **Diverging** (data with a meaningful midpoint):
#' \describe{
#'   \item{`"redblue"`}{9 colors. Red–Yellow–Blue (ColorBrewer RdYlBu). Warm to cool.}
#'   \item{`"beach"`}{5 colors. Deep teal to warm coral — inspired by beach tones.}
#'   \item{`"royal_orange"`}{5 colors. Purple to burnt orange — bold contrast diverging.}
#' }
#'
#' **Sequential** (ordered data from low to high):
#' \describe{
#'   \item{`"rising_reds"`}{4 colors. Dark crimson to soft blush.}
#'   \item{`"rising_blues"`}{4 colors. Dark navy to pale sand.}
#'   \item{`"greys"`}{6 colors. Light silver to near-black.}
#' }
#'
#' @return Character vector of hex color codes with a `type` attribute
#'   (`"nominal"`, `"diverging"`, or `"sequential"`).
#'
#' @export
#' @seealso [palette_gen()], [scale_colour_avom()], [scale_fill_avom()]
#'
#' @examples
#' # Returns a plain character vector
#' avom_palette("catpuccin_latte")
#'
#' # Inspect the palette type
#' attr(avom_palette("beach"), "type")
#'
#' # Use with scales package for interpolation
#' scales::show_col(avom_palette("gruvbox"))
avom_palette <- function(palette = "catpuccin_latte") {
  pal <- .avom_palettes[[palette]]
  colors <- pal@colors
  attr(colors, "type") <- pal@type
  colors
}

#' Color palette generator factory
#'
#' @description
#' Returns a function `function(n)` that selects `n` colors from the named palette.
#' This factory is used internally by [scale_colour_avom()] and [scale_fill_avom()] to
#' satisfy ggplot2's discrete scale interface, but can also be called directly.
#'
#' Diverging palettes use [select_diverging()] to pick colors that preserve the
#' symmetric structure of the palette. All other palette types return the first `n` colors,
#' optionally reversed.
#'
#' @param palette Name of the palette. See [avom_palette()] for the full list of valid names.
#' @param direction `1` (default) returns colors in their natural order; `-1` reverses the order.
#'
#' @return A `function(n)` that returns a character vector of `n` hex color codes.
#'
#' @export
#' @seealso [avom_palette()], [select_diverging()], [scale_colour_avom()]
#'
#' @examples
#' # Create a generator then call it for 3 colors
#' gen <- palette_gen("catpuccin_latte")
#' gen(3)
#'
#' # Reversed order
#' palette_gen("redblue", direction = -1)(5)

palette_gen <- function(palette = "catpuccin_latte", direction = 1) {
  function(n) {
    all_colors <- avom_palette(palette)
    if (n > length(all_colors)) {
      warning("Not enough colors in this palette!")
    } else {
      if (attr(all_colors, "type") == "diverging") {
        all_colors <- select_diverging(all_colors, n)
      }
      all_colors <- all_colors[1:n]
      if (direction < 0) {
        all_colors <- rev(all_colors)
      }
      all_colors
    }
  }
}

#' Select n colors from a diverging palette
#'
#' @description
#' Selects `n` colors from a diverging palette while preserving its symmetric, center-anchored
#' structure. Rather than simply taking the first `n` colors, this function samples
#' symmetrically from both ends of the palette:
#'
#' - **Odd `n`**: the palette midpoint is always included, with an equal number of colors
#'   drawn from each side.
#' - **Even `n`**: colors are drawn evenly from the left and right halves.
#'
#' The selected colors are always returned in their original palette order.
#'
#' @param palette Character vector of hex color codes representing the full diverging palette.
#' @param n Number of colors to select. Must be between 1 and `length(palette)`.
#'
#' @return Character vector of `n` hex color codes in original palette order.
#'
#' @export
#' @seealso [palette_gen()], [avom_palette()]
#'
#' @examples
#' pal <- c("#264653", "#2a9d8f", "#e9c46a", "#f4a261", "#e76f51")
#'
#' # Odd n: midpoint included, balanced sides
#' select_diverging(pal, n = 3)
#'
#' # Even n: two from each end
#' select_diverging(pal, n = 4)

select_diverging <- function(palette, n) {
  # Check if n is valid
  if (n < 1 || n > length(palette)) {
    stop("n must be between 1 and ", length(palette))
  }

  # If n equals the palette length, return the full palette
  if (n == length(palette)) {
    return(palette)
  }

  # Calculate positions to select
  total_length <- length(palette)
  middle_pos <- ceiling(total_length / 2)
  selected_positions <- numeric(n)

  # For odd n, ensure we get the middle position
  if (n %% 2 == 1) {
    # Place middle position in the middle of our selection
    middle_index <- ceiling(n / 2)
    selected_positions[middle_index] <- middle_pos

    # Fill in positions before and after the middle
    left_count <- middle_index - 1
    right_count <- n - middle_index

    # Fill left side
    if (left_count > 0) {
      for (i in 1:left_count) {
        selected_positions[i] <- i
      }
    }

    # Fill right side
    if (right_count > 0) {
      for (i in 1:right_count) {
        selected_positions[middle_index + i] <- total_length - right_count + i
      }
    }
  } else {
    # For even n, select evenly from both sides
    half_n <- n / 2
    for (i in 1:half_n) {
      selected_positions[i] <- i
      selected_positions[n - i + 1] <- total_length - i + 1
    }
  }

  # Sort positions to maintain original color order
  selected_positions <- sort(selected_positions)
  result <- palette[selected_positions]

  return(result)
}

#' avom discrete color and fill scales for ggplot2
#'
#' @description
#' Discrete ggplot2 scales that apply an avom color palette to the `colour` or `fill` aesthetic.
#' Three aliases are provided:
#' - `scale_colour_avom()` — maps to the `colour` aesthetic (British spelling).
#' - `scale_color_avom()` — alias for `scale_colour_avom()` (American spelling).
#' - `scale_fill_avom()` — maps to the `fill` aesthetic.
#'
#' All functions delegate to [ggplot2::discrete_scale()] via [palette_gen()], so any argument
#' accepted by `discrete_scale()` (e.g. `name`, `breaks`, `labels`, `na.value`, `drop`) can
#' be passed through `...`.
#'
#' @param palette Name of the palette. See [avom_palette()] for the full list of valid names.
#'   Defaults to `"catpuccin_latte"`.
#' @param direction `1` (default) uses colors in their natural order; `-1` reverses the order.
#' @param ... Additional arguments passed to [ggplot2::discrete_scale()].
#'
#' @return A ggplot2 `Scale` object to be added to a plot with `+`.
#'
#' @export
#' @seealso [avom_palette()], [palette_gen()], [ggplot2::discrete_scale()]
#'
#' @examples
#' ggplot2::ggplot(data = mtcars,
#'                 mapping = ggplot2::aes(x = mpg, y = hp, color = as.factor(cyl))) +
#'   ggplot2::geom_point() +
#'   scale_colour_avom("catpuccin_latte")
#'
#' # Fill aesthetic
#' ggplot2::ggplot(data = mtcars,
#'                 mapping = ggplot2::aes(x = as.factor(cyl), fill = as.factor(cyl))) +
#'   ggplot2::geom_bar() +
#'   scale_fill_avom("gruvbox", direction = -1)

scale_colour_avom <- function(palette = "catpuccin_latte", direction = 1, ...) {
  ggplot2::discrete_scale(
    "colour",
    "avom",
    palette_gen(palette, direction),
    ...
  )
}

#' @rdname scale_colour_avom
#' @export
#' @order 2
scale_fill_avom <- function(palette = "catpuccin_latte", direction = 1, ...) {
  ggplot2::discrete_scale(
    "fill",
    "avom",
    palette_gen(palette, direction),
    ...
  )
}

#' @rdname scale_colour_avom
#' @export
scale_color_avom <- scale_colour_avom

#' Display all available avom palettes
#'
#' @description
#' Plots a visual overview of all available avom color palettes, grouped by type
#' (nominal, diverging, sequential). Each row shows one palette's colors as tiles,
#' similar to `RColorBrewer::display.brewer.all()`.
#'
#' @return A ggplot2 object.
#'
#' @export
#' @seealso [avom_palette()], [scale_colour_avom()]
#'
#' @examples
#' avom_palettes_all()
avom_palettes_all <- function() {
  palette_names <- names(.avom_palettes)

  df <- do.call(
    rbind,
    lapply(palette_names, function(name) {
      colors <- avom_palette(name)
      data.frame(
        palette = name,
        type = attr(colors, "type"),
        x = seq_along(colors),
        color = as.character(colors),
        stringsAsFactors = FALSE
      )
    })
  )

  df$palette <- factor(df$palette, levels = rev(palette_names))
  df$type <- factor(df$type, levels = c("sequential", "diverging", "nominal"))

  ggplot2::ggplot(df, ggplot2::aes(x = x, y = palette, fill = I(color))) +
    ggplot2::geom_tile(color = "white", linewidth = 0.6) +
    ggplot2::facet_grid(type ~ ., scales = "free_y", space = "free_y") +
    ggplot2::scale_x_continuous(
      breaks = NULL,
      expand = ggplot2::expansion(add = 0.5)
    ) +
    ggplot2::labs(x = NULL, y = NULL, title = "avom color palettes") +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      panel.grid = ggplot2::element_blank(),
      strip.text.y = ggplot2::element_text(angle = 0, hjust = 0, face = "bold"),
      axis.text.y = ggplot2::element_text(hjust = 1),
      plot.title = ggplot2::element_text(
        face = "bold",
        margin = ggplot2::margin(b = 8)
      )
    )
}
