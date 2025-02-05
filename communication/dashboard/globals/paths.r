suppressMessages({ import("here"); import("slituR") })


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

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


modules::export("filename_book_dataset")
filename_book_dataset <- "book_clean.rds"

modules::export("filename_corrupts_book_pending_dataset")
filename_corrupts_book_pending_dataset <- "corrupts_book_pending.rds"

modules::export("filename_corrupts_book_sorted_unformatted_dataset")
filename_corrupts_book_sorted_unformatted_dataset <- "corrupts_book_unformatted.rds"

modules::export("filename_corrupts_book_sorted_formatted_dataset")
filename_corrupts_book_sorted_formatted_dataset <- "corrupts_book_formatted.rds"

modules::export("filename_corrupts_events_sorted_missings_dataset")
filename_corrupts_events_sorted_missings_dataset <- "corrupts_events_missings.rds"

modules::export("filename_corrupts_events_sorted_corrupts_dataset")
filename_corrupts_events_sorted_corrupts_dataset <- "corrupts_events_records.rds"

modules::export("filename_events_dataset")
filename_events_dataset <- "events_clean.rds"

modules::export("filename_names_dataset")
filename_names_dataset <- "names_clean.rds"

modules::export("filename_returns_dataset")
filename_returns_dataset <- "returns_clean.rds"

