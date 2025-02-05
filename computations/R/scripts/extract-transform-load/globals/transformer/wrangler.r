suppressMessages({ import(dplyr); import(purrr) })


modules::export("extract_uniques")
extract_uniques <- function(data, column){
  
   dplyr::select(data, !!column) |> unique() |> purrr::flatten_chr()
}