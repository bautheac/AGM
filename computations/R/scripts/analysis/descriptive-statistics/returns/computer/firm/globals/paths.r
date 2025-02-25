suppressMessages(modules::import(here))


modules::export("path_event_days_counter")
path_event_days_counter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "event_days_counter.r"
)

modules::export("path_filter")
path_filter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "filter.r"
)

modules::export("path_local_variables")
path_local_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "globals", "variables.r"
)


