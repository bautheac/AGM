suppressMessages(modules::import(here))


modules::export("path_data_directory")
path_data_directory <- here::here("data")

modules::export("path_results_directory")
path_results_directory <- here::here("computations", "R", "results")

modules::export("path_dashboard_directory")
path_dashboard_directory <- here::here("communication", "dashboard", "data")

modules::export("path_dashboard_directory_datasets")
path_dashboard_directory_datasets <- here::here(path_dashboard_directory, "datasets")

modules::export("path_dashboard_directory_results")
path_dashboard_directory_results <- here::here(path_dashboard_directory, "results")
