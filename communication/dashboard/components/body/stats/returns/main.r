suppressMessages({
  import(here)
  import(shiny)
  import(shinydashboard)
  import(slituR)
})

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "stats", "returns", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::fluidPage(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Return descriptive statistics"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;")))
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {


  })
}
