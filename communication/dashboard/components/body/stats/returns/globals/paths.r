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


modules::export("path_global_extracter")
path_global_extracter <- here::here(path_main_directory, "globals", "extracter.r")

modules::export("path_local_extracter")
path_local_extracter <- here::here(
  path_main_directory, "components", "body", "stats", "returns", "globals", "extracter.r"
)

modules::export("path_firms_component")
path_firms_component <- here::here(
  path_main_directory, "components", "body", "stats", "returns", "firms.r"
)

modules::export("path_aggregate_component")
path_aggregate_component <- here::here(
  path_main_directory, "components", "body", "stats", "returns", "aggregate.r"
)

modules::export("path_table_component")
path_table_component <- body_global_paths$path_global_table_component


modules::export("filename_stats_returns_firms")
filename_stats_returns_firms <- "firms.rds"

modules::export("filename_stats_returns_aggregate")
filename_stats_returns_aggregate <- "aggregate.rds"
