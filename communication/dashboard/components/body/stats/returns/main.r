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
  path_main_directory, "components", "body", "stats", "returns", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

firms <- modules::use(paths$path_firms_component)
aggregate <- modules::use(paths$path_aggregate_component)
caption <- modules::use(paths$path_global_caption_component)
variables <- modules::use(paths$path_local_variables)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Returns descriptive statistics"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(column(12L, caption$ui(ns("stats_returns_caption"), variables$caption_returns))),
    shiny::br(),
    shiny::fluidRow(
      shiny::column(width = 2L, ""),
      shiny::column(width = 8L, shiny::tags$hr(style = "border-top: 2px solid #000;")),
      shiny::column(width = 2L, "")
    ),
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Firms"))),
    firms$ui(ns("stats-returns-firms")),
    shiny::br(), shiny::br(), shiny::br(),
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Aggregate"))),
    aggregate$ui(ns("stats-returns-aggregate")),
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    firms$server("stats-returns-firms")
    aggregate$server("stats-returns-aggregate")
  })
}
