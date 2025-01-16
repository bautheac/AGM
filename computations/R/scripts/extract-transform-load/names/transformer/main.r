pacman::p_load(here, modules)


path_names_cleaner <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "raw_book_data_names_cleaner.r")
names_cleaner <- modules::use(path_names_cleaner)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "names", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)
path_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "filter.r")
filter <- modules::use(path_filter)


export("transform_names")
transform_names <- function(raw_names){
  
  names_cleaner$rename_variables(raw_names) |>
    variables_selecter$select_relevant_variables() |>
    filter$keep_distinct_variable_combinations(id, `company name`) |>
    dplyr::arrange(id, `company name`)
}