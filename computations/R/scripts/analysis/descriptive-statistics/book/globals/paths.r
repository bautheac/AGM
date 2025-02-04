suppressMessages(import(here))


results_file_name <- "statistics-by-reporting-frequency.rds"


modules::export("path_loader")
path_loader <- here::here( 
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
)

modules::export("path_computer")
path_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "main.r"
)


path_descriptive_stats_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "paths.r"
)
descriptive_stats_paths <- modules::use(path_descriptive_stats_paths)

modules::export("path_book_data_clean")
path_book_data_clean <- here::here("data", "book_clean.rds")

modules::export("path_book_descriptive_stats_results_main")
path_book_descriptive_stats_results_main <- here::here(
  descriptive_stats_paths$path_descriptive_stats_results_directory_main, "book", 
  results_file_name
)

modules::export("path_book_descriptive_stats_results_dashboard")
path_book_descriptive_stats_results_dashboard <- here::here(
  descriptive_stats_paths$path_descriptive_stats_results_directory_dashboard, "book", 
  results_file_name
)