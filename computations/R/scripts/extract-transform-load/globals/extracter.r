pacman::p_load(haven, modules, readxl)

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

modules::export("extract_book_data")
extract_book_data <- function(){
  
  path_raw_names_data <- here::here("data", "H and peck data_Final.xlsx")
  sheet_book_data <- "Dataset"
  
  extract_xlsx_data(path_raw_names_data, sheet_book_data)
}

modules::export("extract_price_data")
extract_price_data <- function(){
  
  path_raw_price_data <- here::here("computations", "stata", "AGMdata.dta")
  
  extract_stata_data(path_raw_price_data)
}