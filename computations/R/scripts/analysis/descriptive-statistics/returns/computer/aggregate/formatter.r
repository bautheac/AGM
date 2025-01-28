pacman::p_load(dplyr, here, modules)


path_global_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "formatter.r"
)
global_formatter <- modules::use(path_global_formatter)
path_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "variables.r"
)
variables <- modules::use(path_variables)
path_local_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "aggregate", "globals.r"
)
local_globals <- modules::use(path_local_globals)
path_firm_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "globals.r"
)
firm_globals <- modules::use(path_firm_globals)


modules::export("format_intermediate_summary_statistics")
format_intermediate_summary_statistics <- function(summary_statistics, variables_to_exclude, name_sep) {
  
  global_formatter$format_summary_statistics(summary_statistics, variables_to_exclude, name_sep)
}


modules::export("format_final_summary_statistics")
format_final_summary_statistics <- function(summary_statistics) {
  
  dplyr::select(
    summary_statistics, `reporting frequency`, `reporting period`, event, variable, dplyr::everything()
    ) |>
    dplyr::mutate(
      `reporting frequency` = factor(`reporting frequency`, levels = variables$reporting_frequency),
      event = factor(event, levels = firm_globals$events_of_interest),
      variable = factor(variable, levels = c(local_globals$count_variable, firm_globals$firm_days_variables))
    ) |>
    dplyr::arrange(`reporting frequency`, `reporting period`, event, variable)
}
  
  
  