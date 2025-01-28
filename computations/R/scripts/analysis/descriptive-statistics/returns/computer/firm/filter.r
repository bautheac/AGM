pacman::p_load(dplyr, here, modules)


path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "globals.r"
)
globals <- modules::use(path_globals)


modules::export("filter_irrelevant_records")
filter_irrelevant_records <- function(data) {
  
  dplyr::filter(data, event %in% c(NA, globals$events_of_interest))
}