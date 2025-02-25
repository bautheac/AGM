suppressPackageStartupMessages({
  modules::import(haven)
  modules::import(readxl)
})


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "paths.r"
)
paths <- modules::use(path_paths)

modules::export("extract_stata_data")
extract_stata_data <- function(path_data) {
  return(haven::read_dta(path_data))
}

modules::export("extract_xlsx_data")
extract_xlsx_data <- function(path_data, sheet_data) {
  return(readxl::read_excel(path_data, sheet_data))
}

modules::export("extract_rds_data")
extract_rds_data <- function(path_data) {
  return(readr::read_rds(path_data))
}

modules::export("extract_raw_book_data")
extract_raw_book_data <- function() {
  extract_xlsx_data(paths$path_raw_names_data, paths$worksheet_book_data)
}

modules::export("extract_raw_price_data")
extract_raw_price_data <- function() {
  extract_stata_data(paths$path_raw_price_data)
}

modules::export("extract_clean_dates_reporting_data")
extract_clean_dates_reporting_data <- function() {
  extract_rds_data(paths$path_clean_dates_reporting_data)
}

modules::export("extract_clean_dates_trading_data")
extract_clean_dates_trading_data <- function() {
  extract_rds_data(paths$path_clean_dates_trading_data)
}

modules::export("extract_clean_dates_data")
extract_clean_dates_data <- function(type = c("reporting", "trading")) {
  dplyr::case_when(
    type == "reporting" ~ extract_clean_dates_reporting_data(),
    type == "trading" ~ extract_clean_dates_trading_data()
  )
}

modules::export("extract_clean_names_data")
extract_clean_names_data <- function() {
  extract_rds_data(paths$path_clean_names_data)
}

modules::export("extract_clean_events_data")
extract_clean_events_data <- function() {
  extract_rds_data(paths$path_clean_events_data)
}

modules::export("extract_clean_book_data")
extract_clean_book_data <- function() {
  extract_rds_data(paths$path_clean_book_data)
}

modules::export("extract_clean_prices_data")
extract_clean_prices_data <- function() {
  extract_rds_data(paths$path_clean_prices_data)
}

modules::export("extract_clean_returns_data")
extract_clean_returns_data <- function() {
  extract_rds_data(paths$path_clean_returns_data)
}
