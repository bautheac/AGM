pacman::p_load(here, purrr, slituR)

path_paths <- here::here(
  "communication", "dashboard", "data", "etl", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_extracter)
transformer <- modules::use(paths$path_transformer)


company_names <- extracter$extract_company_names_dataset()
directory_paths <- c(paths$path_dataset_directory, paths$path_results_directory)


purrr::walk(directory_paths, function(directory){
  
  slituR::modify_files_in_place_recursive(
    directory, "rds", transformer$add_company_names, company_names = company_names
  )
})


rm(list = ls())