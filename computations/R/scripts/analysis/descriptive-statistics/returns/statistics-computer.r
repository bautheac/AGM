pacman::p_load(dplyr, modules, tibble)

path_to_globals <- 
  here::here("computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", "globals.r")
globals <- modules::use(path_to_globals)


equals_zero <- function(x) { 
  
  if(is.na(x)) { return(TRUE) }
  return(x == 0) 
}

break_condition_met <- function(break_fun, return){
  do.call(break_fun, list(return))
}

compute_uninterrupted_days <- function(
    returns, break_fun = c("is.na", "equals_zero"), break_n = 5L, start_index, direction = c("before", "after")
) {
  
  break_fun <- match.arg(break_fun)
  direction <- match.arg(direction)
  n <- length(returns)
  step <- dplyr::case_when(direction == "before" ~ -1L, direction == "after" ~ 1L)
  
  days_count <- 0L
  consecutive_breaks <- 0L
  i <- start_index + step
  
  while (i >= 1L && i <= n) {
    
    if (break_condition_met(break_fun, returns[i])) {
      consecutive_breaks <- consecutive_breaks + 1L
    } else {
      consecutive_breaks <- 0L
    }
    
    if (consecutive_breaks == break_n) break
    
    days_count <- days_count + 1L
    i <- i + step
  }
  return(days_count)
}



compute_event_indices <- function(event_series){
  which(!is.na(event_series))
}

no_event_exists <- function(event_indices){ length(event_indices) == 0L }

make_tibble_empty <- function(var_names){
  tibble::tibble(!!!setNames(vector("list", length(var_names)), var_names))
}

make_tibble_results <- function(content){
  tibble::tibble(!!!content)
}

compute_days_around_event_statistics <- function(returns, event_index){
  
  lapply(globals$firm_days_statistics, function(spec) {
    
    fun <- match.fun(spec$fun)
    params <- spec$params

    do.call(fun, c(list(returns = returns, start_index = event_index), params))
  })
}


compute_days_around_events_statistics_for_id_year_combination <- function(data){
  
  event_rows <-compute_event_indices(data$event)
  
  if (no_event_exists(event_rows)) {
    return(make_tibble_empty(globals$firm_days_statistics_variables))
  }
  
  results <- lapply(event_rows, function(i) {
    
    make_tibble_results(
      c(
        event = as.character(data$date[i]), 
        date = data$event[i],
        compute_days_around_event_statistics(data$return, i)
      )
    )
  })
  
  dplyr::bind_rows(results)
}

compute_days_around_events <- function(df) {
  
  dplyr::group_by(df, id, year) |>
    dplyr::arrange(date, .by_group = TRUE) |>
    dplyr::group_modify(~compute_days_around_events_statistics_for_id_year_combination(.x)) |>
    dplyr::ungroup()
}


test <- dplyr::mutate(dataset, year = lubridate::year(date)) |>
  dplyr::filter(event %in% c(NA, globals$events_of_interest)) |>
  compute_days_around_events() |>
  dplyr::arrange(id, year, date)
