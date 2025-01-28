pacman::p_load(dplyr, here, modules)

path_wrangler <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "dates", "reporting", "transformer", "wrangler.r"
)
wrangler <- modules::use(path_wrangler)
path_variables_selecter <- 
  here::here("computations", "R", "scripts", "extract-transform-load", "dates", "reporting", "transformer", "variables_selecter.r")
variables_selecter <- modules::use(path_variables_selecter)


export("transform_dates")
transform_dates <- function(raw_dates){
  
  wrangler$create_relevant_variables(raw_dates) |>
    variables_selecter$select_relevant_variables() |>
    dplyr::arrange(id, year, `reporting period`)
}


