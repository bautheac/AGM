suppressMessages({ import(here); import(slituR) })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

modules::export("path_extracter")
path_extracter <- here::here(path_main_directory, "globals", "extracter.r")


modules::export("path_book_component")
path_book_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", 
  "book", "main.r"
)

modules::export("path_events_component")
path_events_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", 
  "events", "main.r"
)
