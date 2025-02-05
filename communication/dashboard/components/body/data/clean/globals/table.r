suppressMessages(import("shiny"))


path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "clean", "globals", 
  "paths.r"
)
paths <- modules::use(path_paths)

variables <- modules::use(paths$path_variables)
body_table <- modules::use(paths$path_body_table)


modules::export("ui")
ui <- function(id, width = 12L, title = NULL, caption = NULL) {
  ns <- NS(id)
  
  shiny::tagList(
    body_table$ui(id = ns("table"), width = width, title = title, caption = caption)
  )
}

modules::export("server")
server <- function(id, dataset) {
  moduleServer(id, function(input, output, session) {

    body_table$server(
      id = "table", data = dataset, display_rows = variables$number_rows_to_display
    )
  })
}
