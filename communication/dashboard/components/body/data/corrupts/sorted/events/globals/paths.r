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
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "events", 
  "globals", "extracter.r"
)

modules::export("path_table_component")
path_table_component <- body_global_paths$path_global_table_component

modules::export("path_corrupts_component")
path_corrupts_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "events", 
  "corrupts.r"
)

modules::export("path_missings_component")
path_missings_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "events", 
  "missings.r"
)



modules::export("filename_corrupts_events_sorted_missings_dataset")
filename_corrupts_events_sorted_missings_dataset <- "corrupts_events_missings.rds"

modules::export("filename_corrupts_events_sorted_corrupts_dataset")
filename_corrupts_events_sorted_corrupts_dataset <- "corrupts_events_records.rds"


modules::export("download_filename_corrupts_events_sorted_missings_dataset")
download_filename_corrupts_events_sorted_missings_dataset <- paste0(
  "corrupts - sorted - events - missings", body_global_variables$download_filename_extension
)

modules::export("download_filename_corrupts_events_sorted_corrupts_dataset")
download_filename_corrupts_events_sorted_corrupts_dataset <- paste0(
  "corrupts - sorted - events - corrupts", body_global_variables$download_filename_extension
)