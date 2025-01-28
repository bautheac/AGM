pacman::p_load(here, modules)


modules::export("path_results_directory")
path_results_directory <- 
  here::here("computations", "R", "results")