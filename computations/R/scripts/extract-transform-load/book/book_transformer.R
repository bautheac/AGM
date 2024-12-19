pacman::p_load(dplyr, here, lubridate, modules)

path_dates_cleaner <- here::here("computations", "R", "scripts", "extract-transform-load", "book", "dates_cleaner.r")
dates_cleaner <- modules::use(path_dates_cleaner)

rename_verification_amount_columns <- function(book_data){
  dplyr::rename_with(
    book_data,
    ~ c("Total Assets valid", "Total Liabilities valid"), 
    .cols = dplyr::matches("verification")
  )
}
rename_columns <- function(book_data){
  rename_verification_amount_columns(book_data)
}

select_relevant_columns <- function(book_data){
  dplyr::select(book_data, -No)
}

export("transform_book_data")
transform_book_data <- function(book_data){
  
  select_relevant_columns(book_data) |>
    rename_columns() |>
    dates_cleaner$clean_date_columns()
}




