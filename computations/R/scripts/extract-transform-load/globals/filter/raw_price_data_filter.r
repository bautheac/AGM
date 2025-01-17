pacman::p_load(dplyr, modules)

path_filter_global <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "filter", "main.r")
filter_global <- modules::use(path_filter_global)

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

modules::export("filter_out_irrelvant_clean_records")
filter_out_irrelvant_clean_records <- function(price_data) {
  
  filter_global$filter_out_records_with_nas_in_columns(price_data, c("low", "high")) 
}