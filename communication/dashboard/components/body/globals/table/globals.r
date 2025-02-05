modules::export("width")
width <- "100%"

modules::export("rownames")
rownames <- FALSE

modules::export("extensions")
extensions <- c('Buttons')

modules::export("class")
class <- "display nowrap"  # Prevents column content wrapping

modules::export("escape")
escape <- FALSE 


modules::export("options")
options <- list(
  scrollX = TRUE,                   # Enables horizontal scrolling
  scrollY = "600px",                # Enables vertical scrolling with a fixed height of 400px
  paging = FALSE,                   # Enables pagination
  pageLength = 20,                  # Sets the default number of rows visible to 20
  lengthMenu = c(10, 20, 50, 100),  # Dropdown menu for users to adjust rows visible
  # autoWidth = TRUE,                 # Automatically adjusts column widths
  dom = 'tr'                           
  # columnDefs = list(list(width = '150px', targets = "_all"))
)