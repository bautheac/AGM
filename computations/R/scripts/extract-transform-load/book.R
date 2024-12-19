pacman::p_load(dplyr, haven, here, modules, readxl)

path_book_transformer <- here::here("computations", "R", "scripts", "extract-transform-load", "book", "book_transformer.r")
book_transformer <- modules::use(path_book_transformer)

path_company_names <- here::here("computations", "stata", "companynames.dta")
path_book_data <- here::here("data", "H and peck data_Final.xlsx")
sheet_book_data <- "Dataset"

company_names <- haven::read_dta(path_company_names)
book_data <- readxl::read_excel(path_book_data, sheet_book_data)


clean <- book_transformer$transform_book_data(book_data)

readr::write_rds(clean, here::here("data", "book_clean.rds"))
