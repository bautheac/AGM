suppressMessages({ import(dplyr); import(lubridate); import(purrr); import(rlang) })


path_local_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler", "globals", "variables.r"
)
local_variables <- modules::use(path_local_variables)


create_year_variable_from_date_variable <- function(data, date_column){

  dplyr::mutate(
    data, 
    year = dplyr::if_else(
      is.na(as.Date(!!rlang::sym(date_column))),
      NA_integer_,
      lubridate::year(as.Date(!!rlang::sym(date_column)))
    )
  )
}

create_reporting_period_variable <- function(data){

  dplyr::arrange(data, id, year) |> dplyr::group_by(id, year) |>
    dplyr::mutate(`reporting period` = dplyr::row_number()) |>
    dplyr::ungroup()
}

create_length_of_closed_books_period_variable <- function(data){

  dplyr::mutate(
    data,
    `length of closed books period (# days)` = as.numeric(
      lubridate::ymd(`last day of closed books`) - lubridate::ymd(`first day of closed books`)
    )
  )
}

create_distance_from_AGM_variable_for_variable <- function(data, variable){
  new_variable_name <- paste(local_variables$distance_to_AGM_variable_prefix, variable)
  
  dplyr::mutate(
    data,
    !!new_variable_name := dplyr::if_else(
      !is.na(lubridate::ymd(`date of AGM`)) & !is.na(lubridate::ymd(.data[[variable]])),
      as.numeric(lubridate::ymd(`date of AGM`) - lubridate::ymd(.data[[variable]])),
      NA_real_
    )
  )
}

create_distance_from_AGM_variables <- function(data, variables){
  
  purrr::reduce(
    variables, ~ create_distance_from_AGM_variable_for_variable(.x, .y), .init = data
  )
}

create_AGM_date_within_closed_books_period_variable <- function(data){
  dplyr::mutate(
    data,
    `AGM date within closed books period` = lubridate::`%within%`(
      lubridate::ymd(`date of AGM`), 
      lubridate::interval(
        lubridate::ymd(`first day of closed books`), 
        lubridate::ymd(`last day of closed books`)
      )
    )
  )
}

modules::export("create_relevant_variables")
create_relevant_variables <- function(data){
  
  create_year_variable_from_date_variable(data, "date of reporting period end") |>
    create_reporting_period_variable() |>
    create_distance_from_AGM_variables(local_variables$variables_to_compute_distance_to_AGM_for) |>
    create_length_of_closed_books_period_variable() |>
    create_AGM_date_within_closed_books_period_variable()
}
