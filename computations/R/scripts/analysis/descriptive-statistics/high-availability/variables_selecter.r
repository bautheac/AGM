pacman::p_load(dplyr, modules)


path_local_extracter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "extracter.r"
)
local_extracter <- modules::use(path_local_extracter)
path_global_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)
global_extracter <- modules::use(path_global_extracter)
path_book_global_variables <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals", 
  "variables.r"
)
book_global_variables <- modules::use(path_book_global_variables)
path_local_global_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "globals", "variables.r"
)
local_global_variables <- modules::use(path_local_global_variables)


select_high_availability_variables <- function(book_descriptive_statistics){

  dplyr::filter(
    book_descriptive_statistics, 
    `reporting frequency` == "all",
    variable %in% book_global_variables$book_variables,
    statistic == "n",
    dplyr::if_all(
      as.character(local_global_variables$years_of_interest), 
      ~ . >= local_global_variables$high_availability_threshold
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
  
  browser()
  dplyr::mutate(book_data_clean, year = lubridate::year(`date of reporting period end`)) |>
    dplyr::select(id, year, high_availablity_variables) |>
    dplyr::filter(
      year %in% local_global_variables$years_of_interest,
      dplyr::if_all(high_availablity_variables, ~ !is.na(.))
    ) |> 
    dplyr::select(id) |> purrr::flatten_chr() |> unique()
}

