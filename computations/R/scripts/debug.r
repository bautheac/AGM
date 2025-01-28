
get_theoretical_time_window_bounds <- function(
    events_vector, event_labels, n_back, n_forward
) {
  event_indexes <- stringr::str_which(
    events_vector, paste(event_labels, collapse = "|")
  )
  
  low <- event_indexes[1L]; high <- event_indexes[NCOL(event_indexes)]
  low <- ifelse(low <= n_back, 1L, event_indexes[1L] - n_back)
  high <- ifelse(
    high + n_forward <= NROW(events_vector), 
    high + n_forward, NROW(events_vector)
  )
  
  c(low, high)
}

get_effective_time_window_bounds <- function(theoretical_bounds, data) {
  
  sample <- dplyr::slice(data, theoretical_bounds[1L]:theoretical_bounds[2L])
  
  event_days <- stringr::str_which(
    sample$event, paste(events_firm, collapse = "|")
  )

  low <- grepl(
    "^\\|?\\s?\\d", rev(sample$price[1L:(event_days[1L] - 1L)])
  ) %>% which() %>% max() %>% ifelse(is.infinite(.), NA, .)
  high <- grepl(
    "^\\|?\\s?\\d", 
    sample$price[(event_days[NCOL(event_days)] + 1L):nrow(sample)]
  ) %>% which() %>% min() %>% ifelse(is.infinite(.), NA, .)
  
  c(low, high)
}

path_quotes <- here::here("data", "sedol.csv")
col_types <- c("c", "D", rep("c", 7L))
data_quotes <- readr::read_csv(path_quotes, col_types = col_types)
n_back <- 125L
n_forward <- 135L
events_firm <- c("LD", "AU", "FC", "LD", "GM")
events_instrument <- c("XD")

sample <- dplyr::filter(data_quotes, id == "RL007")

bound_indexes <- get_theoretical_time_window_bounds(
  sample$event, events_firm, n_back, n_forward
)
get_effective_time_window_bounds(bound_indexes, sample)


debug(data_filter$filter_out_ids_not_in_price_dataset)
debug(data_wrangler$extract_year_from_date_colum)

unique(data$`Year end date`)


temp <- dplyr::mutate(returns, year = lubridate::year(date)) |>
  dplyr::filter(event %in% c("LD", "AU", "FC", "LC", "GM")) |>
  dplyr::group_by(id, year, event) |> dplyr::summarise(n = n())

temp <- dplyr::filter(returns, id == "BA031")




