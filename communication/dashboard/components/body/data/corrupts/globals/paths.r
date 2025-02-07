suppressMessages({ import(here); import(slituR) })


path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)


path_body_global_paths <- here::here(
  path_main_directory, "components", "body", "globals", "paths.r"
)
body_global_paths <- modules::use(path_body_global_paths)


modules::export("path_pending_component")
path_pending_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "pending", "main.r"
)

modules::export("path_sorted_component")
path_sorted_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "sorted", "main.r"
)

modules::export("path_global_caption_component")
path_global_caption_component <- body_global_paths$path_global_caption_component


modules::export("path_local_variables")
path_local_variables <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "globals", "variables.r"
)


