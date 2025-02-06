suppressMessages({ import("here"); import("readr"); import("slituR") })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(path_main_directory, "globals", "paths.r")
paths <- modules::use(path_paths)



modules::export("extract_dataset")
extract_dataset <- function(filename) {
  
  readr::read_rds(here::here(paths$path_dataset_directory, filename))
}

modules::export("extract_results")
extract_results <- function(path) {
  
  readr::read_rds(here::here(paths$path_results_directory, path))
}

modules::export("extract_results_stats")
extract_results_stats <- function(path) {
  
  extract_results(paste(paths$directory_name_results_stats, path, sep = "/"))
}

modules::export("extract_results_stats_book")
extract_results_stats_book <- function(filename) {
  
  extract_results_stats(
    paste(paths$directory_name_results_stats_book, filename, sep = "/")
  )
}

modules::export("extract_results_stats_returns")
extract_results_stats_returns <- function(filename) {
  
  extract_results_stats(
    paste(paths$directory_name_results_stats_returns, filename, sep = "/")
  )
}




