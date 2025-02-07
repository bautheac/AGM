suppressMessages({ import(here); import(slituR) })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "stats", "book", "globals", "paths.r"
)
paths <- modules::use(path_paths)



global_extracter <- modules::use(paths$path_global_extracter)


modules::export("extract_stats_book_by_reporting_period")
extract_stats_book_by_reporting_period <- function(){
  
  global_extracter$extract_results_stats_book(
    paths$filename_stats_book_by_reporting_period
  )
}