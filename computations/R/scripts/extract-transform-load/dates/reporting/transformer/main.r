suppressMessages({
  modules::import(dplyr)
  modules::import(here)
})


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "dates", "reporting",
  "transformer", "globals", "paths.r"
)
paths <- modules::use(path_paths)

wrangler <- modules::use(paths$path_wrangler)
variables_selecter <- modules::use(paths$path_variables_selecter)


export("transform_dates")
transform_dates <- function(raw_dates) {
  wrangler$create_relevant_variables(raw_dates) |>
    variables_selecter$select_relevant_variables() |>
    dplyr::arrange(id, year, `reporting period`)
}
