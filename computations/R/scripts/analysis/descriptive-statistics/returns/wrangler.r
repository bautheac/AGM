pacman::p_load(dplyr, here, modules, purrr, rlang, tidyr)


path_extracter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", "extracter.r"
)
extracter <- modules::use(path_extracter)


collect_disctinct_variable_in_datasets <- function(variable, datasets) {
  
  variable_sym <- rlang::sym(variable)
  
  purrr::map(datasets, ~ dplyr::distinct(.x, !!variable_sym)) |> 
    purrr::reduce(dplyr::full_join, by = variable)
}

make_date_id_combinations <- function(dates, ids) { dplyr::cross_join(dates, ids) }

subtract_x_months_from_date <- function(date, months) {
  
  lubridate::`%m-%`(date, months(months))
}

make_reporting_period_bound_dates <- function(dates_reporting_subset) {
  
  dplyr::group_by(dates_reporting_subset, id) |>
    dplyr::mutate(
      `reporting period start` = lubridate::`%m-%`(lubridate::ymd(dplyr::lag(`date of reporting period end`)), lubridate::days(1L)),
      `reporting period end` = lubridate::ymd(`date of reporting period end`)
    ) |> 
    dplyr::select(-`date of reporting period end`) |> dplyr::ungroup()
}

make_start_date_for_id_first_reporting_period <- function(dates_reporting_augmented){
  
  dplyr::mutate(
    dates_reporting_augmented,
    `reporting period start` = dplyr::if_else(
      is.na(`reporting period start`) & `reporting frequency` == "annually", 
      subtract_x_months_from_date(`reporting period end`, 12L), `reporting period start`
    ),
    `reporting period start` = dplyr::if_else(
      is.na(`reporting period start`) & `reporting frequency` == "semi-annually", 
      subtract_x_months_from_date(`reporting period end`, 6L), `reporting period start`
    )
  )
}

make_reporting_period_daily_dates <- function(dates_reporting_augmented){
  
  dplyr::mutate(
    dates_reporting_augmented, 
    date = purrr::map2(`reporting period start`, `reporting period end`, ~ seq(.x, .y, by = "1 day"))
  )
}
  
make_long_reporting_dates_dataset <- function(dates_reporting_clean) {
  
  dplyr::select(
    dates_reporting_clean, 
    id, `reporting frequency`, year, `reporting period`, `date of reporting period end`
  ) |>
    make_reporting_period_bound_dates() |>
    make_start_date_for_id_first_reporting_period() |>
    make_reporting_period_daily_dates() |>
    dplyr::select(-`reporting period start`, -`reporting period end`) |>
    tidyr::unnest(date)
}

modules::export("make_dataset")
make_dataset <- function() {
  
  subdatasets <- extracter$extract_subdatasets()
  
  distinct_ids <- collect_disctinct_variable_in_datasets(
    "id", list(subdatasets$events, subdatasets$returns)
  )
  
  date_id_combinations <- make_date_id_combinations(subdatasets$dates_days, distinct_ids)
  
  dplyr::left_join(date_id_combinations, subdatasets$events, by = c("id", "date")) |>
    dplyr::left_join(subdatasets$returns, by = c("id", "date")) |>
    dplyr::left_join(make_long_reporting_dates_dataset(subdatasets$dates_reporting), by = c("id", "date")) |>
    dplyr::arrange(id, date)
}