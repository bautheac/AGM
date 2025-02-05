suppressMessages({ import(here); import(shiny); import(shinydashboard); import(slituR) })

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "stats", "book", "globals", 
  "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_extracter)
table <- modules::use(paths$path_table)


modules::export("ui")
ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::fluidPage(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Book descriptive statistics"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(shiny::column(width = 12L, table$ui(ns("book-stats"), 12L, ""))),
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    table$server("book-stats", extracter$extract_stats_book_by_reporting_period())
  })
}