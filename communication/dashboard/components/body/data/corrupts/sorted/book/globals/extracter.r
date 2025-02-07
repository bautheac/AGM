suppressMessages({ import(here); import(slituR) })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "book", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)


global_extracter <- modules::use(paths$path_global_extracter)


modules::export("extract_corrupts_book_sorted_unformatted_dataset")
extract_corrupts_book_sorted_unformatted_dataset <- function(){
  
  global_extracter$extract_dataset(paths$filename_corrupts_book_sorted_unformatted_dataset)
}

modules::export("extract_corrupts_book_sorted_formatted_dataset")
extract_corrupts_book_sorted_formatted_dataset <- function(){
  
  global_extracter$extract_dataset(paths$filename_corrupts_book_sorted_formatted_dataset)
}