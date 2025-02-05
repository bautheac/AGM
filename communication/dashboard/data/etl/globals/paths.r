suppressMessages(import(here))


modules::export("path_transformer")
path_transformer <- here::here(
  "communication", "dashboard", "data", "etl", "transformer.r"
)

modules::export("path_extracter")
path_extracter <- here::here("communication", "dashboard", "data", "etl", "extracter.r")


path_global_paths <- here::here("communication", "dashboard", "globals", "paths.r")
global_paths <- modules::use(path_global_paths)

modules::export("path_dataset_directory")
path_dataset_directory <- global_paths$path_dataset_directory

modules::export("path_results_directory")
path_results_directory <- global_paths$path_results_directory

