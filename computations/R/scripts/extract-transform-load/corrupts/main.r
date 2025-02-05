pacman::p_load(here)


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "corrupts", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

book_corrupts <- modules::use(paths$path_book_corrupts)
event_corrupts <- modules::use(paths$path_event_corrupts)
loader <- modules::use(paths$path_loader)


loader$load_objects(
  list(
    book_corrupts$unformatted_date_typos, book_corrupts$formatted_date_typos,
    book_corrupts$pending,
    event_corrupts$corrupt_records, event_corrupts$missing_records
  ), 
  paths$file_paths
)


rm(list = ls())