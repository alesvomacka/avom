.onLoad <- function(libname, pkgname) {

  sysfonts::font_paths("inst/fonts")
  sysfonts::font_add(family = "Fira Sans",
                     regular = "FiraSans-Regular.ttf",
                     bold = "FiraSans-Bold.ttf",
                     italic = "FiraSans-Italic.ttf",
                     bolditalic = "FiraSans-BoldItalic.ttf")
  showtext::showtext_auto()
  showtext::showtext_opts(dpi = 200)

}






