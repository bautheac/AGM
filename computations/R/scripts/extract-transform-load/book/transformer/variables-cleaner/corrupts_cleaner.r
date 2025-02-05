suppressMessages({ import(dplyr); import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "transformer", 
  "variables-cleaner", "globals", "paths.r"
)
paths <- modules::use(path_paths)

corrupts <- modules::use(paths$path_corrupts)
corrupts_cleaner <- modules::use(paths$path_global_corrupts_cleaner)


convert_dates_to_excel_numeric <- function(dates) {
  as.numeric(as.Date(dates) - as.Date('1899-12-30'))
}

modules::export('correct_unformatted_date_typos')
correct_unformatted_date_typos <- function(book_data){
  
  dplyr::mutate(
    book_data,
    `last day of closed books` = as.numeric(as.Date(`last day of closed books`) - as.Date('1899-12-30')),
    dplyr::across(dplyr::everything(), as.character)
  ) |>
    corrupts_cleaner$correct_corrupt_records(corrupts$unformatted_date_typos)
}

modules::export('correct_formatted_date_typos')
correct_formatted_date_typos <- function(book_data){
  
  corrupts_cleaner$correct_corrupt_records(book_data, corrupts$formatted_date_typos)
}
