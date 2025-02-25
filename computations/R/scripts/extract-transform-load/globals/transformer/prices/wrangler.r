suppressMessages(modules::import(here))

path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer",
  "prices", "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_wrangler <- modules::use(paths$path_global_wrangler)


modules::export("fill_forward_columns")
fill_forward_columns <- function(data, columns) {
  
  dplyr::group_by(data, id) |>
    global_wrangler$fill_forward_columns(columns) |>
    dplyr::ungroup()
}

