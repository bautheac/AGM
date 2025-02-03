import("here")
import("readr")
import("slituR")


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