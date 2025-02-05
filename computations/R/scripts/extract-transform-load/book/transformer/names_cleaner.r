suppressMessages({ import(dplyr); import(here) })


path_global_variables <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals", 
  "variables.r"
)
global_variables <- modules::use(path_global_variables)


raw_to_clean_names_map <- c(
  global_variables$raw_to_clean_book_other_names_map,
  global_variables$raw_to_clean_book_variable_names_map
)


modules::export("rename_columns")
rename_columns <- function(book_data) {
  dplyr::rename(book_data, !!!raw_to_clean_names_map)
}