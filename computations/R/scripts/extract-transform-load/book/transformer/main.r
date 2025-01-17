pacman::p_load(dplyr, here, lubridate, modules)

path_names_cleaner <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "raw_book_data_names_cleaner.r")
names_cleaner <- modules::use(path_names_cleaner)
path_variables_selecter <- here::here("computations", "R", "scripts", "extract-transform-load", "book", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)
path_dates_cleaner <- here::here("computations", "R", "scripts", "extract-transform-load", "book", "transformer", "dates_cleaner.r")
dates_cleaner <- modules::use(path_dates_cleaner)

transform_reporting_frequency_variable <- function(book_data){

  dplyr::mutate(
    book_data,
    `full year` = dplyr::case_when(
      `full year` == 1L ~ "annually", `full year` == 0L ~ "semi-annually", TRUE ~ NA_character_
    )
  ) |> dplyr::rename(`reporting frequency` = `full year`)
}

transform_check_variables <- function(book_data){
  dplyr::mutate(
    book_data, 
    dplyr::across(
      .cols = dplyr::contains("valid") | dplyr::contains("available") | c("dividends", "reporting currency gbp"), 
      .fns = ~ ifelse(.x == 1L, TRUE, FALSE)
    )
  )
}

export("transform_book_data")
transform_book_data <- function(book_data){
  
  names_cleaner$rename_variables(book_data) |>
    variables_selecter$select_relevant_variables() |>
    dates_cleaner$clean_date_columns() |>
    transform_reporting_frequency_variable() |>
    transform_check_variables()
}




