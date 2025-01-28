pacman::p_load(here, modules)


path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "wrangler.r"
)
wrangler <- modules::use(path_wrangler)
path_staistics_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "statistics-computer", "main.r"
)
statistics_computer <- modules::use(path_staistics_computer)
path_data_loader <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
)
data_loader <- modules::use(path_data_loader)
path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "globals.r"
)
globals <- modules::use(path_globals)


dataset <- wrangler$make_dataset()


statistics <- statistics_computer$compute_returns_statistics(dataset)


paths_firm <- list(
  globals$path_returns_firms_descriptive_stats_results, 
  globals$path_returns_firms_descriptive_stats_dashboard
)
paths_aggregate <- list(
  globals$path_returns_aggregate_descriptive_stats_results, 
  globals$path_returns_aggregate_descriptive_stats_dashboard
)

data_loader$load_objects(
  list(statistics$firm, statistics$aggregate), 
  list(paths_firm, paths_aggregate)
)


rm(list = ls())