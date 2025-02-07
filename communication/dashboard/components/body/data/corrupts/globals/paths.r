suppressMessages(import(here))


path_main_directory <- 
  slituR::make_shiny_main_directory_path(local = "communication/dashboard")


modules::export("path_pending_component")
path_pending_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "pending", "main.r"
)

modules::export("path_sorted_component")
path_sorted_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "main.r"
)
