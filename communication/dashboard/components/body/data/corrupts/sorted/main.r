suppressMessages({
  import("shiny")
  import("shinydashboard")
})

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "corrupts", "sorted",
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

book <- modules::use(paths$path_book)
events <- modules::use(paths$path_events)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Sorted"))),
    shiny::fluidRow(shiny::column(width = 6L, shiny::tags$hr(style = "border-top: 2px solid #000;"))),
    shiny::fluidRow(shiny::column(width = 12L, book$ui(ns("sorted_book_component")))),
    shiny::br(), shiny::br(),
    shiny::fluidRow(shiny::column(width = 12L, events$ui(ns("sorted_events_component"))))
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    book$server("sorted_book_component")
    events$server("sorted_events_component")
  })
}
