suppressMessages({
  import(here)
  import(shiny)
  import(shinydashboard)
  import(slituR)
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

book <- modules::use(paths$path_book_component)
returns <- modules::use(paths$path_returns_component)
events <- modules::use(paths$path_events_component)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::fluidPage(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Clean datasets"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Book"))),
    book$ui(ns("book")),
    shiny::br(),
    shiny::fluidRow(
      shiny::column(width = 2L, ""),
      shiny::column(width = 8L, shiny::tags$hr(style = "border-top: 2px solid #000;")),
      shiny::column(width = 2L, "")
    ),
    shiny::br(),
    shiny::fluidRow(
      shiny::column(width = 6L, shiny::h2("Returns")),
      shiny::column(width = 6L, shiny::h2("Events"))
    ),
    shiny::fluidRow(
      shiny::column(width = 6L, returns$ui(ns("returns"))),
      shiny::column(width = 6L, events$ui(ns("events")))
    ),
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    book$server("book")
    returns$server("returns")
    events$server("events")
  })
}
