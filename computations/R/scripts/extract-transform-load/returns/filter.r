pacman::p_load(dplyr, modules)

filter_out_no_price_dates <- function(price_data){
  dplyr::filter(
    price_data,
    dplyr::across(dplyr::matches("^data ?available$"), ~ . == "yes") 
  )
}

modules::export("filter_out_irrelevant_data")
filter_out_irrelevant_data <- function(price_data) {
  filter_out_no_price_dates(price_data)
}