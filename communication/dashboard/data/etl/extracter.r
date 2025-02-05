suppressMessages(import(here))
suppressMessages(import(readr))


path_paths <- here::here("communication", "dashboard", "globals", "paths.r")
paths <- modules::use(path_paths)


modules::export("extract_company_names_dataset")
extract_company_names_dataset <- function(){
  
  readr::read_rds(here::here(paths$path_dataset_directory, paths$filename_names_dataset))
}