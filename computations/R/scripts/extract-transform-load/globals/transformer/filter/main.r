suppressMessages({
  modules::import(dplyr)
  modules::import(rlang)
})


export("filter_out_values_not_matching")
filter_out_values_not_matching <- function(data, column, matches) {
  dplyr::filter(data, !!rlang::sym(column) %in% matches)
}

export("filter_out_records_with_nas_in_all_columns")
filter_out_records_with_nas_in_all_columns <- function(data, columns) {
  dplyr::filter(data, dplyr::if_all(columns, ~ !is.na(.x)))
}

export("filter_out_records_with_nas_in_any_columns")
filter_out_records_with_nas_in_any_columns <- function(data, columns) {
  dplyr::filter(data, dplyr::if_any(columns, ~ !is.na(.x)))
}

export("filter_out_first_row")
filter_out_first_row <- function(data) {
  dplyr::filter(data, dplyr::row_number() != 1L)
}

export("filter_out_empty_records")
filter_out_empty_records <- function(data) {
  dplyr::filter(data, !dplyr::if_all(dplyr::everything(), ~ is.na(.) | . == ""))
}

export("filter_out_records_with_nas_in_columns")
filter_out_records_with_nas_in_columns <- function(data, columns) {
  dplyr::filter(data, !dplyr::if_all(dplyr::all_of(columns), ~ is.na(.) | . == ""))
}

export("keep_distinct_variable_combinations")
keep_distinct_variable_combinations <- function(data, ...) {
  dplyr::distinct(data, ...)
}
