suppressMessages({
  import(here)
  import(slituR)
})


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "globals", 
  "paths.r"
)
paths <- modules::use(path_paths)


global_extracter <- modules::use(paths$path_global_extracter)


modules::export("extract_stats_availables_names")
extract_stats_availables_names <- function() {
  global_extracter$extract_results_stats_availables(
    paths$filename_intersection_names
  )
}

modules::export("extract_stats_availables_book")
extract_stats_availables_book <- function() {
  global_extracter$extract_results_stats_availables(
    paths$filename_intersection_stats_book
  )
}

modules::export("extract_stats_availables_returns_firms")
extract_stats_availables_returns_firms <- function() {
  global_extracter$extract_results_stats_availables(
    paths$filename_intersection_stats_returns_firms
  )
}

modules::export("extract_stats_availables_returns_aggregate")
extract_stats_availables_returns_aggregate <- function() {
  global_extracter$extract_results_stats_availables(
    paths$filename_intersection_stats_returns_aggregate
  )
}