suppressMessages(import("here"))


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")


modules::export("path_extracter")
path_extracter <- here::here(path_main_directory, "globals", "extracter.r")

modules::export("path_table")
path_table <- here::here(
  path_main_directory, "components", "body", "globals", "table", "main.r"
)

modules::export("path_book")
path_book <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", 
  "book", "main.r"
)

modules::export("path_events")
path_events <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", 
  "events", "main.r"
)