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
path_globals <- here::here("computations", "R", "scripts", "extract-transform-load", "dates", "trading", "globals.r")
globals <- modules::use(path_globals)


raw_dates <- data_extracter$extract_raw_price_data()
clean_dates <- dates_data_transformer$transform_dates(raw_dates)


data_loader$load_objects(
  list(clean_dates, clean_dates),
  list(globals$filepath_clean_dates_trading_main, globals$filepath_clean_dates_trading_dashboard)
)

rm(list = ls())