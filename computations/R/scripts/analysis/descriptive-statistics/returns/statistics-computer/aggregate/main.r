pacman::p_load(dplyr, modules)


path_event_counter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns",
  "statistics-computer", "aggregate", "event-counter.r"
)
event_counter <- modules::use(path_event_counter)


modules::export("compute_statisics")
compute_statisics <- function(firm_statistics){
  
  event_counter$count_events(firm_statistics)
}
