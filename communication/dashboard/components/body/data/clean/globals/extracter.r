suppressMessages({
  import(here)
  import(slituR)
})


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "data", "clean", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)


global_extracter <- modules::use(paths$path_global_extracter)


modules::export("extract_book_dataset")
extract_book_dataset <- function() {
  global_extracter$extract_dataset(paths$filename_book_dataset)
}

modules::export("extract_prices_dataset")
extract_prices_dataset <- function() {
  global_extracter$extract_dataset(paths$filename_prices_dataset)
}

modules::export("extract_returns_dataset")
extract_returns_dataset <- function() {
  global_extracter$extract_dataset(paths$filename_returns_dataset)
}

modules::export("extract_events_dataset")
extract_events_dataset <- function() {
  global_extracter$extract_dataset(paths$filename_events_dataset)
}
