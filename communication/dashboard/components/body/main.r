suppressMessages(import("here"))
suppressMessages(import("shiny"))
suppressMessages(import("shinydashboard"))
suppressMessages(import("slituR"))


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

path_data_clean <- 
  here::here(path_main_directory, "components", "body", "data", "clean", "main.r")
data_clean <- modules::use(path_data_clean)
path_data_corrupts <- 
  here::here(path_main_directory, "components", "body", "data", "corrupts", "main.r")
data_corrupts <- modules::use(path_data_clean)


modules::export("ui")
ui <- function(id){
  
  ns <- shiny::NS(id)

  shinydashboard::dashboardBody(
    shinydashboard::tabItems(
      shinydashboard::tabItem(tabName = "data-clean", data_clean$ui(ns("data-clean"))),
      shinydashboard::tabItem(tabName = "data-corrupts", data_corrupts$ui(ns("data-corrupts")))
    )
  )
}



modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    # data$server("data")
    data_clean$server("data-clean")
    data_corrupts$server("data-corrupts")
  })
}