import(dplyr, .quiet = TRUE)


modules::export(round_returns)
round_returns <- function(returns_datatset){
  
  dplyr::mutate(returns_datatset, return = round(return, 4L))
}