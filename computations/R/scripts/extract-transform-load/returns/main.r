suppressMessages(modules::import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "returns", "globals", 
  "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_data_extracter)
transformer <- modules::use(paths$path_transformer)
data_loader <- modules::use(paths$path_data_loader)


price_data <- extracter$extract_clean_prices_data()
clean_returns <- transformer$make_returns_dataset(price_data)


data_loader$load_objects(
  list(clean_returns, clean_returns),
  list(paths$filepath_clean_returns_data_main, paths$filepath_clean_returns_data_dashboard)
)


rm(list = ls())
