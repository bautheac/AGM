suppressMessages(modules::import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_extracter <- modules::use(paths$path_global_extracter)
stats_book_paths <- modules::use(paths$path_stats_book_paths)
stats_returns_paths <- modules::use(paths$path_stats_returns_paths)


modules::export("extract_book_descriptive_statistics")
extract_book_descriptive_statistics <- function(){
  
  global_extracter$extract_rds_data(
    stats_book_paths$path_book_descriptive_stats_results_main
  )
}

modules::export("extract_returns_firms_descriptive_statistics")
extract_returns_firms_descriptive_statistics <- function(){
  
  global_extracter$extract_rds_data(
    stats_returns_paths$path_returns_firms_descriptive_stats_results_main
  )
}
