pacman::p_load(here, modules)

path_global_price_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "prices", "main.r")
global_price_transformer <- modules::use(path_global_price_transformer)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)


export("transform_prices")
transform_prices <- function(raw_prices){
  
  global_price_transformer$transform_prices(raw_prices) |>
    variables_selecter$select_relevant_variables() |>
    dplyr::arrange(id, date)
}