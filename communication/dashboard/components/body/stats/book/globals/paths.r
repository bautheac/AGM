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


modules::export("path_global_extracter")
path_global_extracter <- here::here(
  path_main_directory, "globals", "extracter.r"
)

modules::export("path_local_extracter")
path_local_extracter <- here::here(
  path_main_directory, "components", "body", "stats", "book", "globals", "extracter.r"
)

modules::export("path_table_component")
path_table_component <- body_global_paths$path_global_table_component


modules::export("filename_stats_book_by_reporting_period")
filename_stats_book_by_reporting_period <- "statistics-by-reporting-frequency.rds"


modules::export("download_filename_stats_book_by_reporting_period")
download_filename_stats_book_by_reporting_period <- paste0(
  "stats - book", body_global_variables$download_filename_extension
)