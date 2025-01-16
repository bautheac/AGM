pacman::p_load(dplyr, here, modules)

path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "extracter.r")
data_extracter <- modules::use(path_data_extracter)

path_prices_data_clean <- here::here("data", "prices_clean.rds")
prices_clean <- data_extracter$extract_rds_data(path_prices_data_clean) 
