pacman::p_load(here, modules)


path_price_data_globals <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "prices", "globals.r"
)
price_data_globals <- modules::use(path_price_data_globals)
path_data_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)
data_extracter <- modules::use(path_data_extracter)
path_transformer <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "returns", "transformer", 
  "main.r"
)
transformer <- modules::use(path_transformer)
path_data_loader <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
)
data_loader <- modules::use(path_data_loader)
path_globals <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "returns", "globals.r"
)
globals <- modules::use(path_globals)


price_data <- data_extracter$extract_rds_data( price_data_globals$filepath_clean_prices_data_main)


clean_returns <- transformer$make_returns_dataset(price_data)


data_loader$load_objects(
  list(clean_returns, clean_returns),
  list(globals$filepath_clean_returns_data_main, globals$filepath_clean_returns_data_dashboard)
)


rm(list = ls())