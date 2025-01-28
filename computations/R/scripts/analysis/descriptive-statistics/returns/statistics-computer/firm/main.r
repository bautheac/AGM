pacman::p_load(dplyr, modules, tibble)


path_event_days_counter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "statistics-computer", "firm", "event_days_counter.r"
)
event_days_counter <- modules::use(path_event_days_counter)
path_filter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "statistics-computer", "firm", "filter.r"
)
filter <- modules::use(path_filter)


modules::export("compute_days_around_events")
compute_days_around_events <- function(returns_dataset) {
  
  filter$filter_irrelevant_records(returns_dataset) |>
    dplyr::group_by(id, year, `reporting frequency`, `reporting period`) |> 
    dplyr::arrange(date, .by_group = TRUE) |>
    dplyr::group_modify(
      ~event_days_counter$compute_days_around_events_statistics_for_id_year_reporting_period_combination(.x)
    ) |> dplyr::ungroup() |> 
    dplyr::arrange(id, year, date)
}