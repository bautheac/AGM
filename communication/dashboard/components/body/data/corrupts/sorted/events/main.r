suppressMessages({
  import("here")
  import("shiny")
  import("shinydashboard")
})

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "corrupts", "sorted",
  "events", "globals", "paths.r"
)
paths <- modules::use(path_paths)

corrupts <- modules::use(paths$path_corrupts)
missings <- modules::use(paths$path_missings)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h3("Events"))),
    shiny::fluidRow(shiny::column(width = 3L, shiny::tags$hr(style = "border-top: 1px solid #000;"))),
    shiny::fluidRow(
      shiny::column(width = 6L, corrupts$ui(ns("sorted_events_corrupts_component"))),
      shiny::column(width = 6L, missings$ui(ns("sorted_events_missings_component")))
    ),
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    corrupts$server("sorted_events_corrupts_component")
    missings$server("sorted_events_missings_component")
  })
}
