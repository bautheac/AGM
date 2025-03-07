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
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "book", 
  "globals", "variables.r"
)


modules::export("path_global_extracter")
path_global_extracter <- here::here(
  path_main_directory, "globals", "extracter.r"
)

modules::export("path_local_extracter")
path_local_extracter <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "book", 
  "globals", "extracter.r"
)

modules::export("path_table_component")
path_table_component <- body_global_paths$path_global_table_component

modules::export("path_unformatted_component")
path_unformatted_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "book", 
  "unformatted.r"
)

modules::export("path_formatted_component")
path_formatted_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "book", 
  "formatted.r"
)



modules::export("filename_corrupts_book_sorted_unformatted_dataset")
filename_corrupts_book_sorted_unformatted_dataset <- "corrupts_book_unformatted.rds"

modules::export("filename_corrupts_book_sorted_formatted_dataset")
filename_corrupts_book_sorted_formatted_dataset <- "corrupts_book_formatted.rds"


modules::export("download_filename_corrupts_book_sorted_unformatted_dataset")
download_filename_corrupts_book_sorted_unformatted_dataset <- paste0(
  "corrupts - sorted - book - unformatted", body_global_variables$download_filename_extension
)

modules::export("download_filename_corrupts_book_sorted_formatted_dataset")
download_filename_corrupts_book_sorted_formatted_dataset <- paste0(
  "corrupts - sorted - book - formatted", body_global_variables$download_filename_extension
)
