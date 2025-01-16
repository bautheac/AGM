pacman::p_load(haven, modules, readxl)

export("extract_stata_data")
extract_stata_data <- function(path_data){
  
  return(haven::read_dta(path_data))
}

export("extract_xlsx_data")
extract_xlsx_data <- function(path_data, sheet_data){
  
  return(readxl::read_excel(path_data, sheet_data))
}

export("extract_rds_data")
extract_rds_data <- function(path_data){
  
  return(readr::read_rds(path_data))
}