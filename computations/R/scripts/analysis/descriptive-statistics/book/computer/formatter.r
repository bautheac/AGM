pacman::p_load(dplyr, here, modules, tidyr)


path_global_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "formatter.r"
)
global_formatter <- modules::use(path_global_formatter)
path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "globals.r"
)
globals <- modules::use(path_globals)


modules::export("format_summary_statistics")
format_summary_statistics <- function(data, variables_to_exclude){

  global_formatter$format_summary_statistics(data, variables_to_exclude, "_") |>
    dplyr::mutate(
      `reporting frequency` = factor(`reporting frequency`, levels = c("annually", "semi-annually", "all")),
      variable = factor(variable, levels = c(globals$variables_to_count, globals$variables_to_summarise))
    ) |>
    dplyr::relocate(variable, .after = "reporting frequency") |>
    dplyr::arrange(`reporting frequency`, variable, `reporting period`)
}