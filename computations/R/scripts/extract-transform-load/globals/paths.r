suppressMessages(modules::import(here))


filename_book_data <- "H and peck data_Final.xlsx"
modules::export("worksheet_book_data")
worksheet_book_data <- "Dataset"

filename_price_data <- "AGMdata.dta"

filename_clean_dates_reporting <- "dates_reporting_clean.rds"
filename_clean_dates_trading <- "dates_trading_clean.rds"

filename_clean_names <- "names_clean.rds"

filename_clean_events <- "events_clean.rds"

filename_clean_book_data <- "book_clean.rds"

filename_clean_price_data <- "prices_clean.rds"

filename_clean_returns_data <- "returns_clean.rds"
  

modules::export("path_data_directory")
path_data_directory <- here::here("data")

modules::export("path_raw_names_data")
path_raw_names_data <- here::here(path_data_directory, filename_book_data)

modules::export("path_raw_price_data")
path_raw_price_data <- here::here("computations", "stata", filename_price_data)

modules::export("path_clean_dates_reporting_data")
path_clean_dates_reporting_data <- here::here(path_data_directory, filename_clean_dates_reporting)

modules::export("path_clean_dates_trading_data")
path_clean_dates_trading_data <- here::here(path_data_directory, filename_clean_dates_trading)

modules::export("path_clean_names_data")
path_clean_names_data <- here::here(path_data_directory, filename_clean_names)

modules::export("path_clean_events_data")
path_clean_events_data <- here::here(path_data_directory, filename_clean_events)

modules::export("path_clean_book_data")
path_clean_book_data <- here::here(path_data_directory, filename_clean_book_data)

modules::export("path_clean_prices_data")
path_clean_prices_data <- here::here(path_data_directory, filename_clean_price_data)

modules::export("path_clean_returns_data")
path_clean_returns_data <- here::here(path_data_directory, filename_clean_returns_data)

