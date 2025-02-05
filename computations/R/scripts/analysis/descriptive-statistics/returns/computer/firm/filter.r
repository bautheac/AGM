suppressMessages({ import(dplyr); import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "globals", "paths.r"
)
paths <- modules::use(path_paths)

local_variables <- modules::use(paths$path_local_variables)


modules::export("filter_irrelevant_records")
filter_irrelevant_records <- function(data) {
  
  dplyr::filter(data, event %in% c(NA, local_variables$events_of_interest))
}