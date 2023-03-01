.onLoad <- function(libname, pkgname) {

  systemfonts::register_font(name = "Fira-Sans",
                             plain = system.file("fonts", "FiraSans-Regular.ttf", package = "avom"),
                             bold = system.file("fonts", "FiraSans-Bold.ttf", package = "avom"),
                             bolditalic = system.file("fonts", "FiraSans-BoldItalic.ttf", package = "avom"),
                             italic = system.file("fonts", "FiraSans-Italic.ttf", package = "avom"))

}






