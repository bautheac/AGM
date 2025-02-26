pacman::p_load(here)


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)
  
computer <- modules::use(paths$path_computer)
loader <- modules::use(paths$path_loader)


descriptive_stats <- computer$compute_book_statistics()


loader$load_objects(
  list(descriptive_stats, descriptive_stats), 
  list(
    paths$path_book_descriptive_stats_results_main, 
    paths$path_book_descriptive_stats_results_dashboard
  )
)


rm(list = ls())