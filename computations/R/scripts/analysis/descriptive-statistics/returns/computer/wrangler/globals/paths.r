suppressMessages(modules::import(here))


modules::export("path_extracter")
path_extracter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "wrangler", "extracter.r"
)

modules::export("path_filter")
path_filter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "wrangler", "filter.r"
)

modules::export("path_selecter")
path_selecter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "wrangler", "selecter.r"
)

modules::export("path_global_variables")
path_global_variables <- here::here("computations", "R", "scripts", "globals", "variables.r")
