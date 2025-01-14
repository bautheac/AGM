pacman::p_load(dplyr,purrr)

export("extract_uniques")
extract_uniques <- function(data, column){
   dplyr::select(data, !!column) |> unique() |> purrr::flatten_chr()
}