pacman::p_load(dplyr, here, modules)


path_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
  )
extracter <- modules::use(path_extracter)


modules::export("retrieve_names")
retrieve_names <- function(ids){
  
  extracter$extract_clean_names_data() |> dplyr::filter(id %in% ids) |>
    dplyr::arrange(id)
}