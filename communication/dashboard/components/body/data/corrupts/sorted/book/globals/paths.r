suppressMessages(import("here"))


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")


modules::export("path_extracter")
path_extracter <- here::here(path_main_directory, "globals", "extracter.r")

modules::export("path_table")
path_table <- here::here(
  path_main_directory, "components", "body", "globals", "table", "main.r"
)

modules::export("path_unformatted")
path_unformatted <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "book", 
  "unformatted.r"
)

modules::export("path_formatted")
path_formatted <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "book", 
  "formatted.r"
)

