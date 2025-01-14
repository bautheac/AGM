pacman::p_load(dplyr, modules)

modules::export("select_relevant_columns")
select_relevant_columns <- function(book_data){
  dplyr::select(book_data, -number)
}