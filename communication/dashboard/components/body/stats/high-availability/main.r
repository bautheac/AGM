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
  path_main_directory, "components", "body", "stats", "high-availability", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

names <- modules::use(paths$path_names_component)
book <- modules::use(paths$path_book_component)
returns <- modules::use(paths$path_returns_component)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("High data availability firms' descritive statistics"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Names"))),
    shiny::fluidRow(shiny::column(width = 6L, shiny::tags$hr(style = "border-top: 2px solid #000;"))),
    names$ui(ns("availables_names")),
    shiny::br(), shiny::br(), shiny::br(),
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Book descriptive statistics"))),
    shiny::fluidRow(shiny::column(width = 6L, shiny::tags$hr(style = "border-top: 2px solid #000;"))),
    book$ui(ns("availables_book")),
    shiny::br(), shiny::br(), shiny::br(),
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Returns descriptive statistics"))),
    shiny::fluidRow(shiny::column(width = 6L, shiny::tags$hr(style = "border-top: 2px solid #000;"))),
    returns$ui(ns("availables_returns"))

  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

    names$server("availables_names")
    book$server("availables_book")
    returns$server("availables_returns")
  })
}
