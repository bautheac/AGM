pacman::p_load(here, modules)


path_etl_global_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "paths.r"
) 
etl_global_paths <- modules::use(path_etl_global_paths)
path_global_paths <- here::here("computations", "R", "scripts", "globals", "paths.r")
global_paths <- modules::use(path_global_paths)


modules::export("filepath_clean_book_data_main")
filepath_clean_book_data_main <- here::here(
  etl_global_paths$path_data_directory, "book_clean.rds"
) 

modules::export("filepath_clean_book_data_dashboard")
filepath_clean_book_data_dashboard <- here::here(
  global_paths$path_dashboard_directory, "book_clean.rds"
) 

