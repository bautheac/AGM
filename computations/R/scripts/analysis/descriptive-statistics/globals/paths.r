suppressMessages(modules::import(here))


path_global_paths <- here::here("computations", "R", "scripts", "globals", "paths.r")
global_paths <- modules::use(path_global_paths)


modules::export("path_descriptive_stats_results_directory_main")
path_descriptive_stats_results_directory_main <- here::here(
  global_paths$path_results_directory, "descriptive-statistics"
)

modules::export("path_descriptive_stats_results_directory_dashboard")
path_descriptive_stats_results_directory_dashboard <- here::here(
  global_paths$path_dashboard_directory_results, "descriptive-statistics"
)
