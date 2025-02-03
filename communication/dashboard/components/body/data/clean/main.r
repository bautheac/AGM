suppressMessages(import("here"))
suppressMessages(import("shiny"))
suppressMessages(import("shinydashboard"))
suppressMessages(import("slituR"))

path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

path_book <- here::here(
  path_main_directory, "components", "body", "data", "clean", "book.r"
)
book <- modules::use(path_book)
path_returns <- here::here(
  path_main_directory, "components", "body", "data", "clean", "returns.r"
)
returns <- modules::use(path_returns)
path_events <- here::here(
  path_main_directory, "components", "body", "data", "clean", "events.r"
)
events <- modules::use(path_events)


modules::export("ui")
ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::fluidPage(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Clean datasets"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(shiny::column(width = 12L, book$ui(ns("book")))),
    shiny::br(),  
    shiny::br(),  
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