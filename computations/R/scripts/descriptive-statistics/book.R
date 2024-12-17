pacman::p_load(dplyr, haven, here, purrr, readr)

path_book_data_clean <- here::here("data", "book_clean.rds")
book_data <- readr::read_rds(path_book_data_clean)

filter_out_ids_not_in_price_dataset <- function(book_data) {
  path_prices <- here::here("computations", "stata", "AGMdata.dta")
  ids <- haven::read_dta(path_prices) |> dplyr::select(Company) |> unique() |> purrr::flatten_chr()
  
  dplyr::filter(book_data, ID %in% ids)
}

variables_to_summarise <- c(
  "BVE", "Total Assets", "Non-Current Assets", "Current Assets", "Total Liabilities", 
  "Non-current Liabilities", "Current Liabilities", "Total Debt", "Bank Debt", 
  "Other Debt", "Cash", "Intangibles/ Goodwill",
  "Net profit", "EBIT (tax/int)", "Income tax", "Dividends paymment for the year",
  "Depreciation", "Interest", "Gross Profit", "Sales", "Number of shares outstanding"
)
statistics_to_compute <- list(
  n = ~sum(!is.na(.) & . != 0L),
  min = ~min(.[. != 0L], na.rm = TRUE),
  max = ~max(.[. != 0L], na.rm = TRUE),
  mean = ~mean(.[. != 0L], na.rm = TRUE),
  sd = ~sd(.[. != 0L], na.rm = TRUE)
)

descriptive_stats_by_year <- filter_out_ids_not_in_price_dataset(book_data) |>
  dplyr::mutate(year = lubridate::year(`Year end date`)) |> 
  dplyr::filter(dplyr::if_all(dplyr::contains("valid"), ~ .x == 1L), !is.na(year)) |>
  dplyr::group_by(year) |>
  dplyr::summarise(dplyr::across(variables_to_summarise, statistics_to_compute, .names = "{.col}_{.fn}")) |>
  tidyr::pivot_longer(cols = -year, names_to = c("variable", "statistic"), names_sep = "_", values_to = "value") |>
  tidyr::pivot_wider(names_from = variable, values_from = value)
  
path_book_descriptive_stats <- here::here("computations", "R", "results", "book_descriptive_stats.rds")
readr::write_rds(descriptive_stats_by_year, path_book_descriptive_stats)
  
  
  
  
  