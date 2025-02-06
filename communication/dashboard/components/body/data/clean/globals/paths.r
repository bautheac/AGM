suppressMessages({ import(here); import(slituR) })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_body_global_paths <- here::here(
  path_main_directory, "components", "body", "globals", "paths.r"
)
body_global_paths <- modules::use(path_body_global_paths)

modules::export("path_global_extracter")
path_global_extracter <- here::here(
  path_main_directory, "globals", "extracter.r"
)

modules::export("path_local_extracter")
path_local_extracter <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals", "extracter.r"
)

modules::export("path_table_component")
path_table_component <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals", "table.r"
)

modules::export("path_variables")
path_variables <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals", "variables.r"
)

modules::export("path_global_table_component")
path_global_table_component <- body_global_paths$path_global_table_component

modules::export("path_book_component")
path_book_component <- here::here(
  path_main_directory, "components", "body", "data", "clean", "book.r"
)

modules::export("path_returns_component")
path_returns_component <- here::here(
  path_main_directory, "components", "body", "data", "clean", "returns.r"
)

modules::export("path_events_component")
path_events_component <- here::here(
  path_main_directory, "components", "body", "data", "clean", "events.r"
)




modules::export("filename_book_dataset")
filename_book_dataset <- "book_clean.rds"

modules::export("filename_returns_dataset")
filename_returns_dataset <- "returns_clean.rds"

modules::export("filename_events_dataset")
filename_events_dataset <- "events_clean.rds"

