suppressMessages(modules::import(here))


modules::export("path_data_extracter")
path_data_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)

modules::export("path_names_data_transformer")
path_names_data_transformer <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "names", "transformer",
  "main.r"
)

modules::export("path_data_loader")
path_data_loader <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
)


path_global_paths <- here::here("computations", "R", "scripts", "globals", "paths.r")
global_paths <- modules::use(path_global_paths)


modules::export("filepath_clean_names_data_main")
filepath_clean_names_data_main <- here::here(
  global_paths$path_data_directory, "names_clean.rds"
)

modules::export("filepath_clean_names_data_dashboard")
filepath_clean_names_data_dashboard <- here::here(
  global_paths$path_dashboard_directory_datasets, "names_clean.rds"
)
