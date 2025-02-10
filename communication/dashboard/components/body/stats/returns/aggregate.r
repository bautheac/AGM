suppressMessages({
  import("here")
  import("shiny")
  import("slituR")
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "stats", "returns", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_local_extracter)
table <- modules::use(paths$path_table_component)
variables <- modules::use(paths$path_local_variables)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)
  
  table$ui(ns("stats_returns_aggregate"), 12L, "", variables$caption_aggregate)
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    table$server(
      id = "stats_returns_aggregate", data = extracter$extract_stats_returns_aggregate(), 
      display_rows = NULL, filename = paths$download_filename_stats_returns_aggregate
    )
  })
}
