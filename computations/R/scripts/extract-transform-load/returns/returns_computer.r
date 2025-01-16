pacman::p_load(modules, readxl)


compute_mid_from_high_low_quotes <- function(high, low){
  
  return((high + low) / 2L)
}

compute_returns <- function(prices){
  
  return(prices / lag(prices) - 1L)
}

compute_returns_from_high_low_quotes <- function(high, low){
  
  mid <- compute_mid_from_high_low_quotes(high, low)
  
  return(compute_returns(mid))
}

compute_returns_by_group <- function(price_data, group_var, result_var){
  browser()
  dplyr::group_by(price_data, dplyr::across(group_var)) |>
    dplyr::mutate(!!result_var := compute_returns_from_high_low_quotes(high, low)) |>
    dplyr::ungroup()
}

compute_returns_by_company <- function(price_data){

  compute_returns_by_group(price_data, group_var = "id", result_var = "return")
}

export("compute_returns")
compute_returns <- function(price_data){
  
  return(compute_returns_by_company(price_data))
}