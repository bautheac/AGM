suppressMessages({ import("here"); import("readr"); import("slituR") })


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

path_paths <- here::here(path_main_directory, "globals", "paths.r")
paths <- modules::use(path_paths)


extract_dataset <- function(filename) {
  
  readr::read_rds(here::here(paths$path_dataset_directory, filename))
}

modules::export("extract_book_dataset")
extract_book_dataset <- function(){
  
  extract_dataset(paths$filename_book_dataset)
}

modules::export("extract_returns_dataset")
extract_returns_dataset <- function(){
  
  extract_dataset(paths$filename_returns_dataset)
}

modules::export("extract_events_dataset")
extract_events_dataset <- function(){
  
  extract_dataset(paths$filename_events_dataset)
}

modules::export("extract_corrupts_book_pending_dataset")
extract_corrupts_book_pending_dataset <- function(){
  
  extract_dataset(paths$filename_corrupts_book_pending_dataset)
}

modules::export("extract_corrupts_book_sorted_unformatted_dataset")
extract_corrupts_book_sorted_unformatted_dataset <- function(){
  
  extract_dataset(paths$filename_corrupts_book_sorted_unformatted_dataset)
}

modules::export("extract_corrupts_book_sorted_formatted_dataset")
extract_corrupts_book_sorted_formatted_dataset <- function(){
  
  extract_dataset(paths$filename_corrupts_book_sorted_formatted_dataset)
}

modules::export("extract_corrupts_events_sorted_missings_dataset")
extract_corrupts_events_sorted_missings_dataset <- function(){
  
  extract_dataset(paths$filename_corrupts_events_sorted_missings_dataset)
}

modules::export("extract_corrupts_events_sorted_corrupts_dataset")
extract_corrupts_events_sorted_corrupts_dataset <- function(){
  
  extract_dataset(paths$filename_corrupts_events_sorted_corrupts_dataset)
}



extract_results <- function(filename) {
  
  readr::read_rds(here::here(paths$path_dataset_directory, filename))
}

modules::export("extract_stats_book_by_reporting_period")
extract_stats_book_by_reporting_period <- function(){
  
  readr::read_rds(
    here::here(
      paths$path_results_descriptive_statistics_book_directory,
      paths$filename_stats_book_by_reporting_period
    )
  )
}

