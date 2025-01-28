pacman::p_load(dplyr, modules, stats)


path_computer_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "computer.r"
  )
computer_globals <- modules::use(path_computer_globals)
path_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "formatter.r"
  )
formatter <- modules::use(path_formatter)
path_local_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "globals.r"
  )
local_globals <- modules::use(path_local_globals)


compute_stats_by_reporting_period <- 
  function(data, variables_to_count, variables_to_summarise, counting_statistics, summarising_statistics){

  all <- dplyr::mutate(data, `reporting frequency` = "all")
  whole <- dplyr::bind_rows(all, data)
  
  count <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    computer_globals$compute_stats_for_variables(variables_to_count, counting_statistics) |> 
    dplyr::ungroup()
  summary <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    computer_globals$compute_stats_for_variables(variables_to_summarise, summarising_statistics) |> 
    dplyr::ungroup()
  
  dplyr::left_join(count, summary, by = c("reporting frequency", "year", "reporting period"))
}
 
modules::export("compute_descriptive_statistics")
compute_descriptive_statistics <- function(data){
  
    compute_stats_by_reporting_period(
      data, 
      local_globals$variables_to_count, local_globals$variables_to_summarise, 
      local_globals$counting_statistics, computer_globals$summarising_statistics
    ) |> 
    formatter$format_summary_statistics(c("reporting frequency", "year", "reporting period"))
}
