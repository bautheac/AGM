pacman::p_load(here, modules)


path_events_cleaner <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "transformer", "raw_price_data_names_cleaner.r")
events_cleaner <- modules::use(path_events_cleaner)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "events", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)
path_filter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "globals", "filter", "main.r")
filter <- modules::use(path_filter)


export("transform_events")
transform_events <- function(raw_events){
  
  events_cleaner$rename_variables(raw_events) |>
    variables_selecter$select_relevant_variables() |>
    filter$keep_distinct_variable_combinations(id, date, event) |>
    dplyr::arrange(id, date, event)
}