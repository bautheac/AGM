suppressMessages(import(here))

          
path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")

modules::export("path_data_clean")
path_data_clean <- here::here(
  path_main_directory, "components", "body", "data", "clean", "main.r"
)

modules::export("path_data_corrupts")
path_data_corrupts <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "main.r"
)