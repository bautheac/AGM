suppressMessages(import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_price_transformer <- modules::use(paths$path_global_price_transformer)
variables_selecter <- modules::use(paths$path_variables_selecter)
wrangler <- modules::use(paths$path_wrangler)


export("transform_events")
transform_events <- function(raw_events){
  
  global_price_transformer$transform_prices(raw_events) |>
    variables_selecter$select_relevant_variables() |>
    wrangler$transform_relevant_variables() 
}