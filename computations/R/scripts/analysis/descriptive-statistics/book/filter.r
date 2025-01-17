pacman::p_load(dplyr, here, modules)


path_data_extracter <- here::here("computations", "R", "scripts", "extract-transform-load", "extracter.r")
data_extracter <- modules::use(path_data_extracter)
path_data_filter_main <- here::here("computations", "R", "scripts", "extract-transform-load", "filter.r")
data_filter_main <- modules::use(path_data_filter_main)
path_data_wrangler <- here::here("computations", "R", "scripts", "extract-transform-load", "wrangler.r")
data_wrangler <- modules::use(path_data_wrangler)


filter_out_ids_not_in_price_dataset <- function(book_data) {
  
  path_prices <- here::here("computations", "stata", "AGMdata.dta")
  prices <- data_extracter$extract_stata_data(path_prices)
  ids <- data_wrangler$extract_uniques(prices, "Company")

  data_filter_main$filter_out_values_not_matching(book_data, "id", ids)
}

filter_out_invalid_total_assets_or_total_liabilities <- function(book_data) {
  
  dplyr::filter(book_data, dplyr::if_all(dplyr::contains("valid"), ~ .x == 1L))
}

filter_out_records_with_na_year <- function(book_data) {
  
  data_filter_main$filter_out_records_with_nas_in_any_columns(book_data, c("year"))
}

modules::export("filter_out_irrelevant_data")
filter_out_irrelevant_data <- function(book_data) {
  
  filter_out_ids_not_in_price_dataset(book_data) |>
    filter_out_invalid_total_assets_or_total_liabilities() |>
    filter_out_records_with_na_year()
}