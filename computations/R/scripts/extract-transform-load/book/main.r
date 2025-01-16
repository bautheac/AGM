pacman::p_load(here, modules)

path_data_extracter <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_book_transformer <- here::here("computations", "R", "scripts", "extract-transform-load", "book", "transformer", "main.r")
book_data_transformer <- modules::use(path_book_transformer)
path_data_loader <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "loader.r")
data_loader <- modules::use(path_data_loader)


path_raw_book_data <- here::here("data", "H and peck data_Final.xlsx")
sheet_book_data <- "Dataset"
path_clean_book_data <- here::here("data", "book_clean.rds")


raw_book_data <- data_extracter$extract_xlsx_data(path_raw_book_data, sheet_book_data)
clean <- book_data_transformer$transform_book_data(raw_book_data)


data_loader$load_rds(clean, path_clean_book_data)


rm(
  path_data_extracter, data_extracter, path_raw_book_data, sheet_book_data, 
  raw_book_data, path_book_transformer, book_data_transformer, clean, 
  path_data_loader, data_loader, path_clean_book_data
)
