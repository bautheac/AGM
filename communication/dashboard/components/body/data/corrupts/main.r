suppressMessages({
  import("shiny")
  import("shinydashboard")
})


path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "corrupts", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

pending <- modules::use(paths$path_pending)
sorted <- modules::use(paths$path_sorted)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::fluidPage(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Corrupt records"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(shiny::column(width = 6L, pending$ui(ns("pending")))),
    shiny::br(), shiny::br(), shiny::br(),
    shiny::fluidRow(shiny::column(width = 12L, sorted$ui(ns("sorted"))))
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    pending$server("pending")
    sorted$server("sorted")
  })
}
