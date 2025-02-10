suppressMessages({
  import("shiny")
  import("shinydashboard")
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "pending",
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

book <- modules::use(paths$path_book_component)
miscellaneous <- modules::use(paths$path_miscellaneous_component)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tagList(
    shiny::fluidRow(shiny::column(width = 12L, shiny::h2("Pending"))),
    shiny::fluidRow(shiny::column(width = 6L, shiny::tags$hr(style = "border-top: 2px solid #000;"))),
    shiny::fluidRow(
      shiny::column(width = 6L, book$ui(ns("pending_book_component"))),
      shiny::column(width = 6L, miscellaneous$ui(ns("pending_miscellaneous_component")))
    )
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    book$server("pending_book_component")
  })
}
