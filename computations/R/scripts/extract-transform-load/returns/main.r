pacman::p_load(here, modules)


path_price_data_globals <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "prices", "globals.r"
)
price_data_globals <- modules::use(path_price_data_globals)
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
path_globals <- here::here("computations", "R", "scripts", "extract-transform-load", "returns", "globals.r")
globals <- modules::use(path_globals)


price_data <- data_extracter$extract_rds_data( price_data_globals$filepath_clean_prices_data_main)


clean_returns <- returns_computer$compute_returns(price_data) |>
  variables_selecter$select_relevant_variables() |>
  filter$filter_out_first_row_of_every_group("id")


data_loader$load_objects(
  list(clean_returns, clean_returns),
  list(globals$filepath_clean_returns_data_main, globals$filepath_clean_returns_data_dashboard)
)


rm(list = ls())