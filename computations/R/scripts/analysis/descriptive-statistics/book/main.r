pacman::p_load(dplyr, here, modules, tidyr)

path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)
path_data_wrangler <- 
  here::here("computations", "R", "scripts", "analysis", "descriptive-statistics", "book", "data-wrangler", "main.r")
data_wrangler <- modules::use(path_data_wrangler)
path_statistics_computer <- 
  here::here("computations", "R", "scripts", "analysis", "descriptive-statistics", "book", "statistics-computer", "main.r")
statistics_computer <- modules::use(path_statistics_computer)
path_globals <- here::here("computations", "R", "scripts", "analysis", "descriptive-statistics", "book", "globals.r")
globals <- modules::use(path_globals)


book_data <- data_extracter$extract_rds_data(globals$path_book_data_clean) |>
  data_wrangler$prepare_dataset_for_descriptive_stats_analysis()


descriptive_stats <- statistics_computer$compute_descriptive_statistics(book_data)


data_loader$load_objects(
  list(descriptive_stats, descriptive_stats), 
  list(globals$path_book_descriptive_stats_results, globals$path_book_descriptive_stats_dashboard)
)


rm(list = ls())