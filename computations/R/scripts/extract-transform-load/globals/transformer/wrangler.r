suppressMessages({
  modules::import(dplyr)
  modules::import(purrr)
  modules::import(tidyr)
})


modules::export("extract_uniques")
extract_uniques <- function(data, column) {
  dplyr::select(data, !!column) |>
    unique() |>
    purrr::flatten_chr()
}

modules::export("fill_forward_columns")
fill_forward_columns <- function(data, columns) {
  tidyr::fill(data, {{ columns }}, .direction = "down")
}
