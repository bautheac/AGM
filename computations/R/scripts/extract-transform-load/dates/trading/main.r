suppressMessages(import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "dates", "trading", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

data_extracter <- modules::use(paths$path_data_extracter)
dates_data_transformer <- modules::use(paths$path_dates_data_transformer)
data_loader <- modules::use(paths$path_data_loader)


raw_dates <- data_extracter$extract_raw_price_data()
clean_dates <- dates_data_transformer$transform_dates(raw_dates)


data_loader$load_objects(
  list(clean_dates, clean_dates),
  list(paths$filepath_clean_dates_trading_main, paths$filepath_clean_dates_trading_dashboard)
)


rm(list = ls())