pacman::p_load(dplyr, lubridate, modules)


path_variable_creator <- 
  here::here("computations", "R", "scripts", "descriptive-statistics", "book", "data-wrangler", "variable_creator.r")
variable_creator <- modules::use(path_variable_creator)
path_data_filter <- 
  here::here("computations", "R", "scripts", "descriptive-statistics", "book", "filter.r")
data_filter <- modules::use(path_data_filter)


modules::export("prepare_dataset_for_descriptive_stats_analysis")
prepare_dataset_for_descriptive_stats_analysis <- function(data){

  variable_creator$create_relevant_variables(data) |>
    data_filter$filter_out_irrelevant_data()
}
