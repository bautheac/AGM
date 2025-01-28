pacman::p_load(here, modules)


path_data_extracter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_names_data_transformer <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "names", "transformer", "main.r")
names_data_transformer <- modules::use(path_names_data_transformer)
path_data_loader <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)
path_globals <- here::here("computations", "R", "scripts", "extract-transform-load", "names", "globals.r")
globals <- modules::use(path_globals)


raw_names <- data_extracter$extract_raw_book_data()
clean_names <- names_data_transformer$transform_names(raw_names)


data_loader$load_objects(
  list(clean_names, clean_names),
  list(globals$filepath_clean_names_data_main, globals$filepath_clean_names_data_dashboard)
)


rm(list = ls())