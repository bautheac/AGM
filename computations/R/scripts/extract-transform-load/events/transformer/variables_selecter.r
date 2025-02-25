suppressMessages(modules::import(dplyr))


modules::export("select_relevant_variables")
select_relevant_variables <- function(names_data){ dplyr::select(names_data, id, date, event) }



