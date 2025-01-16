pacman::p_load(here, modules)

path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_data_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "returns", "filter.r")
data_filter <- modules::use(path_data_filter)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "returns", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)
path_returns_computer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "returns", "returns_computer.r")
returns_computer <- modules::use(path_returns_computer)


path_clean_price_data <- here::here("data", "prices_clean.rds")
price_data <- data_extracter$extract_rds_data(path_clean_price_data)

returns <- data_filter$filter_out_irrelevant_data(price_data) |>
  returns_computer$compute_returns() |>
  variables_selecter$select_relevant_variables()


