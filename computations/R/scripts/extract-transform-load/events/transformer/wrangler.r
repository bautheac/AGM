pacman::p_load(dplyr, modules, tidyr)


path_corrupts_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer", 
  "corrupts_cleaner.r"
)
corrupts_cleaner <- modules::use(path_corrupts_cleaner)


separate_multiple_event_dates_into_separate_rows <- function(events_data){
  
  tidyr::separate_rows(events_data, event, sep = " ")
}

modules::export("transform_relevant_variables")
transform_relevant_variables <- function(events_data){
  
  corrupts_cleaner$clean_corrupts_event_records(events_data) |>
    separate_multiple_event_dates_into_separate_rows() |>
    corrupts_cleaner$add_missing_records() |>
    dplyr::filter(!(is.na(event) | event == "")) |>
    dplyr::distinct(id, date, event) |>
    dplyr::arrange(id, date)
}