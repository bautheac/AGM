pacman::p_load(dplyr, here, modules)

path_character_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "prices", "variables-cleaner", "price-cleaner", "character_cleaner.r"
)
character_cleaner <- modules::use(path_character_cleaner)
path_price_converter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "prices", "variables-cleaner", "price-cleaner", "price_converter.r"
)
price_converter <- modules::use(path_price_converter)


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