suppressMessages({
  import(here)
  import(shiny)
  import(shinydashboard)
  import(slituR)
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", 
  "returns", "globals", "paths.r"
)
paths <- modules::use(path_paths)

firms <- modules::use(paths$path_firms_component)
aggregate <- modules::use(paths$path_aggregate_component)


modules::export("ui")
ui <- function(id) {
  ns <- shiny::NS(id)
  
  shiny::tagList(
    firms$ui(id = ns("availables_returns_firms")),
    shiny::hr(),
    aggregate$ui(id = ns("availables_returns_aggregate"))
  )
}


modules::export("server")
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    
    firms$server(id = "availables_returns_firms")
    aggregate$server(id = "availables_returns_aggregate")
  })
}
