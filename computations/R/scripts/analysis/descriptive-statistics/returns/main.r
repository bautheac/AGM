pacman::p_load(here, modules)

path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)

path_return_data_clean <- here::here("data", "returns_clean.rds")
returns_clean <- data_extracter$extract_rds_data(path_return_data_clean) 
