suppressMessages(modules::import(here))

path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "prices", "globals", "paths.r"
)
paths <- modules::use(path_paths)

names_cleaner <- modules::use(paths$path_names_cleaner)
filter <- modules::use(paths$path_filter)
variables_cleaner <- modules::use(paths$path_variables_cleaner)

export("transform_prices")
transform_prices <- function(raw_prices){
  
  names_cleaner$rename_variables(raw_prices) |>
    filter$filter_out_irrelvant_raw_records() |>
    variables_cleaner$clean_date_price_variables() |>
    filter$filter_out_irrelvant_clean_records()
}
