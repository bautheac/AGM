pacman::p_load(dplyr, here, lubridate, modules)


path_global_price_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "prices", "main.r")
global_price_transformer <- modules::use(path_global_price_transformer)
path_variables_cleaner <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "dates", "trading", "transformer", "variables_cleaner.r")
variables_cleaner <- modules::use(path_variables_cleaner)
path_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "dates", "trading", "transformer", "filter.r")
filter <- modules::use(path_filter)


export("transform_dates")
transform_dates <- function(raw_dates){
  
  global_price_transformer$transform_prices(raw_dates) |>
    variables_cleaner$clean_relevant_variables() |>
    filter$filter_out_irrelevant_data() |>
    dplyr::mutate(date = lubridate::ymd(date)) |>
    dplyr::arrange(date)
}