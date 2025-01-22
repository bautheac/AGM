pacman::p_load(dplyr, modules, tibble)


path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "statistics-computer", "firm", "globals.r"
)
globals <- modules::use(path_globals)
path_event_days_counter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "statistics-computer", "firm", "event-days-counter.r"
)
event_days_counter <- modules::use(path_event_days_counter)


modules::export("compute_days_around_events")
compute_days_around_events <- function(returns_dataset) {
  
  dplyr::mutate(returns_dataset, year = lubridate::year(date)) |>
    dplyr::filter(event %in% c(NA, globals$events_of_interest)) |>
    dplyr::group_by(id, year) |> dplyr::arrange(date, .by_group = TRUE) |>
    dplyr::group_modify(
      ~event_days_counter$compute_days_around_events_statistics_for_id_year_combination(.x)
    ) |>
    dplyr::ungroup() |> dplyr::arrange(id, year, date)
}