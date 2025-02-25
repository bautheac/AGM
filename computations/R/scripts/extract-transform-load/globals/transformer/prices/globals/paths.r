suppressMessages(modules::import(here))


modules::export("path_names_cleaner")
path_names_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "prices", "names_cleaner.r"
)

modules::export("path_filter")
path_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "filter", "raw_price_data_filter.r"
)

modules::export("path_variables_cleaner")
path_variables_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "prices", "variables-cleaner", "main.r"
)
