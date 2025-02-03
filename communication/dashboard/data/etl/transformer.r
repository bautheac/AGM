suppressMessages(import(dplyr))


modules::export("add_company_names")
add_company_names <- function(data, company_names){
  
  if ("id" %in% colnames(data) && !"company name" %in% colnames(data)) {
    
    data <- dplyr::left_join(data, company_names, by = "id") |>
      dplyr::relocate(`company name`, .before = dplyr::everything())
  }
  
  return(data)
}