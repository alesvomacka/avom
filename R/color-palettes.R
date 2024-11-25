#' avom S7 palette class
#' @description 
#' Creates a color palette, which is a S7 object of class "avom_palette", to be used in other functions.
#' 
#' @param name Name of the class, "avom_palette".
#' @param type Type of the of the palette: "nominal", "diverging" or "sequential".
#' @param colors Vector of colors.
#' 
#' @return S7 object of class "avom_palette".
#' 
#' @examples
#' avom_colors(name = "gruvbox", type = "nominal", colors = c("#cc241d", "#98971a", "#458588", "#d79921", "#b16286", "#d65d0e", "#689d6a"))
avom_colors <- S7::new_class(name = "avom_palette",
                             properties = list(name = S7::class_character,
                                                type = S7::class_character,
                                                colors = S7::class_vector),
                             validator = function(self) {
                                if (!self@type %in% c("nominal", "diverging", "sequential")) {
                                  "@type must be one of 'nominal', 'diverging', 'sequential'"
                                }
                              }
                             )

#' Color Palettes for avom
#' @description
#' Palettes for plotting.
#' 
#' @details
#' Returns an S7 object representing color palette. The existing palettes are:
#' Nominal: catpuccin_latte, catpuccin_frappe, catpuccin_macchiato, catpuccing_mocha, gruvbox, gruvbox_light
#' Diverging: beach, royal_orange
#' Sequential: rising_reds, rising_blues
#' 
#' @param palette Name of the palette.
#' 
#' @export
#' @return S7 object of class "avom_palette".
#' 
#' @examples
#' avom_palette(palette = "catpuccin_latte")

avom_palette <- function(palette = "catpuccin_latte") {
  avom_palettes <- list(
    #Nominal palettes
    catpuccin_latte     = avom_colors(name = "catpuccin_latte", type = "nominal",
                               colors = c("#d20f39", "#40a02b", "#1e66f5", "#fe640b", "#209fb5", "#ea76cb")),
    catpuccin_frappe    = avom_colors(name = "catpuccin_frappe", type = "nominal",
                              colors = c("#e78284", "#a6d189", "#8caaee", "#ef9f76", "#85c1dc", "#f4b8e4")),
    catpuccin_macchiato = avom_colors(name = "catpuccin_macchiato", type = "nominal",
                               colors = c("#ed8796", "#a6da95", "#8aadf4", "#f5a97f", "#7dc4e4", "#f5bde6")),
    catpuccin_mocha     = avom_colors(name = "catpuccin_mocha", type = "nominal",
                               colors = c("#f38ba8", "#a6e3a1", "#89b4fa", "#fab387", "#74c7ec", "#f5c2e7")),
    gruvbox             = avom_colors(name = "gruvbox", type = "nominal",
                               colors = c("#cc241d", "#98971a", "#458588", "#d79921", "#b16286", "#d65d0e", "#689d6a")),
    gruvbox_light       = avom_colors(name = "gruvbox_light", type = "nominal",
                               colors = c("#fb4934", "#b8bb26", "#83a598", "#fabd2f", "#d3869b", "#fe8019", "#8ec07c")),
    #Diverging palettes
    beach                 = avom_colors(name = "beach", type = "diverging",
                               colors = c("#264653", "#2a9d8f", "#e3ba54", "#f4a261", "#e76f51")),
    royal_orange          = avom_colors(name = "royal_orange", type = "diverging",
                               colors = c("#663399","#7851a9","#fed6ae","#e86100","#ba160c")),
    #Sequential palettes
    rising_reds           = avom_colors(name = "rising_reds", type = "sequential",
                               colors = c("#461220", "#8c2f39", "#b23a48", "#fed0bb")),
    rising_blues          = avom_colors(name = "rising_blues", type = "sequential",
                               colors = c("#0d1321","#1d2d44","#3e5c76","#f0ebd8"))
  )

  avom_palettes[[palette]]
}

#' Color Palette Generator
#' @description
#' Helper function to generate ggplot2 color palettes.
#' 
#' @param palette Name of the palette.
#' @param direction Order of colors. Set to -1 to reverse the order
#' 
#' @return Function to be used in [avom::scale_colour_avom()] and [avom::scale_fill_avom()].
#' 
#' @examples
#' palette_gen(palette = "catpuccin_latte", direction = 1)

palette_gen <- function(palette = "catpuccin_latte", direction = 1) {
  function(n) {

    if (n > length(avom_palette(palette)@colors))
      warning("Not enough colors in this palette!")

    else {
      all_colors <- avom_palette(palette)@colors
      colors_type = avom_palette(palette)@type

      if(colors_type == "diverging") {all_colors = select_diverging(all_colors, n)}

      all_colors <- if (direction >= 0) all_colors else rev(all_colors)
      color_list <- all_colors[1:n]
    }
  }
}

#' Select Colors from Diverging Palettes
#' 
#' @description
#' Helper function to select colors from diverging palettes in correct order.
#' 
#' @param palette Name of the palette.
#' @param n Number of colors to select.
#' 
#' @return Vector of colors.
#' 
#' @examples select_diverging(palette = c("#264653", "#2a9d8f", "#e9c46a", "#f4a261", "#e76f51"), n = 4)

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
 middle_pos <- ceiling(total_length/2)
 selected_positions <- numeric(n)
 
 # For odd n, ensure we get the middle position
 if (n %% 2 == 1) {
   # Place middle position in the middle of our selection
   middle_index <- ceiling(n/2)
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
   half_n <- n/2
   for (i in 1:half_n) {
     selected_positions[i] <- i
     selected_positions[n-i+1] <- total_length - i + 1
   }
 }
 
 # Sort positions to maintain original color order
 selected_positions <- sort(selected_positions)
 result <- palette[selected_positions]
 
 return(result)
}

#' Scale Color Palette for ggplot2
#' @description
#' Set color palette for ggplot2 color and fill scales.
#' 
#' @param palette Name of the palette.
#' @param direction Order of colors. Set to -1 to reverse the order
#' @param ... Other arguments passed to [ggplot2::discrete_scale()].
#' 
#' @export
#' @return Function to be used together with [ggplot2::ggplot()].
#' 
#' @examples
#' ggplot2::ggplot(data = mtcars,
#'                 mapping = ggplot2::aes(x = mpg, y = hp, color = as.factor(cyl))) +
#'          ggplot2::geom_point() +
#'          avom::scale_colour_avom("catpuccin_latte")

scale_colour_avom <- function(palette = "catpuccin_latte", direction = 1, ...) {
  ggplot2::discrete_scale(
    "colour", "avom",
    palette_gen(palette, direction),
    ...
  )
}

#' @rdname scale_colour_avom
#' @export
scale_fill_avom <- function(palette = "catpuccin_latte", direction = 1, ...) {
  ggplot2::discrete_scale(
    "fill", "avom",
    palette_gen(palette, direction),
    ...
  )
}

#' @rdname scale_colour_avom
#' @export
scale_color_avom <- scale_colour_avom