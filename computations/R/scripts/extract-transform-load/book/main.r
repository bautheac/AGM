pacman::p_load(here)


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals", 
  "paths.r"
)
paths <- modules::use(path_paths)

data_extracter <- modules::use(paths$path_data_extracter)
book_data_transformer <- modules::use(paths$path_book_transformer)
data_loader <- modules::use(paths$path_data_loader)


raw_book_data <- data_extracter$extract_raw_book_data()
clean <- book_data_transformer$transform_book_data(raw_book_data)


data_loader$load_objects(
  list(clean, clean),
  list(paths$filepath_clean_book_data_main, paths$filepath_clean_book_data_dashboard)
)


rm(list = ls())