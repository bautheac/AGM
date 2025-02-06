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
  path_main_directory, "components", "body", "data", "corrupts", "pending", 
  "globals", "extracter.r"
)


modules::export("path_table_component")
path_table_component <- body_global_paths$path_global_table_component

modules::export("path_book_component")
path_book_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "pending", 
  "book.r"
)


modules::export("filename_corrupts_book_pending_dataset")
filename_corrupts_book_pending_dataset <- "corrupts_book_pending.rds"
