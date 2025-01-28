pacman::p_load(dplyr, modules)


path_event_counter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns",
  "computer", "aggregate", "event_counter.r"
)
event_counter <- modules::use(path_event_counter)
path_firm_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns",
  "computer", "firm", "globals.r"
)
firm_globals <- modules::use(path_firm_globals)
path_local_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns",
  "computer", "aggregate", "globals.r"
)
local_globals <- modules::use(path_local_globals)
path_computer_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals",
  "computer.r"
)
computer_globals <- modules::use(path_computer_globals)
path_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns",
  "computer", "aggregate", "formatter.r"
)
formatter <- modules::use(path_formatter)


compute_counting_statistics <- function(firm_statistics){
  
  event_counter$count_events(firm_statistics)
}

compute_summarising_statistics <- function(firm_statistics){
  
  all <- dplyr::group_by(firm_statistics, year, event) |>
    computer_globals$compute_stats_for_variables(
      firm_globals$firm_days_variables, local_globals$summarising_statistics
    ) |> dplyr::ungroup() |>
    dplyr::mutate(`reporting period` = NA, `reporting frequency` = "all")
    
  frequencies <- dplyr::group_by(firm_statistics, `reporting frequency`, year, `reporting period`, event) |>
    computer_globals$compute_stats_for_variables(
      firm_globals$firm_days_variables, local_globals$summarising_statistics
    ) |> 
    dplyr::ungroup()
  
  dplyr::bind_rows(all, frequencies)
}

modules::export("compute_statisics")
compute_statisics <- function(firm_statistics){
  
  count <- compute_counting_statistics(firm_statistics) |>
    formatter$format_intermediate_summary_statistics(
      c("year", "event", "reporting frequency", "reporting period"), ""
    ) |> dplyr::mutate(variable = local_globals$count_variable)
  
  summary <- compute_summarising_statistics(firm_statistics) |>
    formatter$format_intermediate_summary_statistics(
      c("year", "event", "reporting frequency", "reporting period"), "_"
    )
  
  dplyr::bind_rows(count, summary) |>
    formatter$format_final_summary_statistics()
}
