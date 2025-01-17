pacman::p_load(here, modules)

path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "returns", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)
path_returns_computer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "returns", "transformer", "returns_computer.r")
returns_computer <- modules::use(path_returns_computer)
path_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "returns", "transformer", "filter.r")
filter <- modules::use(path_filter)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)


path_clean_price_data <- here::here("data", "prices_clean.rds")
path_clean_returns_data <- here::here("data", "returns_clean.rds")


price_data <- data_extracter$extract_rds_data(path_clean_price_data)


returns <- returns_computer$compute_returns(price_data) |>
  variables_selecter$select_relevant_variables() |>
  filter$filter_out_first_row_of_every_group("id")


data_loader$load_rds(returns, path_clean_returns_data)


rm(list = ls())