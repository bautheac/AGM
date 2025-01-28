pacman::p_load(dplyr, here, modules, tidyr)

path_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", "statistics-computer", 
  "globals.r"
)
globals <- modules::use(path_globals)


modules::export("format_summary_statistics")
format_summary_statistics <- function(data, variables_to_exclude){
  
  dplyr::mutate(data, dplyr::across(-variables_to_exclude, ~ as.double(.))) |>
    tidyr::pivot_longer(
      cols = -variables_to_exclude, names_to = c("variable", "statistic"), names_sep = "_", values_to = "value"
    ) |> 
    dplyr::mutate(
      value = round(value, 0L), value = ifelse(is.finite(value), value, NA_integer_), value = as.integer(value),
      `reporting frequency` = factor(`reporting frequency`, levels = c("annually", "semi-annually", "all")),
      variable = factor(variable, levels = c(globals$variables_to_count, globals$variables_to_summarise))
    ) |>
    tidyr::pivot_wider(names_from = year, values_from = value) |>
    dplyr::relocate(variable, .after = "reporting frequency") |>
    dplyr::arrange(`reporting frequency`, variable, `reporting period`)
}