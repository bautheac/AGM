suppressMessages({ import(here); import(slituR) })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)


modules::export("path_header")
path_header <- here::here(path_main_directory, "components", "header", "main.r")

modules::export("path_sidebar")
path_sidebar <- here::here(path_main_directory, "components", "sidebar", "main.r")

modules::export("path_body")
path_body <- here::here(path_main_directory, "components", "body", "main.r")

modules::export("path_global_variables")
path_global_variables <- here::here(
  path_main_directory, "components", "globals", "variables.r"
)


modules::export("path_dataset_directory")
path_dataset_directory <- here::here(path_main_directory, "data", "datasets")

modules::export("path_results_directory")
path_results_directory <- here::here(path_main_directory, "data", "results")

modules::export("path_results_descriptive_statistics_directory")
path_results_descriptive_statistics_directory <- 
  here::here(path_results_directory, "descriptive-statistics")

modules::export("path_results_descriptive_statistics_book_directory")
path_results_descriptive_statistics_book_directory <-
  here::here(path_results_descriptive_statistics_directory, "book")

modules::export("path_results_descriptive_statistics_returns_directory")
path_results_descriptive_statistics_returns_directory <-
  here::here(path_results_descriptive_statistics_directory, "returns")

modules::export("path_results_descriptive_statistics_high_availability_directory")
path_results_descriptive_statistics_high_availability_directory <-
  here::here(path_results_descriptive_statistics_directory, "high-availability")



modules::export("directory_name_results_stats")
directory_name_results_stats <- "descriptive-statistics"

modules::export("directory_name_results_stats_book")
directory_name_results_stats_book <- "book"

modules::export("directory_name_results_stats_returns")
directory_name_results_stats_returns <- "returns"

modules::export("directory_name_results_stats_availables")
directory_name_results_stats_availables <- "high-availability"



modules::export("filename_names_dataset")
filename_names_dataset <- "names_clean.rds"