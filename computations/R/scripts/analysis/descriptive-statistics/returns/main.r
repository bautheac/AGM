pacman::p_load(here, modules)


path_extracter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "extracter", "main.r"
  )
extracter <- modules::use(path_extracter)
path_statistics_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "statistics-computer", "main.r"
  )
statistics_computer <- modules::use(path_statistics_computer)


path_return_data_clean <- here::here("data", "returns_clean.rds")


returns <- extracter$make_dataset()


days_around_events_by_firm_year <- statistics_computer$compute_days_around_events(returns)


rm(list = ls())