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
  path_main_directory, "components", "body", "stats", "book", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_local_extracter)
table <- modules::use(paths$path_table_component)
caption <- modules::use(paths$path_global_caption_component)
variables <- modules::use(paths$path_local_variables)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h1("Book descriptive statistics"))),
    shiny::fluidRow(shiny::column(width = 12L, shiny::tags$hr(style = "border-top: 3px solid #000;"))),
    shiny::fluidRow(column(12L, caption$ui(ns("stats_book_caption"), variables$caption_book))),
    shiny::br(),
    shiny::fluidRow(
      shiny::column(width = 2L, ""),
      shiny::column(width = 8L, shiny::tags$hr(style = "border-top: 2px solid #000;")),
      shiny::column(width = 2L, "")
    ),
    table$ui(ns("book-stats"), 12L, "")
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    table$server(
      id = "book-stats", data = extracter$extract_stats_book_by_reporting_period(), 
      display_rows = NULL, filename = paths$download_filename_stats_book_by_reporting_period
    )
  })
}
