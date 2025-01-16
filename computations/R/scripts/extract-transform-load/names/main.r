pacman::p_load(here, modules)


path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_price_data_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "names", "transformer", "main.r")
price_data_transformer <- modules::use(path_price_data_transformer)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)


path_raw_names_data <- here::here("computations", "stata", "AGMdata.dta")
path_clean_names_data <- here::here("data", "names_clean.rds")


raw_names <- data_extracter$extract_stata_data(path_raw_names_data)
clean_names <- price_data_transformer$transform_names(raw_names)


data_loader$load_rds(clean_prices, path_clean_names_data)
