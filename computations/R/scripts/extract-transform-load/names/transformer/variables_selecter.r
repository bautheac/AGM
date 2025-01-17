pacman::p_load(dplyr, modules)

modules::export("select_relevant_variables")
select_relevant_variables <- function(names_data){

  dplyr::select(names_data, id, `company name`)
}



