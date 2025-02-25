suppressMessages(modules::import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer",
  "prices", "variables-cleaner", "globals", "paths.r"
)
paths <- modules::use(path_paths)

dates_cleaner <- modules::use(paths$path_dates_cleaner)
price_cleaner <- modules::use(paths$path_price_cleaner)


modules::export("clean_date_price_variables")
clean_date_price_variables <- function(price_data) {
  dates_cleaner$clean_date_variables(price_data) |>
    price_cleaner$clean_price_variables()
}
