suppressMessages(modules::import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "prices", "globals", "paths.r"
)
paths <- modules::use(path_paths)

data_extracter <- modules::use(paths$path_data_extracter)
price_data_transformer <- modules::use(paths$path_price_data_transformer)
data_loader <- modules::use(paths$path_data_loader)


raw_prices <- data_extracter$extract_raw_price_data()
clean_prices <- price_data_transformer$transform_prices(raw_prices)


data_loader$load_objects(
  list(clean_prices, clean_prices),
  list(paths$filepath_clean_prices_data_main, paths$filepath_clean_prices_data_dashboard)
)


rm(list = ls())
