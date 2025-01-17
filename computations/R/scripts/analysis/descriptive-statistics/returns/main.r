pacman::p_load(here, modules)


path_extracter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "extracter", "main.r"
  )
extracter <- modules::use(path_extracter)


path_return_data_clean <- here::here("data", "returns_clean.rds")


dataset <- extracter$make_dataset()


rm(list = ls())