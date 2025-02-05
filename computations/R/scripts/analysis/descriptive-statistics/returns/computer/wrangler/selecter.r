suppressMessages({ import(dplyr) })


modules::export("select_reporting_periods_relevant_variables")
select_reporting_periods_relevant_variables <- function(data){
  
  dplyr::select(data, id, year, `reporting frequency`, `reporting period`, date)
}