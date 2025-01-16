pacman::p_load(dplyr, modules)

path_filter_global <- here::here("computations", "R", "scripts", "extract-transform-load", "filter.r")
filter_global <- modules::use(path_filter_global)

filter_out_records_with_corrupt_date <- function(price_data) {
  
  dplyr::filter(price_data, date != "", date != "date")
}

filter_out_irrelvant_records <- function(price_data) {
  
  dplyr::group_by(price_data, id) |> 
    filter_global$filter_out_first_row() |>
    dplyr::ungroup() |>
    filter_global$filter_out_records_with_nas_in_columns(c("low", "high")) |>
    filter_out_records_with_corrupt_date()
}