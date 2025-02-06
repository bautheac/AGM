suppressMessages({
  import(here)
  import(slituR)
})


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(
  path_main_directory, "components", "body", "stats", "returns", "globals", "paths.r"
)
paths <- modules::use(path_paths)


global_extracter <- modules::use(paths$path_global_extracter)


modules::export("extract_stats_returns_firms")
extract_stats_returns_firms <- function() {
  global_extracter$extract_results_stats_returns(
    paths$filename_stats_returns_firms
  )
}

modules::export("extract_stats_returns_aggregate")
extract_stats_returns_aggregate <- function() {
  global_extracter$extract_results_stats_returns(
    paths$filename_stats_returns_aggregate
  )
}
