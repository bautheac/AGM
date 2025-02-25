suppressMessages(modules::import(dplyr))


date_variables <- c(
  "date of reporting period end", "date of signing the letter", "date of auditing", 
  "first day of closed books", "last day of closed books", "date of AGM"
)

reporting_period_variables <- c("reporting frequency", "year", "reporting period")

modules::export("select_relevant_variables")
select_relevant_variables <- function(data){
  
  dplyr::select(data, c("id", reporting_period_variables, date_variables))
}
