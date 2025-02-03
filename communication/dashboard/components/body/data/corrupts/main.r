suppressMessages(import("shiny"))
suppressMessages(import("shinydashboard"))


modules::export("ui")
ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::fluidPage(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Corrupt records"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

  })
}