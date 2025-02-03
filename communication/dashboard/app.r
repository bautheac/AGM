path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

path_header <- here::here(path_main_directory, "components", "header", "main.r")
header <- modules::use(path_header)

path_sidebar <- here::here(path_main_directory, "components", "sidebar", "main.r")
sidebar <- modules::use(path_sidebar)

path_body <- here::here(path_main_directory, "components", "body", "main.r")
body <- modules::use(path_body)

path_global_variables <- here::here(
  path_main_directory, "components", "globals", "variables.r"
)
global_variables <- modules::use(path_global_variables)


ui <- shinydashboard::dashboardPage(
  header$ui(),
  sidebar$ui(),
  body$ui("body"),
  skin = global_variables$skin
)


server <- function(input, output, session) {
  
  body$server("body")
}

shiny::shinyApp(ui, server)