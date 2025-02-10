suppressMessages({
  import("here")
  import("shiny")
  import("slituR")
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted",
  "book", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_local_extracter)
table <- modules::use(paths$path_table_component)
variables <- modules::use(paths$path_local_variables)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)

  table$ui(ns("sorted_book_formatted_table"), 12L, "Formatted", variables$caption_formatted)
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    table$server(
      id = "sorted_book_formatted_table", data = extracter$extract_corrupts_book_sorted_formatted_dataset(), 
      display_rows = NULL, filename = paths$download_filename_corrupts_book_sorted_formatted_dataset
    )
  })
}
