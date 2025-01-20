pacman::p_load(dplyr, modules, stats)


path_statistics_computer_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", "statistics-computer.r"
  )
statistics_computer_globals <- modules::use(path_statistics_computer_globals)
path_statistics_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", "statistics-computer", 
  "statistics-formatter.r"
  )
statistics_formatter <- modules::use(path_statistics_formatter)
path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", "statistics-computer", 
  "globals.r"
  )
globals <- modules::use(path_globals)


compute_stats_by_reporting_period <- 
  function(data, variables_to_count, variables_to_summarise, counting_statistics, summarising_statistics){

  all <- dplyr::mutate(data, `reporting frequency` = "all")
  whole <- dplyr::bind_rows(all, data)
  
  count <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    statistics_computer_globals$compute_stats_for_variables(variables_to_count, counting_statistics) |> 
    dplyr::ungroup()
  summary <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    statistics_computer_globals$compute_stats_for_variables(variables_to_summarise, summarising_statistics) |> 
    dplyr::ungroup()
  
  dplyr::left_join(count, summary, by = c("reporting frequency", "year", "reporting period"))
}
 
modules::export("compute_descriptive_statistics")
compute_descriptive_statistics <- function(data){
  
    compute_stats_by_reporting_period(
      data, 
      globals$variables_to_count, globals$variables_to_summarise, 
      globals$counting_statistics, globals$summarising_statistics
    ) |> 
    statistics_formatter$format_summary_statistics(c("reporting frequency", "year", "reporting period"))
}
