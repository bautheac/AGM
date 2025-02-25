suppressMessages({
  modules::import(dplyr)
  modules::import(here)
})


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer",
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

events_corrupts <- modules::use(paths$path_events_corrupts)
corrupts_cleaner <- modules::use(paths$path_corrupts_cleaner)


modules::export("clean_corrupts_event_records")
clean_corrupts_event_records <- function(events_data) {
  dplyr::mutate(events_data, date = as.character(date)) |>
    corrupts_cleaner$correct_corrupt_records(events_corrupts$corrupt_records) |>
    dplyr::filter(date != "")
}

modules::export("add_missing_records")
add_missing_records <- function(events_data) {
  dplyr::bind_rows(events_data, events_corrupts$missing_records)
}
