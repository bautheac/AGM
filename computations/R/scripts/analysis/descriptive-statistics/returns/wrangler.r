pacman::p_load(dplyr, here, modules, purrr, rlang, tidyr)


path_extracter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", "extracter.r"
)
extracter <- modules::use(path_extracter)
path_variables_selecter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "variables_selecter.r"
)
variables_selecter <- modules::use(path_variables_selecter)


collect_disctinct_variable_in_datasets <- function(variable, datasets) {
  
  variable_sym <- rlang::sym(variable)
  
  purrr::map(datasets, ~ dplyr::distinct(.x, !!variable_sym)) |> 
    purrr::reduce(dplyr::full_join, by = variable)
}

make_date_id_combinations <- function(dates, ids) { dplyr::cross_join(dates, ids) }

subtract_x_months_from_date <- function(date, months) {
  
  lubridate::`%m-%`(date, months(months))
}

add_x_months_to_date <- function(date, months) {
  
  lubridate::`%m+%`(date, months(months))
}

make_reporting_period_bound_dates <- function(dates_reporting_subset) {
  
  dplyr::group_by(dates_reporting_subset, id) |>
    dplyr::mutate(
      `reporting period start` = lubridate::`%m-%`(lubridate::ymd(dplyr::lag(`date of reporting period end`)), lubridate::days(1L)),
      `reporting period end` = lubridate::ymd(`date of reporting period end`)
    ) |> dplyr::ungroup()
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


make_next_reporting_period_start_date <- function(date_of_last_reporting_period_end){
  
  lubridate::`%m+%`(lubridate::ymd(date_of_last_reporting_period_end), lubridate::days(1L))
}

make_next_reporting_period_end_date <- 
  function(date_of_last_reporting_period_end, reporting_frequency){
  
  end_date <- lubridate::ymd(date_of_last_reporting_period_end)
  
  dplyr::case_when(
    reporting_frequency == 
      "annually" ~ add_x_months_to_date(end_date, 12L),
    reporting_frequency == 
      "semi-annually" ~ add_x_months_to_date(end_date, 6L)
  )
}

compute_next_reporting_period_number <- 
  function(next_period_year, last_reporting_period_year, last_reporting_period_number){
  
  dplyr::if_else(next_period_year == last_reporting_period_year, last_reporting_period_number + 1L, 1L)
}

make_next_reporting_period_bounds <- function(last_period){
  
  start_date <- make_next_reporting_period_start_date(last_period$`date of reporting period end`)
  end_date <- make_next_reporting_period_end_date(last_period$`date of reporting period end`, last_period$`reporting frequency`)
  
  dplyr::mutate(
    last_period, 
    year = lubridate::year(end_date), 
    `reporting period` = 
      compute_next_reporting_period_number(year, last_period$year, last_period$`reporting period`),
    `reporting period start` = start_date, 
    `reporting period end` = end_date
    )
}

AGM_date_later_than_reporting_period_end_date <- function(AGM_date, reporting_period_end_date) {
  
  if(is.na(AGM_date) | is.na(reporting_period_end_date)) return(FALSE)
  
  AGM_date > reporting_period_end_date
}

add_next_reporting_period_bounds <- function(dates_reporting_augmented){
  
  dplyr::group_by(dates_reporting_augmented, id) |>
    dplyr::group_modify(~ {
      
      last_period <- dplyr::arrange(.x, `date of reporting period end`) |> 
        dplyr::slice_tail(n = 1L)
      
      if (
        AGM_date_later_than_reporting_period_end_date(last_period$`date of AGM`, last_period$`date of reporting period end`)
      ) {
        
        next_period <- make_next_reporting_period_bounds(last_period)
        dplyr::bind_rows(.x, next_period)
      } else {.x }
    }) |> 
    dplyr::ungroup()
}

make_reporting_period_daily_dates <- function(dates_reporting_augmented){
  
  dplyr::mutate(
    dates_reporting_augmented, 
    date = purrr::map2(`reporting period start`, `reporting period end`, ~ seq(.x, .y, by = "1 day"))
  )
}

make_long_reporting_dates_dataset <- function(dates_reporting_clean) {
  
  make_reporting_period_bound_dates(dates_reporting_clean) |>
    make_start_date_for_id_first_reporting_period() |>
    add_next_reporting_period_bounds() |>
    make_reporting_period_daily_dates() |>
    variables_selecter$select_reporting_periods_relevant_variables() |>
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