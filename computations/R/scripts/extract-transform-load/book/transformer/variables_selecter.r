pacman::p_load(dplyr, modules)

modules::export("select_relevant_variables")
select_relevant_variables <- function(book_data){
  dplyr::select(book_data, -number)
}