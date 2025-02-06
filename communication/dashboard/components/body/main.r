suppressMessages({
  import("here")
  import("shiny")
  import("shinydashboard")
  import("slituR")
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "globals", "paths.r"
)
paths <- modules::use(path_paths)

data_clean <- modules::use(paths$path_data_clean_component)
data_corrupts <- modules::use(paths$path_data_corrupts_component)
stats_book <- modules::use(paths$path_stats_book_component)
stats_returns <- modules::use(paths$path_stats_returns_component)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shinydashboard::dashboardBody(
    shinydashboard::tabItems(
      shinydashboard::tabItem(tabName = "data-clean", data_clean$ui(ns("data-clean"))),
      shinydashboard::tabItem(tabName = "data-corrupts", data_corrupts$ui(ns("data-corrupts"))),
      shinydashboard::tabItem(tabName = "stats-book", stats_book$ui(ns("stats-book"))),
      shinydashboard::tabItem(tabName = "stats-returns", stats_returns$ui(ns("stats-returns")))
    )
  )
}



modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    data_clean$server("data-clean")
    data_corrupts$server("data-corrupts")
    stats_book$server("stats-book")
    stats_returns$server("stats-returns")
  })
}
