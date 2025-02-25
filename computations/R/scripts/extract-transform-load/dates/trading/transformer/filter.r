suppressMessages({ modules::import(dplyr); modules::import(here) })


path_global_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "filter", "raw_price_data_filter.r")
global_filter <- modules::use(path_global_filter)

filter_out_records_with_corrupt_dates <- function(dates_data) {
  
  dplyr::filter(dates_data, !(is.na(date) | date == ""))
}

filter_out_non_trading_date_records <- function(dates_data) {
  
  dplyr::filter(dates_data, trading)
}

keep_unique_trading_dates <- function(dates_data) {
  
  dplyr::distinct(dates_data, date)
}

modules::export("filter_out_irrelevant_data")
filter_out_irrelevant_data <- function(dates_data) {
  
  dplyr::mutate(dates_data, date = as.character(date)) |>
    global_filter$filter_out_records_with_corrupt_date() |>
    filter_out_non_trading_date_records() |>
    keep_unique_trading_dates()
}

