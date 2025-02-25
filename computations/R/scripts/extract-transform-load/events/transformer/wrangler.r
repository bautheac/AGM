suppressMessages({ modules::import(dplyr); modules::import(here); modules::import(lubridate); modules::import(tidyr) })


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer", 
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

variables_cleaner <- modules::use(paths$path_variables_cleaner)
filter <- modules::use(paths$path_filter)


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
