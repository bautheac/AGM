pacman::p_load(dplyr, lubridate, modules, stringr)

path_character_cleaner <- here::here("computations", "R", "scripts", "extract-transform-load", "prices", "transformer", "character_cleaner.r")
character_cleaner <- modules::use(path_character_cleaner)

select_columns_of_interest <- function(prices){
  
  # Rename columns A to H to their new names
  selection <- dplyr::rename(
    prices, date = A, day = B, trading = C, dataavailable = D, 
    price = E, low = `F`, high = G, event = H
  ) |>
    # Drop columns J, K, L, and I
    dplyr::select(-c(J, K, L, I))
  
  return(selection)
}

remove_first_row_of_repeated_headers <- function(prices){
  
  return(prices[-1L, ])
}

clean_bad_date_entries <- function(prices){
  
  cleaned <- dplyr::filter(prices, date != "", date != "date") |> 
    dplyr::mutate(date = trimws(date), date = lubridate::mdy(date))
  
  return(cleaned)
}

add_company_names <- function(prices, names){
  
  joined <- dplyr::left_join(prices, names, by = "Company")
  
  return(joined)
}

transform_prices_to_decimal <- function(prices){
  
  integer <- as.numeric(stringr::str_extract(prices, "^\\d+"))
  numerator <- as.numeric(stringr::str_extract(prices, "(?<=-)(\\d+)(?=/)"))
  denominator <- as.numeric(stringr::str_extract(prices, "(?<=/)(\\d+)"))
  
  fraction <- numerator / denominator
  fraction[is.na(fraction)] <- 0L
  
  return(integer + fraction)
}

inverse_where_low_higher_than_high <- function(data){
  
  cleaned <- dplyr::mutate(
    data,
    high_new = dplyr::if_else(high < low, low, high),
    low_new = dplyr::if_else(high < low, high, low)
  ) |>
    dplyr::select(-high, -low) |>
    dplyr::rename(high = high_new, low = low_new)
  
  return(cleaned)
}

correct_errors_in_high_low_prices <- function(data){
  
  cleaned <- dplyr::mutate(
    data, 
    # Correct invalid characters
    dplyr::across(c(low, high), character_cleaner$correct_invalid_characters)
  ) |> 
    # Inverse low and high where low is higher than high
    inverse_where_low_higher_than_high()
  
  return(cleaned)
}

transform_high_low_prices_to_decimal <- function(data){
  
  transformed <- dplyr::mutate(
    data,
    dplyr::across(c(low, high), transform_prices_to_decimal)
  )
  
  return(transformed)
}

forward_fill_missing_high_low_prices <- function(data){
  
  filled <- dplyr::group_by(data, Company) |>
    tidyr::fill(c(low, high), .direction = "down") |>
    dplyr::ungroup()
  
  return(filled)
}

export("transform_prices")
transform_prices <- function(raw_prices, company_names){
  
  clean_prices <-
    select_columns_of_interest(raw_prices) |>
    remove_first_row_of_repeated_headers() |>
    clean_bad_date_entries () |>
    add_company_names(company_names) |>
    correct_errors_in_high_low_prices() |>
    transform_high_low_prices_to_decimal() |>
    forward_fill_missing_high_low_prices()
}

