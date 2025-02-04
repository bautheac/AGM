suppressMessages(import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler", "globals", "paths.r"
)
paths <- modules::use(path_paths)
  
variable_creator <- modules::use(paths$path_variable_creator)
data_filter <- modules::use(paths$path_local_filter)


modules::export("prepare_dataset_for_descriptive_stats_analysis")
prepare_dataset_for_descriptive_stats_analysis <- function(data){

  variable_creator$create_relevant_variables(data) |>
    data_filter$filter_out_irrelevant_data()
}
