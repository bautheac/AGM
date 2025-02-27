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
  path_main_directory, "components", "body", "data", "clean", "globals", "paths.r"
)
paths <- modules::use(path_paths)

book <- modules::use(paths$path_book_component)
prices <- modules::use(paths$path_prices_component)
returns <- modules::use(paths$path_returns_component)
events <- modules::use(paths$path_events_component)
caption <- modules::use(paths$path_global_caption_component)
variables <- modules::use(paths$path_local_variables)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Clean datasets"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(column(12L, caption$ui(ns("data_clean_caption"), variables$caption_clean))),
    shiny::br(),
    shiny::fluidRow(
      shiny::column(width = 2L, ""),
      shiny::column(width = 8L, shiny::tags$hr(style = "border-top: 2px solid #000;")),
      shiny::column(width = 2L, "")
    ),
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
      shiny::column(width = 6L, shiny::h2("Prices")),
      shiny::column(width = 6L, shiny::h2("Returns"))
    ),
    shiny::fluidRow(
      shiny::column(width = 6L, prices$ui(ns("prices"))),
      shiny::column(width = 6L, returns$ui(ns("returns")))
    ),
    shiny::br(),
    shiny::fluidRow(shiny::column(width = 6L, shiny::h2("Events"))),
    shiny::fluidRow(shiny::column(width = 6L, events$ui(ns("events")))),
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    book$server("book")
    prices$server("prices")
    returns$server("returns")
    events$server("events")

  })
}