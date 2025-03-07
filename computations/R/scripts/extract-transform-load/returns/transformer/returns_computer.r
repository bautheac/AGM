suppressMessages({
  modules::import(dplyr)
  modules::import(rlang)
})


compute_mid_from_high_low_quotes <- function(high, low) {
  return((high + low) / 2L)
}

calculate_returns <- function(prices) {
  return(prices / dplyr::lag(prices) - 1L)
}

compute_returns_from_high_low_quotes <- function(high, low) {
  mid <- compute_mid_from_high_low_quotes(high, low)
  returns <- calculate_returns(mid)

  return(returns)
}

compute_returns_by_group <- function(price_data, group_vars, result_var) {
  group_vars_syms <- rlang::syms(group_vars)

  dplyr::group_by(price_data, !!!group_vars_syms) |>
    dplyr::mutate(!!result_var := compute_returns_from_high_low_quotes(high, low)) |>
    dplyr::ungroup()
}

compute_returns_by_company <- function(price_data) {
  compute_returns_by_group(price_data, group_var = c("id"), result_var = "return")
}

export("compute_returns")
compute_returns <- function(price_data) {
  return(compute_returns_by_company(price_data))
}
