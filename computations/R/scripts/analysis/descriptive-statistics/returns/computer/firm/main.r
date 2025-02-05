suppressMessages({ import(dplyr); import(here); import(tibble) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "globals", "paths.r"
)
paths <- modules::use(path_paths)

event_days_counter <- modules::use(paths$path_event_days_counter)
filter <- modules::use(paths$path_filter)


modules::export("compute_days_around_events")
compute_days_around_events <- function(returns_dataset) {
  
  filter$filter_irrelevant_records(returns_dataset) |>
    dplyr::group_by(id, year, `reporting frequency`, `reporting period`) |> 
    dplyr::arrange(date, .by_group = TRUE) |>
    dplyr::group_modify(
      ~event_days_counter$compute_days_around_events_statistics_for_id_year_reporting_period_combination(.x)
    ) |> dplyr::ungroup() |> 
    dplyr::select(id, `reporting frequency`, year, `reporting period`, dplyr::everything()) |>
    dplyr::arrange(id, year, date)
}