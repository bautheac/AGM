pacman::p_load(dplyr, modules, tidyr)


path_variables_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer", 
  "variables_cleaner.r"
)
variables_cleaner <- modules::use(path_variables_cleaner)
path_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer", 
  "filter.r"
)
filter <- modules::use(path_filter)


separate_multiple_event_dates_into_separate_rows <- function(events_data){
  
  tidyr::separate_rows(events_data, event, sep = " ")
}

modules::export("transform_relevant_variables")
transform_relevant_variables <- function(events_data){
  
  variables_cleaner$clean_corrupts_event_records(events_data) |>
    separate_multiple_event_dates_into_separate_rows() |>
    variables_cleaner$add_missing_records() |>
    filter$filter_out_irrelevant_event_data() |>
    dplyr::distinct(id, date, event) |>
    dplyr::mutate(date = lubridate::ymd(date)) |>
    dplyr::arrange(id, date)
}