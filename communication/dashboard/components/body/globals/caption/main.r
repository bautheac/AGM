suppressMessages({
  import(here)
  import(shiny)
  import(slituR)
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_globals <- here::here(
  path_main_directory, "components", "body", "globals", "caption", "globals.r"
)
globals <- modules::use(path_globals)


modules::export("ui")
ui <- function(id, text) {
  ns <- shiny::NS(id)
  
  shiny::tagList( shiny::tags$p(shiny::HTML(text), style = globals$style))
}