suppressMessages({ modules::import(dplyr); modules::import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns",
  "computer", "aggregate", "globals", "paths.r"
)
paths <- modules::use(path_paths)

local_variables <- modules::use(paths$path_local_variables)
event_counter <- modules::use(paths$path_event_counter)
firm_global_variables <- modules::use(paths$path_firm_local_variables)
global_computer <- modules::use(paths$path_global_computer)
formatter <- modules::use(paths$path_local_formatter)


compute_counting_statistics <- function(firm_statistics){
  
  event_counter$count_events(firm_statistics)
}

compute_summarising_statistics <- function(firm_statistics){
  
  all <- dplyr::group_by(firm_statistics, year, event) |>
    global_computer$compute_stats_for_variables(
      firm_global_variables$firm_days_variables, local_variables$summarising_statistics
    ) |> dplyr::ungroup() |>
    dplyr::mutate(`reporting period` = NA, `reporting frequency` = "all")
    
  frequencies <- dplyr::group_by(firm_statistics, `reporting frequency`, year, `reporting period`, event) |>
    global_computer$compute_stats_for_variables(
      firm_global_variables$firm_days_variables, local_variables$summarising_statistics
    ) |> 
    dplyr::ungroup()
  
  dplyr::bind_rows(all, frequencies)
}

modules::export("compute_statisics")
compute_statisics <- function(firm_statistics){
  
  count <- compute_counting_statistics(firm_statistics) |>
    formatter$format_intermediate_summary_statistics(
      c("year", "event", "reporting frequency", "reporting period"), ""
    ) |> dplyr::mutate(variable = local_variables$count_variable)
  
  summary <- compute_summarising_statistics(firm_statistics) |>
    formatter$format_intermediate_summary_statistics(
      c("year", "event", "reporting frequency", "reporting period"), "_"
    )
  
  dplyr::bind_rows(count, summary) |>
    formatter$format_final_summary_statistics()
}
