suppressMessages({
  import("here")
  import("shiny")
  import("slituR")
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "pending",
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

variables <- modules::use(paths$path_local_variables)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)
  
  shiny::tagList(
    shiny::h3("Miscellaneous"),
    shiny::br(), shiny::br(), shiny::br(),
    shiny::tags$p(
      shiny::HTML(variables$miscellaneous_text),
      style = "font-size: 16px; font-weight: semi-bold; line-height: 1.5; text-align: justify;"
    )
  
  )
}


modules::export("server")
server <- function(id) { shiny::moduleServer(id, function(input, output, session) {})}
