suppressMessages({ import(dplyr); import(here); import(lubridate); import(purrr); import(rlang); import(tidyr) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "wrangler", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_extracter)
filter <- modules::use(paths$path_filter)
selecter <- modules::use(paths$path_selecter)


collect_disctinct_variable_in_datasets <- function(variable, datasets) {
  
  variable_sym <- rlang::sym(variable)
  
  purrr::map(datasets, ~ dplyr::distinct(.x, !!variable_sym)) |> 
    purrr::reduce(dplyr::full_join, by = variable)
}

make_date_id_combinations <- function(dates, ids){ dplyr::cross_join(dates, ids) }

compute_reporting_period_dates <- function(date_columns, fun){
  
  dates <- purrr::pmap_chr(date_columns, ~ { do.call(fun, list(c(...), na.rm = TRUE)) })
  
  return(dates)
}

make_reporting_period_bound_dates <- function(dates_reporting_subset) {
  
  dplyr::group_by(dates_reporting_subset, id) |>
    dplyr::mutate(
      `reporting period start` = compute_reporting_period_dates(
        dplyr::pick(dplyr::contains(c("date", "day"))), min
      ),
      `reporting period end` = compute_reporting_period_dates(
        dplyr::pick(dplyr::contains(c("date", "day"))), max
      )
    ) |> dplyr::ungroup()
}

make_reporting_period_daily_dates <- function(dates_reporting_augmented){
  
  dplyr::mutate(
    dates_reporting_augmented, 
    date = purrr::map2(
      `reporting period start`, `reporting period end`, ~ seq(.x, .y, by = "1 day")
    )
  )
}

make_reporting_period_daily_dates <- function(dates_reporting_augmented){
  
  dplyr::mutate(
    dates_reporting_augmented, 
    dplyr::across(c(`reporting period start`, `reporting period end`), lubridate::ymd),
    date = purrr::map2(
      `reporting period start`, `reporting period end`, ~ seq(.x, .y, by = "1 day")
    )
  )
}

make_long_reporting_dates_dataset <- function(dates_reporting_clean) {
  
  filter$filter_out_reporting_periods_with_no_event_dates(dates_reporting_clean) |>
    make_reporting_period_bound_dates() |>
    make_reporting_period_daily_dates() |>
    selecter$select_reporting_periods_relevant_variables() |>
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
    dplyr::left_join(
      make_long_reporting_dates_dataset(subdatasets$dates_reporting), by = c("id", "date")
    ) |>
    dplyr::arrange(id, date)
}
