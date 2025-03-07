suppressMessages({
  modules::import(dplyr)
  modules::import(here)
  modules::import(rlang)
})


path_global_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer",
  "filter", "main.r"
)
global_filter <- modules::use(path_global_filter)

filter_out_first_row_of_every_group <- function(data, group_vars) {
  group_vars_syms <- rlang::syms(group_vars)

  dplyr::group_by(data, !!!group_vars_syms) |>
    global_filter$filter_out_first_row()
}
