suppressMessages({ import(here); import(slituR) })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_body_global_paths <- here::here(
  path_main_directory, "components", "body", "globals", "paths.r"
)
body_global_paths <- modules::use(path_body_global_paths)

path_body_global_variables <- here::here(
  path_main_directory, "components", "body", "globals", "variables.r"
)
body_global_variables <- modules::use(path_body_global_variables)

modules::export("path_local_variables")
path_local_variables <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "pending", 
  "globals", "variables.r"
)



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

modules::export("path_miscellaneous_component")
path_miscellaneous_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "pending", 
  "miscellaneous.r"
)


modules::export("filename_corrupts_book_pending_dataset")
filename_corrupts_book_pending_dataset <- "corrupts_book_pending.rds"

modules::export("download_filename_corrupts_book_pending_dataset")
download_filename_corrupts_book_pending_dataset <- paste0(
  "corrupts - pending - book", body_global_variables$download_file_extension
)