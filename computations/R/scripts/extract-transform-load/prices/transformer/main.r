pacman::p_load(here, modules)

path_names_cleaner <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "names_cleaner.r")
names_cleaner <- modules::use(path_names_cleaner)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)
path_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "filter.r")
filter <- modules::use(path_filter)
path_variables_cleaner <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "variables-cleaner", "main.r")
variables_cleaner <- modules::use(path_variables_cleaner)

export("transform_prices")
transform_prices <- function(raw_prices){
  
  names_cleaner$rename_variables(raw_prices) |>
    variables_selecter$select_relevant_variables() |>
    filter$filter_out_irrelvant_records() |>
    variables_cleaner$clean_date_price_variables() |>
    dplyr::arrange(id, date)
}