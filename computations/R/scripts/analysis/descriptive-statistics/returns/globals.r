pacman::p_load(here, modules)

path_descriptive_stats_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "paths.r"
)
descriptive_stats_paths <- modules::use(path_descriptive_stats_paths)


directory_name <- "returns"
firms_filename <- "firms.rds"
aggregate_filename <- "aggregate.rds"


modules::export("path_returns_firms_descriptive_stats_results_main")
path_returns_firms_descriptive_stats_results_main <- here::here(
  descriptive_stats_paths$path_descriptive_stats_results_directory_main, directory_name, 
  firms_filename
)

modules::export("path_returns_firms_descriptive_stats_results_dashboard")
path_returns_firms_descriptive_stats_results_dashboard <- here::here(
  descriptive_stats_paths$path_descriptive_stats_results_directory_dashboard, 
  directory_name, firms_filename
)

modules::export("path_returns_aggregate_descriptive_stats_results_main")
path_returns_aggregate_descriptive_stats_results_main <- here::here(
  descriptive_stats_paths$path_descriptive_stats_results_directory_main, 
  directory_name, aggregate_filename
)

modules::export("path_returns_aggregate_descriptive_stats_results_dashboard")
path_returns_aggregate_descriptive_stats_results_dashboard <- here::here(
  descriptive_stats_paths$path_descriptive_stats_results_directory_dashboard, directory_name, 
  aggregate_filename
)