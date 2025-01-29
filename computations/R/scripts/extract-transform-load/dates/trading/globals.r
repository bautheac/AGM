pacman::p_load(here, modules)


path_global_paths <- here::here("computations", "R", "scripts", "globals", "paths.r")
global_paths <- modules::use(path_global_paths)


modules::export("filepath_clean_dates_trading_main")
filepath_clean_dates_trading_main <- here::here(
  global_paths$path_data_directory, "dates_trading_clean.rds"
) 

modules::export("filepath_clean_dates_trading_dashboard")
filepath_clean_dates_trading_dashboard <- here::here(
  global_paths$path_dashboard_directory_datasets, "dates_trading_clean.rds"
) 
