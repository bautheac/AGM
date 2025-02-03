modules::export("rownames")
rownames <- FALSE

modules::export("extensions")
extensions <- c('Buttons')

modules::export("options")
options <- function(filename){
  list(
    scrollX = TRUE,          # Enables horizontal scrolling
    scrollY = "600px",       # Enables vertical scrolling with a fixed height of 400px
    paging = FALSE,          # Enables pagination
    pageLength = 20,         # Sets the default number of rows visible to 20
    lengthMenu = c(10, 20, 50, 100),  # Dropdown menu for users to adjust rows visible
    autoWidth = TRUE,        # Automatically adjusts column widths
    dom = 'Bfrtip',
    buttons = list(
      list(
        extend = "csv",               # Export format
        text = "download as .csv",    # Button text
        filename = filename           # CSV filename
      )
    ),   # Enables the "Download as CSV" button
    columnDefs = list(list(width = '150px', targets = "_all"))
  )
}

modules::export("class")
class <- "display nowrap"  # Prevents column content wrapping

modules::export("escape")
escape <- FALSE 