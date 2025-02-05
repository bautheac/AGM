suppressMessages({
  import("here")
  import("shiny")
  import("shinydashboard")
  import("slituR")
})

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "globals", "paths.r"
)
paths <- modules::use(path_paths)

data_clean <- modules::use(paths$path_data_clean)
data_corrupts <- modules::use(paths$path_data_corrupts)
stats_book <- modules::use(paths$path_stats_book)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  shinydashboard::dashboardBody(
    shinydashboard::tabItems(
      shinydashboard::tabItem(tabName = "data-clean", data_clean$ui(ns("data-clean"))),
      shinydashboard::tabItem(tabName = "data-corrupts", data_corrupts$ui(ns("data-corrupts"))),
      shinydashboard::tabItem(tabName = "stats-book", stats_book$ui(ns("stats-book")))
    )
  )
}



modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    data_clean$server("data-clean")
    data_corrupts$server("data-corrupts")
    stats_book$server("stats-book")
  })
}
