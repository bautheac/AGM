suppressMessages(modules::import(here))


modules::export("path_extracter")
path_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)

modules::export("path_wrangler")
path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler", "main.r"
)

modules::export("path_local_formatter")
path_local_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "formatter.r"
)

modules::export("path_global_formatter")
path_global_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "formatter.r"
)

modules::export("path_global_computer")
path_global_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "computer.r"
)

modules::export("path_local_variables")
path_local_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "globals", "variables.r"
)

modules::export("path_wrangler_local_variables")
path_wrangler_local_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler", "globals", "variables.r"
)
