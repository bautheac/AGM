pacman::p_load(dplyr, lubridate, modules)

path_data_wrangler_main <- here::here("computations", "R", "scripts", "extract-transform-load", "wrangler.r")
data_wrangler_main <- modules::use(path_data_wrangler_main)
path_data_filter <- 
  here::here("computations", "R", "scripts", "descriptive-statistics", "book", "filter.r")
data_filter <- modules::use(path_data_filter)

extract_year_from_date_column <- function(data, date_column){
  dplyr::mutate(
    data, 
    year = dplyr::if_else(
      is.na(as.Date(!!rlang::sym(date_column))),
      NA_integer_,  # or NA_real_ 
      lubridate::year(as.Date(!!rlang::sym(date_column)))
    )
  )
}

make_reporting_period_variable <- function(data){
  dplyr::arrange(data, id, year) |> dplyr::group_by(id, year) |>
    dplyr::mutate(`reporting period` = dplyr::row_number()) |>
    dplyr::ungroup()
}

calculate_length_of_closed_books_period_in_days <- function(data){
    dplyr::mutate(
      data,
      `length of closed books period` = as.numeric(
        lubridate::ymd(`last day of closed books`) - lubridate::ymd(`first day of closed books`)
      )
    )
}

calculate_length_of_period_between_end_of_closed_books_and_AGM <- function(data){
  dplyr::mutate(
    data,
    `length of period between end of closed books and AGM` = as.numeric(
      lubridate::ymd(`date of AGM`) - lubridate::ymd(`last day of closed books`)
    )
  )
}

check_AGM_date_within_closed_books_period <- function(data){
  dplyr::mutate(
    data,
    `AGM date within closed books period` = lubridate::`%within%`(
      lubridate::ymd(`date of AGM`), 
      lubridate::interval(lubridate::ymd(`first day of closed books`), lubridate::ymd(`last day of closed books`))
    )
  )
}

modules::export("prepare_dataset_for_descriptive_stats_analysis")
prepare_dataset_for_descriptive_stats_analysis <- function(data){

  extract_year_from_date_column(data, "date of year end") |>
    make_reporting_period_variable() |>
    calculate_length_of_closed_books_period_in_days() |>
    check_AGM_date_within_closed_books_period() |>
    calculate_length_of_period_between_end_of_closed_books_and_AGM() |>
    data_filter$filter_out_ids_not_in_price_dataset() |>
    data_filter$filter_out_invalid_total_assets_or_total_liabilities() |>
    data_filter$filter_out_records_with_na_year()
}
