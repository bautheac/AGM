suppressMessages({ modules::import(dplyr); modules::import(here) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "aggregate", "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_formatter <- modules::use(paths$path_global_formatter)
global_variables <- modules::use(paths$path_global_variables)
local_variables <- modules::use(paths$path_local_variables)
firm_local_variables <- modules::use(paths$path_firm_local_variables)


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
      `reporting frequency` = factor(`reporting frequency`, levels = global_variables$reporting_frequency),
      event = factor(event, levels = firm_local_variables$events_of_interest),
      variable = factor(variable, levels = c(local_variables$count_variable, firm_local_variables$firm_days_variables))
    ) |>
    dplyr::arrange(`reporting frequency`, `reporting period`, event, variable)
}
  
  
  
