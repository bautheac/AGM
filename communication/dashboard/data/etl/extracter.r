suppressMessages({
  import(here)
  import(readr)
})

path_main_directory <- slituR::make_shiny_main_directory_path(
  local = "communication/dashboard"
)

path_paths <- here::here(path_main_directory, "globals", "paths.r")
paths <- modules::use(path_paths)


modules::export("extract_company_names_dataset")
extract_company_names_dataset <- function() {
  readr::read_rds(here::here(paths$path_dataset_directory, paths$filename_names_dataset))
}
