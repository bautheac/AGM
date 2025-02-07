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
  path_main_directory, "components", "body", "stats", "high-availability", 
  "returns", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_local_extracter)
table <- modules::use(paths$path_table_component)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)
  
  shiny::fluidPage(
    table$ui(ns("stats_availables_returns_aggregate"), 12L, "Aggregate")
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    table$server(
      id = "stats_availables_returns_aggregate", data = extracter$extract_stats_availables_returns_aggregate(), 
      display_rows = NULL, filename = paths$download_filename_intersection_stats_returns_aggregate
    )
  })
}
