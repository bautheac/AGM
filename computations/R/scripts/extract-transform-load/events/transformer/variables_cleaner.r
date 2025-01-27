pacman::p_load(dplyr, here, modules)


path_corrupts <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "globals",
  "corrupts.r"
)
corrupts <- modules::use(path_corrupts)
path_corrupts_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer", 
  "corrupts_cleaner.r"
)
corrupts_cleaner <- modules::use(path_corrupts_cleaner)


modules::export("clean_corrupts_event_records")
clean_corrupts_event_records <- function(events_data){
  
  dplyr::mutate(events_data, date = as.character(date)) |>
    corrupts_cleaner$correct_corrupt_records(corrupts$corrupt_records) |>
    dplyr::filter(date != "")
}

modules::export("add_missing_records")
add_missing_records <- function(events_data){
  
  dplyr::bind_rows(events_data, corrupts$missing_records)
}