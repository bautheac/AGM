pacman::p_load(dplyr, haven, here, tidyr, stringr)

path_prices <- here::here("computations", "stata", "AGMdata.dta")
path_company_names <- here::here("computations", "stata", "companynames.dta")

prices <- haven::read_dta(path_prices)


select_columns_of_interest <- function(prices){
  
  # Rename columns A to H to their new names
  selection <- rename(
      prices, date = A, day = B, trading = C, dataavailable = D, 
      price = E, low = `F`, high = G, event = H
    ) %>%
    # Drop columns J, K, L, and I
    select(-c(J, K, L, I))
  
  return(selection)
}

remove_first_row_of_repeated_headers <- function(prices){
  
  return(prices[-1L, ])
}

clean_bad_date_entries <- function(prices){
  
  cleaned <-   filter(prices, date != "", date != "date") %>% 
    mutate(date = trimws(date), date = lubridate::mdy(date))
  
  return(cleaned)
}

add_company_names <- function(prices){
  
  joined <- left_join(prices, haven::read_dta(path_company_names), by = "Company")
  
  return(joined)
}

correct_invalid_characters <- function(prices){
  
  pattern_map <- c(
    "¼" = "1/4",
    "½" = "1/2",
    "¾" = "3/4",
    "⅛" = "1/8",
    "⅜" = "3/8",
    "⅝" = "5/8",
    "⅞" = "7/8",
    "\\.\\." = "",
    "TB" = ""
  )
  
  return(stringr::str_replace_all(prices, pattern_map))
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
  
  cleaned <- mutate(
    data,
    high_new = if_else(high < low, low, high),
    low_new = if_else(high < low, high, low)
  ) %>%
    select(-high, -low) %>%
    rename(high = high_new, low = low_new)
  
  return(cleaned)
}

correct_errors_in_high_low_prices <- function(data){
  
  cleaned <- mutate(
    data, 
    # Correct invalid characters
    across(c(low, high), correct_invalid_characters)
  ) %>% 
    # Inverse low and high where low is higher than high
    inverse_where_low_higher_than_high()
  
  return(cleaned)
}

transform_high_low_prices_to_decimal <- function(data){
  
  transformed <- mutate(
    data,
    across(c(low, high), transform_prices_to_decimal)
  )
  
  return(transformed)
}

forward_fill_missing_high_low_prices <- function(data){
  
  filled <- group_by(data, Company) %>%
    fill(c(low, high), .direction = "down") %>%
    ungroup()
  
  return(filled)
}

compute_capital_gains_by_company <- function(data){
  
  results <- group_by(data, Company) %>%
    mutate(mid = (high + low) / 2L, capgains = mid / lag(mid) - 1L) %>%
    ungroup()
  
  return(results)
}

prices <-
  select_columns_of_interest(prices) %>%
  remove_first_row_of_repeated_headers() %>%
  clean_bad_date_entries () %>%
  add_company_names() %>%
  correct_errors_in_high_low_prices() %>%
  transform_high_low_prices_to_decimal() %>%
  forward_fill_missing_high_low_prices() %>%
  compute_capital_gains_by_company()


filter(temp, date == "1913-04-18", Company == "RL047")
temp_prices <- filter(prices, Company == "RL047")
temp_prices <- filter(prices, date == "1913-06-05")






















