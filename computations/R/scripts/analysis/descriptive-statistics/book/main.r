pacman::p_load(dplyr, here, modules, tidyr)


path_loader <- here::here( 
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
  )
loader <- modules::use(path_loader)
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


descriptive_stats <- computer$compute_book_statistics()


loader$load_objects(
  list(descriptive_stats, descriptive_stats), 
  list(globals$path_book_descriptive_stats_results, globals$path_book_descriptive_stats_dashboard)
)


rm(list = ls())