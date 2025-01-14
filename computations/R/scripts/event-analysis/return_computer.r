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

compute_returns_by_company <- function(data, group_var = "Company", result_var = "capgains"){
  
  results <- dplyr::group_by(data, group_var) %>%
    dplyr::mutate(!!result_var := compute_returns_from_high_low_quotes(high, low)) %>%
    dplyr::ungroup()
  
  return(results)
}

export("compute_returns")
compute_returns <- function(data){
  
  return(compute_returns_by_company_as(data, "Company", "capgains"))
}

