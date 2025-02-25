suppressMessages({
  modules::import(dplyr)
  modules::import(lubridate)
})


create_year_variable <- function(data) {
  dplyr::mutate(data, year = lubridate::year(`date of reporting period end`))
}

create_reporting_period_variable <- function(data) {
  dplyr::group_by(data, id, year) |>
    dplyr::mutate(`reporting period` = dplyr::row_number()) |>
    dplyr::ungroup()
}

modules::export("create_relevant_variables")
create_relevant_variables <- function(data) {
  create_year_variable(data) |> create_reporting_period_variable()
}
