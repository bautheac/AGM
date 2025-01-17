pacman::p_load(here, modules)

path_names_cleaner <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "prices", "names_cleaner.r")
names_cleaner <- modules::use(path_names_cleaner)
path_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "filter", "raw_price_data_filter.r")
filter <- modules::use(path_filter)
path_variables_cleaner <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "prices", "variables-cleaner", "main.r")
variables_cleaner <- modules::use(path_variables_cleaner)

export("transform_prices")
transform_prices <- function(raw_prices){
  
  names_cleaner$rename_variables(raw_prices) |>
    filter$filter_out_irrelvant_raw_records() |>
    variables_cleaner$clean_date_price_variables() |>
    filter$filter_out_irrelvant_clean_records()
}