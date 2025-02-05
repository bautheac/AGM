import(here)


path_variables_selecter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "returns", "transformer", 
  "variables_selecter.r"
)
variables_selecter <- modules::use(path_variables_selecter)

path_returns_computer <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "returns", "transformer", 
  "returns_computer.r"
)
returns_computer <- modules::use(path_returns_computer)

path_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "returns", "transformer", 
  "filter.r"
)
filter <- modules::use(path_filter)

path_wrangler <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "returns", "transformer", 
  "wrangler.r"
)
wrangler <- modules::use(path_wrangler)


modules::export("make_returns_dataset")
make_returns_dataset <- function(price_data){
  
  returns_computer$compute_returns(price_data) |>
    variables_selecter$select_relevant_variables() |>
    filter$filter_out_first_row_of_every_group("id") |>
    wrangler$round_returns()
}

