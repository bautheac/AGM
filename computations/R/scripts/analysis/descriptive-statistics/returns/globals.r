pacman::p_load(here, modules)

path_descriptive_stats_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", "paths.r"
)
descriptive_stats_paths <- modules::use(path_descriptive_stats_paths)


modules::export("path_returns_firms_descriptive_stats_results")
path_returns_firms_descriptive_stats_results <- 
  here::here(descriptive_stats_paths$path_descriptive_stats_results_directory, "returns", "firms.rds")

modules::export("path_returns_firms_descriptive_stats_dashboard")
path_returns_firms_descriptive_stats_dashboard <- 
  here::here(descriptive_stats_paths$path_descriptive_stats_dashboard_directory, "returns", "firms.rds")

modules::export("path_returns_aggregate_descriptive_stats_results")
path_returns_aggregate_descriptive_stats_results <- 
  here::here(descriptive_stats_paths$path_descriptive_stats_results_directory, "returns", "aggregate.rds")

modules::export("path_returns_aggregate_descriptive_stats_dashboard")
path_returns_aggregate_descriptive_stats_dashboard <- 
  here::here(descriptive_stats_paths$path_descriptive_stats_dashboard_directory, "returns", "aggregate.rds")
