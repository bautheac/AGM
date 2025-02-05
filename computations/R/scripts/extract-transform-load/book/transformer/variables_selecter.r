suppressMessages(import(dplyr))


modules::export("select_relevant_variables")
select_relevant_variables <- function(book_data){
  dplyr::select(book_data, -c(`company name`, number))
}