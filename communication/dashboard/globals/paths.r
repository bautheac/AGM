import("here")
import("slituR")


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

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

modules::export("filename_events_dataset")
filename_events_dataset <- "events_clean.rds"

modules::export("filename_names_dataset")
filename_names_dataset <- "names_clean.rds"

modules::export("filename_returns_dataset")
filename_returns_dataset <- "returns_clean.rds"

