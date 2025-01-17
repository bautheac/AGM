pacman::p_load(dplyr, modules)

modules::export("clean_relevant_variables")
clean_relevant_variables <- function(dates_data){
  
  dplyr::mutate(dates_data, trading = ifelse(trading == "yes", TRUE, FALSE))
}