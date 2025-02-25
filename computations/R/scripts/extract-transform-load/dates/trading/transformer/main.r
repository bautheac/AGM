suppressMessages({ modules::import(dplyr); modules::import(here); modules::import(lubridate) })


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "dates", "trading", 
  "transformer", "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_price_transformer <- modules::use(paths$path_global_price_transformer)
variables_cleaner <- modules::use(paths$path_variables_cleaner)
filter <- modules::use(paths$path_filter)


export("transform_dates")
transform_dates <- function(raw_dates){
  
  global_price_transformer$transform_prices(raw_dates) |>
    variables_cleaner$clean_relevant_variables() |>
    filter$filter_out_irrelevant_data() |>
    dplyr::mutate(date = lubridate::ymd(date)) |>
    dplyr::arrange(date)
}
