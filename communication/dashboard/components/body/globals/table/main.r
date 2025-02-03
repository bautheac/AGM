suppressMessages(import("DT"))
suppressMessages(import("shiny"))



modules::export("ui")
ui <- function(id, width, title = NULL, caption = NULL) {
  
  ns <- shiny::NS(id)
  
  shiny::tagList(
    if (!is.null(title)) {
      shiny::tagList(
        shiny::fluidRow(shiny::column(width = width, shiny::h3(title))),
        shiny::br()
      )
    },
    if (!is.null(caption)) {
      shiny::fluidRow(shiny::column(width = width, shiny::tags$p(caption)))
    },
    shiny::fluidRow(shiny::column(width = width, DT::dataTableOutput(ns("table"))))
  )
}


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

path_globals <- here::here(
  path_main_directory, "components", "body", "globals", "table", "globals.r"
)
globals <- modules::use(path_globals)

modules::export("server")
server <- function(id, data) {
  shiny::moduleServer(id, function(input, output, session) {
    
    ns <- shiny::NS(id)

    output$table <- DT::renderDataTable({

      DT::datatable(
        if (shiny::is.reactive(data)) { data() } else { data },
        rownames = globals$rownames,
        extensions = globals$extensions,
        options = globals$options(id),
        class = globals$class,
        escape = globals$escape
      )
    })
  })
}


