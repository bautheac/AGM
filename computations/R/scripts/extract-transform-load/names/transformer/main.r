suppressMessages({
  modules::import(dplyr)
  modules::import(here)
})


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "names", "transformer",
  "globals", "paths.r"
)
paths <- modules::use(path_paths)

names_cleaner <- modules::use(paths$path_names_cleaner)
variables_selecter <- modules::use(paths$path_variables_selecter)
filter <- modules::use(paths$path_filter)


export("transform_names")
transform_names <- function(raw_names) {
  names_cleaner$rename_variables(raw_names) |>
    variables_selecter$select_relevant_variables() |>
    filter$keep_distinct_variable_combinations(id, `company name`) |>
    dplyr::arrange(id, `company name`)
}
