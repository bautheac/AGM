suppressMessages({ import("DT"); import("utils"); import("shiny") })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_globals <- here::here(
  path_main_directory, "components", "body", "globals", "table", "globals.r"
)
globals <- modules::use(path_globals)


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
    shiny::fluidRow(
      shiny::column(
        width = width,
        div(
          style = "display: flex; justify-content: space-between; align-items: center;",
          span(),
          shiny::downloadButton(ns("download"), label = "download full dataset as .csv", class = "btn-secondary")
        )
      )
    ),
    shiny::fluidRow(shiny::column(width = width, DT::dataTableOutput(ns("table"))))
  )
}


modules::export("server")
server <- function(id, data, display_rows = NULL, filename = paste0("AGM - ", Sys.time(), ".csv")) {
  shiny::moduleServer(id, function(input, output, session) {
    
    ns <- shiny::NS(id)
    
    displayed_data <- reactive({
      if (is.null(display_rows)) {
        
        if (shiny::is.reactive(data)) { data() } else { data }
      } else {
        
        if (shiny::is.reactive(data)) { data() } else { utils::head(data, display_rows) }
      }
    })

    output$table <- DT::renderDataTable({

      DT::datatable(
        displayed_data(),
        width = globals$width,
        rownames = globals$rownames,
        options = globals$options,
        class = globals$class,
        escape = globals$escape
      )
    })
    
    downloaded_data <- reactive({ if (shiny::is.reactive(data)) { data() } else { data } })
    
    output$download <- downloadHandler(
      filename = filename,
      content = function(file) { write.csv(downloaded_data(), file, row.names = FALSE)}
    )
  })
}


