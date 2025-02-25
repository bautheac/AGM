suppressMessages(modules::import(here))


modules::export("path_variable_creator")
path_variable_creator <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler", "variable_creator.r"
)

modules::export("path_extracter")
path_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)

modules::export("path_global_filter")
path_global_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "filter", "main.r"
)

modules::export("path_local_filter")
path_local_filter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler" , "filter.r"
)

modules::export("path_wrangler")
path_wrangler <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "wrangler.r"
)

modules::export("path_local_variables")
path_local_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler" , "globals", "variables.r"
)
