suppressMessages({ modules::import(dplyr); modules::import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "prices", "variables-cleaner", "price-cleaner", "globals", "paths.r"
)
paths <- modules::use(path_paths)

character_cleaner <- modules::use(paths$path_character_cleaner)
price_converter <- modules::use(paths$path_price_converter)


inverse_where_low_higher_than_high <- function(price_data){
  
  cleaned <- dplyr::mutate(
    price_data,
    high_new = dplyr::if_else(high < low, low, high),
    low_new = dplyr::if_else(high < low, high, low)
  ) |>
    dplyr::select(-high, -low) |> dplyr::rename(high = high_new, low = low_new)
  
  return(cleaned)
}

clean_high_low_variables <- function(price_data){
  
  cleaned <- dplyr::mutate(
    price_data, dplyr::across(c(low, high), character_cleaner$correct_invalid_characters)
  ) |> inverse_where_low_higher_than_high()
  
  return(cleaned)
}

convert_high_low_prices_to_decimal <- function(price_data){
  
  transformed <- dplyr::mutate(
    price_data, dplyr::across(c(low, high), price_converter$transform_prices_to_decimal)
  )
  
  return(transformed)
}


modules::export("clean_price_variables")
clean_price_variables <- function(price_data){
  
  clean_high_low_variables(price_data) |> convert_high_low_prices_to_decimal()
}
