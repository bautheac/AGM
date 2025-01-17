pacman::p_load(dplyr, modules)

modules::export("clean_relevant_variables")
clean_relevant_variables <- function(events_data){
  
  dplyr::filter(events_data, !(is.na(event) | event == ""))
}