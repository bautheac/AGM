suppressMessages({
  import("shiny")
  import("shinydashboard")
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

pending <- modules::use(paths$path_pending_component)
sorted <- modules::use(paths$path_sorted_component)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::fluidPage(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Corrupt records"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(shiny::column(width = 6L, pending$ui(ns("pending")))),
    shiny::br(), shiny::br(), shiny::br(),
    sorted$ui(ns("sorted"))
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    pending$server("pending")
    sorted$server("sorted")
  })
}
