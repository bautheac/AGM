suppressMessages({ modules::import(dplyr); modules::import(tidyr) })


modules::export("format_summary_statistics")
format_summary_statistics <- function(data, variables_to_exclude, name_sep){
  
  dplyr::mutate(data, dplyr::across(-variables_to_exclude, ~ as.double(.))) |>
    tidyr::pivot_longer(
      cols = -variables_to_exclude, names_to = c("variable", "statistic"), names_sep = name_sep, values_to = "value"
    ) |> 
    dplyr::mutate(
      value = round(value, 0L), value = ifelse(is.finite(value), value, NA_integer_), value = as.integer(value),
    ) |>
    tidyr::pivot_wider(names_from = year, values_from = value)
}
