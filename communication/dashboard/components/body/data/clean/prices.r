suppressMessages({
  import("here")
  import("shiny")
  import("slituR")
})


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_local_extracter)
table <- modules::use(paths$path_table_component)
variables <- modules::use(paths$path_local_variables)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  table$ui(ns("prices"), 12L, "", variables$caption_prices)
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    table$server("prices", extracter$extract_prices_dataset(), paths$download_filename_prices_dataset)
  })
}
