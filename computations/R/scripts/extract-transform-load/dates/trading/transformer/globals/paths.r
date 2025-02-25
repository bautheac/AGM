suppressMessages(modules::import(here))


modules::export("path_global_price_transformer")
path_global_price_transformer <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "prices", "main.r"
)

modules::export("path_variables_cleaner")
path_variables_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "dates", "trading", 
  "transformer", "variables_cleaner.r"
)

modules::export("path_filter")
path_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "dates", "trading", 
  "transformer", "filter.r"
)
