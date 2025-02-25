suppressMessages({ modules::import(dplyr); modules::import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "globals", "paths.r"
)
paths <- modules::use(path_paths)

wrangler <- modules::use(paths$path_wrangler)
stats_computer_firm <- modules::use(paths$path_stats_computer_firm)
stats_computer_aggregate <- modules::use(paths$path_stats_computer_aggregate)


modules::export("compute_returns_statistics")
compute_returns_statistics <- function(firm_ids = "all"){
  
  dataset <- wrangler$make_dataset() |>
    dplyr::filter(firm_ids == "all" | id %in% firm_ids)
  
  firm <- stats_computer_firm$compute_days_around_events(dataset) 
  aggregate <- stats_computer_aggregate$compute_statisics(firm)
  
  return(list(firm = firm, aggregate = aggregate))
}


