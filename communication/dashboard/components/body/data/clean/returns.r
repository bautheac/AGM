suppressMessages({ import("here"); import("shiny"); import("slituR")})

path_paths <- here::here(
  "communication", "dashboard", "components", "body", "data", "clean", "globals", 
  "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_extracter)
table <- modules::use(paths$path_table)


modules::export("ui")
ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  table$ui(ns("returns"), 12L, "Returns")
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    table$server("returns", extracter$extract_returns_dataset())
  })
}