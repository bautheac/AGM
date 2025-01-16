pacman::p_load(dplyr, lubridate, modules)

clean_date_variables <- function(price_data){
  
  dplyr::mutate(price_data, date = trimws(date), date = lubridate::mdy(date))
}

