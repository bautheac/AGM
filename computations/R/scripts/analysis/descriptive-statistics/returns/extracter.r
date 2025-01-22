pacman::p_load(here, modules)


path_global_data_extracter <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
global_data_extracter <- modules::use(path_global_data_extracter)


modules::export("extract_subdatasets")
extract_subdatasets <- function(){
  
  dates_days <- global_data_extracter$extract_clean_dates_trading_data()
  dates_reporting <- global_data_extracter$extract_clean_dates_reporting_data()
  events <- global_data_extracter$extract_clean_events_data()
  returns <- global_data_extracter$extract_clean_returns_data()
  
  list(dates_days = dates_days, dates_reporting = dates_reporting, events = events, returns = returns)
}