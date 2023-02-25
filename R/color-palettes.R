avom_palettes <- function(palette = "gruvbox_light", n = NA) {

   if(!is.na(n) & !is.numeric(n)) stop("n has to be an integer")
   if(!is.na(n) & (n < 1L)) stop("n has to be positive integer")

  palettes <- list(
    gruvbox_light = c("#fb4934", "#b8bb26", "#83a598", "#fabd2f", "#d3869b", "#8ec07c", "#fe8019"),
    gruvbox_dark  = c("#cc241d", "#98971a", "#458588", "#d79921", "#b16286", "#689d6a", "#d65d0e")
    )

  if(!is.na(n) & (n > length(palettes[[palette]])) ) stop("Not enough colors in the palette")

  if (!is.na(n)) {
    palettes[[palette]][1:n]
  } else {
    palettes[[palette]]
  }

}
