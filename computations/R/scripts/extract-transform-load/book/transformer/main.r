suppressMessages({ modules::import(dplyr); modules::import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "transformer", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

names_cleaner <- modules::use(paths$path_names_cleaner)
variables_selecter <- modules::use(paths$path_variables_selecter)
variables_cleaner <- modules::use(paths$path_variables_cleaner)
filter <- modules::use(paths$path_filter)


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
    variables_cleaner$clean_date_variables() |>
    transform_reporting_frequency_variable() |>
    transform_check_variables() |>
    filter$filter_out_pending_corrupt_records()
}
