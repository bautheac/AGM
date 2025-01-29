pacman::p_load(haven, modules, readxl)


path_etl_global_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "paths.r"
)
etl_global_paths <- modules::use(path_etl_global_paths)


modules::export("extract_stata_data")
extract_stata_data <- function(path_data){
  
  return(haven::read_dta(path_data))
}

modules::export("extract_xlsx_data")
extract_xlsx_data <- function(path_data, sheet_data){
  
  return(readxl::read_excel(path_data, sheet_data))
}

modules::export("extract_rds_data")
extract_rds_data <- function(path_data){
  
  return(readr::read_rds(path_data))
}

modules::export("extract_raw_book_data")
extract_raw_book_data <- function(){
  
  path_raw_names_data <- here::here(etl_global_paths$path_data_directory, "H and peck data_Final.xlsx")
  sheet_book_data <- "Dataset"
  
  extract_xlsx_data(path_raw_names_data, sheet_book_data)
}

modules::export("extract_raw_price_data")
extract_raw_price_data <- function(){
  
  path_raw_price_data <- here::here("computations", "stata", "AGMdata.dta")
  
  extract_stata_data(path_raw_price_data)
}

modules::export("extract_clean_dates_data")
extract_clean_dates_data <- function(type = c("reporting", "trading")){
  
  dates_file_name <- paste("dates", type, "clean.rds", sep = "_")
  path_clean_dates_data <- here::here(etl_global_paths$path_data_directory, dates_file_name)
  
  extract_rds_data(path_clean_dates_data)
}

modules::export("extract_clean_dates_trading_data")
extract_clean_dates_trading_data <- function(){
  
  extract_clean_dates_data("trading")
}

modules::export("extract_clean_dates_reporting_data")
extract_clean_dates_reporting_data <- function(){
  
  extract_clean_dates_data("reporting")
}

modules::export("extract_clean_names_data")
extract_clean_names_data <- function(){
  
  path_clean_names_data <- here::here(etl_global_paths$path_data_directory, "names_clean.rds")
  
  extract_rds_data(path_clean_names_data)
}

modules::export("extract_clean_events_data")
extract_clean_events_data <- function(){
  
  path_clean_events_data <- here::here(etl_global_paths$path_data_directory, "events_clean.rds")
  
  extract_rds_data(path_clean_events_data)
}

modules::export("extract_clean_book_data")
extract_clean_book_data <- function(){
  
  path_clean_book_data <- here::here(etl_global_paths$path_data_directory, "book_clean.rds")
  
  extract_rds_data(path_clean_book_data)
}

modules::export("extract_clean_prices_data")
extract_clean_prices_data <- function(){
  
  path_clean_prices_data <- here::here(etl_global_paths$path_data_directory, "prices_clean.rds")
  
  extract_rds_data(path_clean_prices_data)
}

modules::export("extract_clean_returns_data")
extract_clean_returns_data <- function(){
  
  path_clean_returns_data <- here::here(etl_global_paths$path_data_directory, "returns_clean.rds")
  
  extract_rds_data(path_clean_returns_data)
}