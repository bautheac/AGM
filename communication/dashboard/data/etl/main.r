pacman::p_load(here, modules, purrr, slituR)


path_globals <- here::here("communication", "dashboard", "data", "etl", "globals.r")
globals <- modules::use(path_globals)
path_extracter <- here::here("communication", "dashboard", "data", "etl", "extracter.r")
extracter <- modules::use(path_extracter)
path_paths <- here::here("communication", "dashboard", "globals", "paths.r")
paths <- modules::use(path_paths)
path_transformer <- here::here(
  "communication", "dashboard", "data", "etl", "transformer.r"
)
transformer <- modules::use(path_transformer)


company_names <- extracter$extract_company_names_dataset()
directory_paths <- c(paths$path_dataset_directory, paths$path_results_directory)


purrr::walk(directory_paths, function(directory){
  
  slituR::modify_files_in_place_recursive(
    directory, "rds", transformer$add_company_names, company_names = company_names
  )
})