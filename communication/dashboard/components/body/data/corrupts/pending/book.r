suppressMessages({ import("here"); import("shiny"); import("slituR") })

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "corrupts", "pending", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_extracter)
table <- modules::use(paths$path_table)


modules::export("ui")
ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  table$ui(ns("pending_book_table"), 12L, "Book")
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    table$server("pending_book_table", extracter$extract_corrupts_book_pending_dataset())
  })
}