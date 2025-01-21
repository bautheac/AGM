pacman::p_load(here, modules)

path_analysis_global_paths <- here::here("computations", "R", "scripts", "analysis", "globals", "paths.r")
analysis_global_paths <- modules::use(path_global_paths)
path_global_paths <- here::here("computations", "R", "scripts", "globals", "paths.r")
global_paths <- modules::use(path_global_paths)


modules::export("path_descriptive_stats_results_directory")
path_descriptive_stats_results_directory <- 
  here::here(analysis_global_paths$path_results_directory, "descriptive-statistics")

modules::export("path_descriptive_stats_dashboard_directory")
path_descriptive_stats_dashboard_directory <- 
  here::here(global_paths$path_dashboard_directory, "descriptive-statistics")
