suppressMessages({ modules::import(dplyr); modules::import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "prices", "transformer", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_price_transformer <- modules::use(paths$path_global_price_transformer)
variables_selecter <- modules::use(paths$path_variables_selecter)


export("transform_prices")
transform_prices <- function(raw_prices){
  
  global_price_transformer$transform_prices(raw_prices) |>
    variables_selecter$select_relevant_variables() |>
    dplyr::arrange(id, date)
}
