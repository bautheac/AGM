pacman::p_load(here, modules)


path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_price_data_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "main.r")
price_data_transformer <- modules::use(path_price_data_transformer)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)
path_globals <- here::here("computations", "R", "scripts", "extract-transform-load", "prices", "globals.r")
globals <- modules::use(path_globals)


raw_prices <- data_extracter$extract_raw_price_data()
clean_prices <- price_data_transformer$transform_prices(raw_prices)


data_loader$load_objects(
  list(clean_prices, clean_prices),
  list(globals$filepath_clean_prices_data_main, globals$filepath_clean_prices_data_dashboard)
)


rm(list = ls())