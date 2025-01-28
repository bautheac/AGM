pacman::p_load(dplyr, here, modules, tidyr)

path_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
  )
extracter <- modules::use(path_extracter)
path_loader <- here::here( 
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
  )
loader <- modules::use(path_loader)
path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "wrangler", "main.r"
  )
wrangler <- modules::use(path_wrangler)
path_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "main.r"
  )
computer <- modules::use(path_computer)
path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "globals.r"
  )
globals <- modules::use(path_globals)


book_data <- extracter$extract_rds_data(globals$path_book_data_clean) |>
  wrangler$prepare_dataset_for_descriptive_stats_analysis()


descriptive_stats <- computer$compute_descriptive_statistics(book_data)


loader$load_objects(
  list(descriptive_stats, descriptive_stats), 
  list(globals$path_book_descriptive_stats_results, globals$path_book_descriptive_stats_dashboard)
)


rm(list = ls())