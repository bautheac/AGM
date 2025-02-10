suppressMessages({
  import("here")
  import("shiny")
  import("shinydashboard")
  import("slituR")
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

modules::export("path_data_clean_component")
path_data_clean_component <- here::here(
  path_main_directory, "components", "body", "data", "clean", "main.r"
)

modules::export("path_data_corrupts_component")
path_data_corrupts_component <- here::here(
  path_main_directory, "components", "body", "data", "corrupts", "main.r"
)

modules::export("path_stats_book_component")
path_stats_book_component <- here::here(
  path_main_directory, "components", "body", "stats", "book", "main.r"
)

modules::export("path_stats_returns_component")
path_stats_returns_component <- here::here(
  path_main_directory, "components", "body", "stats", "returns", "main.r"
)

modules::export("path_stats_availables_component")
path_stats_availables_component <- here::here(
  path_main_directory, "components", "body", "stats", "high-availability", "main.r"
)

modules::export("path_global_table_component")
path_global_table_component <- here::here(
  path_main_directory, "components", "body", "globals", "table", "main.r"
)

modules::export("path_global_caption_component")
path_global_caption_component <- here::here(
  path_main_directory, "components", "body", "globals", "caption", "main.r"
)