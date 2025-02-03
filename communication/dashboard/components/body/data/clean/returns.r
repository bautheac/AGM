suppressMessages(import("here"))
suppressMessages(import("shiny"))
suppressMessages(import("slituR"))

path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

path_extracter <- here::here(path_main_directory, "globals", "extracter.r")
extracter <- modules::use(path_extracter)
path_table <- here::here(path_main_directory, "components", "body", "globals", "table", "main.r")
table <- modules::use(path_table)


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