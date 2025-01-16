pacman::p_load(dplyr, here, lubridate, modules)


path_dates_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "prices", "transformer", 
  "variables-cleaner", "dates_cleaner.r"
)
dates_cleaner <- modules::use(path_dates_cleaner)
path_price_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "prices", "transformer", 
  "variables-cleaner", "price-cleaner", "main.r"
)
price_cleaner <- modules::use(path_price_cleaner)



modules::export("clean_date_price_variables")
clean_date_price_variables <- function(price_data){
  
  dates_cleaner$clean_date_variables(price_data) |>
    price_cleaner$clean_price_variables()
}
