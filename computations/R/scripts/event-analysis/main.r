pacman::p_load(here, modules)

path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_return_computer <- 
  here::here("computations", "R", "scripts", "event-analysis", "return_computer.r")
return_computer <- modules::use(path_return_computer)


path_clean_price_data <- here::here("data", "prices_clean.rds")
price_data <- data_extracter$extract_rds_data(path_clean_price_data)

returns <- return_computer$compute_returns(price_data)
