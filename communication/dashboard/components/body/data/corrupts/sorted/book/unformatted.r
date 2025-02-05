suppressMessages({ import("here"); import("shiny"); import("slituR") })

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "corrupts", "sorted", 
  "book", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_extracter)
table <- modules::use(paths$path_table)


modules::export("ui")
ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  table$ui(ns("sorted_book_unformatted_table"), 12L, "Unformatted")
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    table$server("sorted_book_unformatted_table", extracter$extract_corrupts_book_sorted_unformatted_dataset())
  })
}