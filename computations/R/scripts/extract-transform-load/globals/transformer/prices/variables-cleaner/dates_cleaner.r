suppressMessages({ modules::import(dplyr); modules::import(lubridate) })


clean_date_variables <- function(price_data){
  
  dplyr::mutate(price_data, date = trimws(date), date = lubridate::mdy(date))
}
