suppressMessages(modules::import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "names", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

data_extracter <- modules::use(paths$path_data_extracter)
names_data_transformer <- modules::use(paths$path_names_data_transformer)
data_loader <- modules::use(paths$path_data_loader)


raw_names <- data_extracter$extract_raw_book_data()
clean_names <- names_data_transformer$transform_names(raw_names)


data_loader$load_objects(
  list(clean_names, clean_names),
  list(paths$filepath_clean_names_data_main, paths$filepath_clean_names_data_dashboard)
)


rm(list = ls())
