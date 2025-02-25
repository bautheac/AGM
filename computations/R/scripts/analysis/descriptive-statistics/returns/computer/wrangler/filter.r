suppressMessages({ modules::import(dplyr); modules::import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "wrangler", "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_variables <- modules::use(paths$path_global_variables)

modules::export("filter_out_reporting_periods_with_no_event_dates")
filter_out_reporting_periods_with_no_event_dates <- function(data){

  dplyr::filter(data, !dplyr::if_all(global_variables$event_date_variables, is.na))
}








