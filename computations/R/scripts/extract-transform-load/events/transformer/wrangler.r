pacman::p_load(dplyr, modules, tidyr)


path_variables_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer", 
  "variables_cleaner.r"
)
variables_cleaner <- modules::use(path_variables_cleaner)


serata_multiple_event_dates_into_separate_rows <- function(events_data){
  
  tidyr::separate_rows(events_data, event, sep = " ")
}

modules::export("transform_relevant_variables")
transform_relevant_variables <- function(events_data){
  
  variables_cleaner$clean_corrupts_event_records(events_data) |>
    serata_multiple_event_dates_into_separate_rows() |>
    dplyr::filter(!(is.na(event) | event == ""))
}