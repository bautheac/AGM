suppressMessages(modules::import(here))


modules::export("path_global_price_transformer")
path_global_price_transformer <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer",
  "prices", "main.r"
)

modules::export("path_variables_selecter")
path_variables_selecter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "prices", "transformer",
  "variables_selecter.r"
)
