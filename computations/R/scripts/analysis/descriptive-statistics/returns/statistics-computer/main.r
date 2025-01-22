pacman::p_load(here, modules)


path_stats_computer_firm <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", "statistics-computer", 
  "firm", "main.r"
  )
stats_computer_firm <- modules::use(path_stats_computer_firm)


modules::export("compute_returns_statistics")
compute_returns_statistics <- function(dataset){
  
  firm <- stats_computer_firm$compute_days_around_events(dataset) 
  aggregate <- list()
  
  return(list(firm = firm, aggregate = aggregate))
}


