suppressMessages(modules::import(here))


modules::export("path_names_cleaner")
path_names_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "raw_book_data_names_cleaner.r"
)

modules::export("path_variables_selecter")
path_variables_selecter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "names", "transformer", 
  "variables_selecter.r"
)

modules::export("path_filter")
path_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "filter", "main.r"
)
