pacman::p_load(here, modules)


path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_price_data_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "main.r")
price_data_transformer <- modules::use(path_price_data_transformer)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "loader.r")
data_loader <- modules::use(path_data_loader)


path_raw_price_data <- here::here("computations", "stata", "AGMdata.dta")
path_clean_price_data <- here::here("data", "prices_clean.rds")


raw_prices <- data_extracter$extract_stata_data(path_raw_price_data)
clean_prices <- price_data_transformer$transform_prices(raw_prices)


data_loader$load_rds(clean_prices, path_clean_price_data)


rm(list = ls())