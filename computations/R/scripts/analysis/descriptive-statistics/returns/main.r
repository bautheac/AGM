pacman::p_load(here)


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

computer <- modules::use(paths$path_computer)
loader <- modules::use(paths$path_loader)


statistics <- computer$compute_returns_statistics()


loader$load_objects(
  list(statistics$firm, statistics$aggregate), 
  list(paths$paths_firm, paths$paths_aggregate)
)


rm(list = ls())