pacman::p_load(dplyr, here, modules, tidyr)

path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "loader.r")
data_loader <- modules::use(path_data_loader)
path_data_wrangler <- 
  here::here("computations", "R", "scripts", "descriptive-statistics", "book", "data-wrangler", "main.r")
data_wrangler <- modules::use(path_data_wrangler)
path_statistics_computer <- 
  here::here("computations", "R", "scripts", "descriptive-statistics", "book", "statistics-computer", "main.r")
statistics_computer <- modules::use(path_statistics_computer)


path_book_data_clean <- here::here("data", "book_clean.rds")
path_book_descriptive_stats_results <- 
  here::here("computations", "R", "results", "book_descriptive_stats.rds")
path_book_descriptive_stats_dashboard <- 
  here::here("communication", "dashboard", "data", "book_descriptive_stats.rds")


book_data <- data_extracter$extract_rds_data(path_book_data_clean) |>
  data_wrangler$prepare_dataset_for_descriptive_stats_analysis()

descriptive_stats <- statistics_computer$compute_descriptive_statistics(book_data)

purrr::walk(
  list(path_book_descriptive_stats_results, path_book_descriptive_stats_dashboard
  ), ~ data_loader$load_rds(descriptive_stats, .x)
)


rm(list = ls())

