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


modules::export("path_global_extracter")
path_global_extracter <- here::here(path_main_directory, "globals", "extracter.r")

modules::export("path_local_extracter")
path_local_extracter <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "returns", 
  "globals", "extracter.r"
)


modules::export("path_firms_component")
path_firms_component <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "returns", 
  "firms.r"
)

modules::export("path_aggregate_component")
path_aggregate_component <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "returns", 
  "aggregate.r"
)

modules::export("path_table_component")
path_table_component <- body_global_paths$path_global_table_component


modules::export("filename_intersection_stats_returns_firms")
filename_intersection_stats_returns_firms <- "intersection_firms_return_stats_firms.rds"

modules::export("filename_intersection_stats_returns_aggregate")
filename_intersection_stats_returns_aggregate <- "intersection_firms_return_stats_aggregate.rds"


modules::export("download_filename_intersection_stats_returns_firms")
download_filename_intersection_stats_returns_firms <- paste0(
  "stats - high-availability - returns - firms", body_global_variables$download_filename_extension
)

modules::export("download_filename_intersection_stats_returns_aggregate")
download_filename_intersection_stats_returns_aggregate <- paste0(
  "stats - high-availability - returns - aggregate", body_global_variables$download_filename_extension
)
