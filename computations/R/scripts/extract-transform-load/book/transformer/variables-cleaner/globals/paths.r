suppressMessages(modules::import(here))


modules::export("path_local_corrupts_cleaner")
path_local_corrupts_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "transformer", 
  "variables-cleaner", "corrupts_cleaner.r"
)

modules::export("path_global_corrupts_cleaner")
path_global_corrupts_cleaner <- here::here(
  'computations', 'R', 'scripts', 'extract-transform-load', 'globals', "transformer", 
  'corrupts_cleaner.r'
)

modules::export("path_corrupts")
path_corrupts <- here::here(
  'computations', 'R', 'scripts', 'extract-transform-load', 'book', 'globals', 
  'corrupts.r'
)
