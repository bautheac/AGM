suppressMessages(import("shiny"))

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

variables <- modules::use(paths$path_variables)
global_table_component <- modules::use(paths$path_global_table_component)


modules::export("ui")
ui <- function(id, width = 12L, title = NULL, caption = NULL) {
  ns <- NS(id)

  shiny::tagList(
    global_table_component$ui(id = ns("table"), width = width, title = title, caption = caption)
  )
}

modules::export("server")
server <- function(id, dataset) {
  moduleServer(id, function(input, output, session) {
    global_table_component$server(
      id = "table", data = dataset, display_rows = variables$number_rows_to_display
    )
  })
}
