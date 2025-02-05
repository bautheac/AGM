suppressMessages({ import(dplyr); import(lubridate); import(purrr) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "globals", "paths.r"
)
paths <- modules::use(path_paths)

local_extracter <- modules::use(paths$path_local_extracter)
global_extracter <- modules::use(paths$path_global_extracter)
book_local_variables <- modules::use(paths$path_etl_book_local_variables)
local_variables <- modules::use(paths$path_local_variables)

returns_firm_local_variables <- modules::use(paths$path_returns_firm_local_variables)


select_high_availability_variables <- function(book_descriptive_statistics){

  dplyr::filter(
    book_descriptive_statistics, 
    `reporting frequency` == "all",
    variable %in% book_local_variables$book_variables,
    statistic == "n",
    dplyr::if_all(
      as.character(local_variables$years_of_interest), 
      ~ . >= local_variables$high_availability_book_threshold
    )
  ) |>
    dplyr::mutate(variable = as.character(variable)) |>
    dplyr::select(variable) |> purrr::flatten_chr()
}


modules::export("select_high_availability_book_firms")
select_high_availability_book_firms <- function(){
  
  book_descriptive_statistics <- local_extracter$extract_book_descriptive_statistics()
  book_data_clean <- global_extracter$extract_clean_book_data()
  
  
  high_availablity_variables <- select_high_availability_variables(book_descriptive_statistics)
  
  dplyr::mutate(book_data_clean, year = lubridate::year(`date of reporting period end`)) |>
    dplyr::select(id, year, high_availablity_variables) |>
    dplyr::filter(
      year %in% local_variables$years_of_interest,
      dplyr::if_all(high_availablity_variables, ~ !is.na(.))
    ) |> 
    dplyr::select(id) |> purrr::flatten_chr() |> unique()
}


modules::export("select_high_availability_returns_firms")
select_high_availability_returns_firms <- function(){
  
  returns_firms_descriptive_statistics <- local_extracter$extract_returns_firms_descriptive_statistics()

  dplyr::filter(
    returns_firms_descriptive_statistics,
    year %in% local_variables$years_of_interest,
    dplyr::if_all(
      returns_firm_local_variables$firm_days_available_variables, 
      ~ . >= local_variables$high_availability_returns_threshold
    )
  ) |> 
    dplyr::select(id) |> purrr::flatten_chr() |> unique()
}

