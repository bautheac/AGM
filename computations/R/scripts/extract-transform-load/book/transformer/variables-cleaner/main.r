suppressMessages({ import(dplyr); import(here); import(lubridate); import(stringr) })

path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "transformer", 
  "variables-cleaner", "globals", "paths.r"
)
paths <- modules::use(path_paths)

corrupts_cleaner <- modules::use(paths$path_local_corrupts_cleaner)


convert_to_standard_date_format_from_excel <- function(dates) {
  
  dates <- stringr::str_replace(dates, "^\\d{1}$", NA_character_)
  
  dates <- stringr::str_replace(dates, "^\\*+$", NA_character_)
  
  ifelse(
    # If the column is numeric, 
    !is.na(as.numeric(dates)),
    # convert using Excel origin,
    as.Date(as.numeric(dates), origin = "1899-12-30"),
    # otherwise, attempt to parse string dates.
    lubridate::dmy(dates) # Parse dates in "day/month/year" format
  ) |> as.Date() |> as.character()
}

format_dates <- function(book_data, format_function){
  
  dplyr::mutate(
    book_data, 
    dplyr::across(
      .cols = matches("date|day", ignore.case = TRUE) & !matches("available", ignore.case = TRUE), 
      .fns = format_function
    )
  )
}



modules::export("clean_date_variables")
clean_date_variables <- function(book_data){
  
  corrupts_cleaner$correct_unformatted_date_typos(book_data) |>
    format_dates(convert_to_standard_date_format_from_excel) |>
    corrupts_cleaner$correct_formatted_date_typos()
}