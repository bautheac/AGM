suppressMessages(modules::import(dplyr))


modules::export("select_relevant_variables")
select_relevant_variables <- function(price_data){ dplyr::select(price_data, id, date, return) }
