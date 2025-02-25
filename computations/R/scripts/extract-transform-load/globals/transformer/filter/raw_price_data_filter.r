suppressMessages({
  modules::import(dplyr)
  modules::import(here)
})


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer",
  "filter", "globals", "paths.r"
)
paths <- modules::use(path_paths)

filter_global <- modules::use(paths$path_filter_global)

modules::export("filter_out_records_with_corrupt_date")
filter_out_records_with_corrupt_date <- function(price_data) {
  dplyr::filter(price_data, date != "", date != "date")
}

modules::export("filter_out_irrelvant_raw_records")
filter_out_irrelvant_raw_records <- function(price_data) {
  dplyr::group_by(price_data, id) |>
    filter_global$filter_out_first_row() |>
    dplyr::ungroup() |>
    filter_out_records_with_corrupt_date()
}

filter_out_records_where_data_unavailable <- function(price_data) {
  dplyr::filter(price_data, `data available` != "no")
}

modules::export("filter_out_irrelvant_clean_records")
filter_out_irrelvant_clean_records <- function(price_data) {
  filter_out_records_where_data_unavailable(price_data) |>
    filter_global$filter_out_records_with_nas_in_columns(c("low", "high"))
}
