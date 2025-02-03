pacman::p_load(here, modules)


path_book_corrupts <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals", "corrupts.r"
)
book_corrupts <- modules::use(path_book_corrupts)


filter_out_empty_or_na_events <- function(event_data) {
  
  dplyr::filter(event_data, !(is.na(event) | event == ""))
}

filter_out_pending_book_corrupt_records <- function(event_data) {
  
  dplyr::filter(event_data, !(id %in% book_corrupts$pending$id))
}

modules::export("filter_out_irrelevant_event_data")
filter_out_irrelevant_event_data <- function(event_data) {
  
  filter_out_empty_or_na_events(event_data) |>
    filter_out_pending_book_corrupt_records()
}

  