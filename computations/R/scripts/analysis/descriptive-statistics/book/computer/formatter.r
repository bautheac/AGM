suppressMessages({ modules::import(dplyr); modules::import(here); modules::import(tidyr) })

path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "globals", "paths.r"
)
paths <- modules::use(path_paths)


global_formatter <- modules::use(paths$path_global_formatter)
local_variables <- modules::use(paths$path_local_variables)


modules::export("format_summary_statistics")
format_summary_statistics <- function(data, variables_to_exclude){

  global_formatter$format_summary_statistics(data, variables_to_exclude, "_") |>
    dplyr::mutate(
      `reporting frequency` = factor(`reporting frequency`, levels = c("annually", "semi-annually", "all")),
      variable = factor(variable, levels = c(local_variables$variables_to_count, local_variables$variables_to_summarise))
    ) |>
    dplyr::relocate(variable, .after = "reporting frequency") |>
    dplyr::arrange(`reporting frequency`, variable, `reporting period`)
}
