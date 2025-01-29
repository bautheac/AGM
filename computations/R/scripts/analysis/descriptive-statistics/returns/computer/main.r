pacman::p_load(here, modules)


path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "wrangler", "main.r"
)
wrangler <- modules::use(path_wrangler)
path_stats_computer_firm <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "main.r"
  )
stats_computer_firm <- modules::use(path_stats_computer_firm)
path_stats_computer_aggregate <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "aggregate", "main.r"
  )
stats_computer_aggregate <- modules::use(path_stats_computer_aggregate)


modules::export("compute_returns_statistics")
compute_returns_statistics <- function(firm_ids = "all"){
  
  dataset <- wrangler$make_dataset() |>
    dplyr::filter(firm_ids == "all" | id %in% firm_ids)
  
  firm <- stats_computer_firm$compute_days_around_events(dataset) 
  aggregate <- stats_computer_aggregate$compute_statisics(firm)
  
  return(list(firm = firm, aggregate = aggregate))
}


