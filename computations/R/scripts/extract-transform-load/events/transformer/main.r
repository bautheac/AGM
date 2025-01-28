pacman::p_load(here, modules)


path_global_price_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "prices", "main.r")
global_price_transformer <- modules::use(path_global_price_transformer)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "events", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)
path_wrangler <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "events", "transformer", "wrangler.r")
wrangler <- modules::use(path_wrangler)



export("transform_events")
transform_events <- function(raw_events){
  
  global_price_transformer$transform_prices(raw_events) |>
    variables_selecter$select_relevant_variables() |>
    wrangler$transform_relevant_variables() 
}