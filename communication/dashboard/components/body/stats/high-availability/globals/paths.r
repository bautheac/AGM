suppressMessages({
  import(here)
  import(slituR)
})


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
  path_main_directory, "components", "body", "stats", "high-availability", "globals", 
  "variables.r"
)

modules::export("path_global_extracter")
path_global_extracter <- here::here(path_main_directory, "globals", "extracter.r")

modules::export("path_local_extracter")
path_local_extracter <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "globals", 
  "extracter.r"
)


modules::export("path_names_component")
path_names_component <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "names.r"
)

modules::export("path_book_component")
path_book_component <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "book.r"
)

modules::export("path_returns_component")
path_returns_component <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "returns", 
  "main.r"
)

modules::export("path_table_component")
path_table_component <- body_global_paths$path_global_table_component

modules::export("path_global_caption_component")
path_global_caption_component <- body_global_paths$path_global_caption_component


modules::export("filename_intersection_names")
filename_intersection_names <- "intersection_firms_names.rds"

modules::export("filename_intersection_stats_book")
filename_intersection_stats_book <- "intersection_firms_book_stats.rds"


modules::export("download_filename_intersection_names")
download_filename_intersection_names <- paste0(
  "stats - high-availability - names", body_global_variables$download_filename_extension
)

modules::export("download_filename_intersection_stats_book")
download_filename_intersection_stats_book <- paste0(
  "stats - high-availability - book", body_global_variables$download_filename_extension
)