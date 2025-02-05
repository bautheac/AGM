suppressMessages({ import("shiny"); import("shinydashboard") })

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "corrupts", "sorted", 
  "book", "globals", "paths.r"
)
paths <- modules::use(path_paths)

unformatted <- modules::use(paths$path_unformatted)
formatted <- modules::use(paths$path_formatted)


modules::export("ui")
ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h3("Book"))),
    shiny::fluidRow(shiny::column(width = 3L, shiny::tags$hr(style = "border-top: 1px solid #000;"))),
    shiny::fluidRow(
      shiny::column(width = 6L, unformatted$ui(ns("sorted_book_unformatted_component"))),
      shiny::column(width = 6L, formatted$ui(ns("sorted_book_formatted_component")))
    ),
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    unformatted$server("sorted_book_unformatted_component")
    formatted$server("sorted_book_formatted_component")
  })
}