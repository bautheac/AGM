pacman::p_load(here, modules)


path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "wrangler.r"
)
wrangler <- modules::use(path_wrangler)
path_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "main.r"
)
computer <- modules::use(path_computer)
path_loader <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
)
loader <- modules::use(path_loader)
path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "globals.r"
)
globals <- modules::use(path_globals)


dataset <- wrangler$make_dataset()


statistics <- computer$compute_returns_statistics(dataset)


paths_firm <- list(
  globals$path_returns_firms_descriptive_stats_results, 
  globals$path_returns_firms_descriptive_stats_dashboard
)
paths_aggregate <- list(
  globals$path_returns_aggregate_descriptive_stats_results, 
  globals$path_returns_aggregate_descriptive_stats_dashboard
)

loader$load_objects(
  list(statistics$firm, statistics$aggregate), 
  list(paths_firm, paths_aggregate)
)


rm(list = ls())