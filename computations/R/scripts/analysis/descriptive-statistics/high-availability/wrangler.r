suppressMessages({ import(dplyr); import(here)})

path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_global_extracter)


modules::export("retrieve_names")
retrieve_names <- function(ids){
  
  extracter$extract_clean_names_data() |> dplyr::filter(id %in% ids) |>
    dplyr::arrange(id)
}