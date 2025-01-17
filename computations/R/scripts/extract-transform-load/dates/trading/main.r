pacman::p_load(here, modules)


path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_dates_data_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "dates", "trading", "transformer", "main.r")
dates_data_transformer <- modules::use(path_dates_data_transformer)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)


path_clean_dates_data <- here::here("data", "dates_trading_clean.rds")


raw_dates <- data_extracter$extract_price_data()
clean_dates <- dates_data_transformer$transform_dates(raw_dates)


data_loader$load_rds(clean_dates, path_clean_dates_data)


rm(list = ls())