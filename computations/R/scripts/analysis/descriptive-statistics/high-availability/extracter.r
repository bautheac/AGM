pacman::p_load(dplyr, modules)


path_extracter_globals <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)
extracter_globals <- modules::use(path_extracter_globals)
path_descriptive_statistics_book_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "globals.r"
)
descriptive_statistics_book_globals <- modules::use(path_descriptive_statistics_book_globals)


modules::export("extract_book_descriptive_statistics")
extract_book_descriptive_statistics <- function(){
  
  extracter_globals$extract_rds_data(
    descriptive_statistics_book_globals$path_book_descriptive_stats_results
  )
}





