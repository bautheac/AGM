pacman::p_load(here, modules)


path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_events_data_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "events", "transformer", "main.r")
events_data_transformer <- modules::use(path_events_data_transformer)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)


path_clean_events_data <- here::here("data", "events_clean.rds")


raw_events <- data_extracter$extract_raw_price_data()
clean_events <- events_data_transformer$transform_events(raw_events)


data_loader$load_rds(clean_events, path_clean_events_data)


rm(list = ls())
