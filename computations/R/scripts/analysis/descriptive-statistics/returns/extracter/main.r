pacman::p_load(dplyr, here, modules,rlang)

path_global_data_extracter <- here::here("computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r")
global_data_extracter <- modules::use(path_global_data_extracter)


extract_subdatasets <- function() {
  
  dates <- global_data_extracter$extract_clean_dates_tradings_data()
  events <- global_data_extracter$extract_clean_events_data()
  returns <- global_data_extracter$extract_clean_returns_data()
  
  list(dates = dates, events = events, returns = returns)
}

collect_disctinct_variable_in_datasets <- function(variable, datasets) {
  
  variable_sym <- rlang::sym(variable)
  
  purrr::map(datasets, ~ dplyr::distinct(.x, !!variable_sym)) |> 
    purrr::reduce(dplyr::full_join, by = variable)
}

make_date_id_combinations <- function(dates, ids) {
  
  dplyr::cross_join(dates, ids)
}

modules::export("make_dataset")
make_dataset <- function() {

  subdatasets <- extract_subdatasets()
  
  distinct_ids <- collect_disctinct_variable_in_datasets(
    "id", list(subdatasets$events, subdatasets$returns)
    )

  date_id_combinations <- make_date_id_combinations(subdatasets$dates, distinct_ids)

  
  dplyr::left_join(date_id_combinations, subdatasets$events, by = c("id", "date")) |>
    dplyr::left_join(subdatasets$returns, by = c("id", "date")) |>
    dplyr::arrange(id, date)
}