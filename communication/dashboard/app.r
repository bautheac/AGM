path_paths <- here::here("communication", "dashboard", "globals", "paths.r")
paths <- modules::use(path_paths)

header <- modules::use(paths$path_header)
sidebar <- modules::use(paths$path_sidebar)
body <- modules::use(paths$path_body)
global_variables <- modules::use(paths$path_global_variables)


ui <- shinydashboard::dashboardPage(
  header$ui(),
  sidebar$ui(),
  body$ui("body"),
  skin = global_variables$skin
)


server <- function(input, output, session) { body$server("body") }


shiny::shinyApp(ui, server)