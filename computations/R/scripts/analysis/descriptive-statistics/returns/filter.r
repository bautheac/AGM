pacman::p_load(dplyr, modules)


path_globals <- here::here("computations", "R", "scripts", "globals", "variables.r")
globals <- modules::use(path_globals)

modules::export("filter_out_reporting_periods_with_no_event_dates")
filter_out_reporting_periods_with_no_event_dates <- function(data){
  browser()
  dplyr::filter(data, !dplyr::if_all(globals$event_date_variables, is.na))
}








