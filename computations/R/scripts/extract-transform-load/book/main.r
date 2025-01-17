pacman::p_load(here, modules)

path_data_extracter <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_book_transformer <- here::here("computations", "R", "scripts", "extract-transform-load", "book", "transformer", "main.r")
book_data_transformer <- modules::use(path_book_transformer)
path_data_loader <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)


path_clean_book_data <- here::here("data", "book_clean.rds")


raw_book_data <- data_extracter$extract_book_data()
clean <- book_data_transformer$transform_book_data(raw_book_data)


data_loader$load_rds(clean, path_clean_book_data)


rm(list = ls())