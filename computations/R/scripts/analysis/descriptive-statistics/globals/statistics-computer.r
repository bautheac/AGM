pacman::p_load(dplyr, modules)


modules::export("compute_stats_for_variables")
compute_stats_for_variables <- function(data, variables, statistics){
  
  dplyr::summarise(
    data,
    dplyr::across(dplyr::all_of(variables), statistics, .names = "{.col}_{.fn}")
  )
}