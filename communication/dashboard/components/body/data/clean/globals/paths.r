suppressMessages(import(here))


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

modules::export("path_extracter")
path_extracter <- here::here(path_main_directory, "globals", "extracter.r")

modules::export("path_table")
path_table <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals", "table.r"
)

modules::export("path_variables")
path_variables <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals", "variables.r"
)

modules::export("path_body_table")
path_body_table <- here::here(
  path_main_directory, "components", "body", "globals", "table", "main.r"
)

modules::export("path_book")
path_book <- here::here(
  path_main_directory, "components", "body", "data", "clean", "book.r"
)

modules::export("path_returns")
path_returns <- here::here(
  path_main_directory, "components", "body", "data", "clean", "returns.r"
)

modules::export("path_events")
path_events <- here::here(
  path_main_directory, "components", "body", "data", "clean", "events.r"
)