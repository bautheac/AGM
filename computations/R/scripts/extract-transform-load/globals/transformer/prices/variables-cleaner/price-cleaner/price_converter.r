suppressMessages(modules::import(stringr))


modules::export("transform_prices_to_decimal")
transform_prices_to_decimal <- function(prices){
  
  integer <- as.numeric(stringr::str_extract(prices, "^\\d+"))
  numerator <- as.numeric(stringr::str_extract(prices, "(?<=-)(\\d+)(?=/)"))
  denominator <- as.numeric(stringr::str_extract(prices, "(?<=/)(\\d+)"))
  
  fraction <- numerator / denominator
  fraction[is.na(fraction)] <- 0L
  
  return(integer + fraction)
}
