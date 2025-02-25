suppressMessages(modules::import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "globals",
  "paths.r"
)
paths <- modules::use(path_paths)

data_extracter <- modules::use(paths$path_data_extracter)
events_data_transformer <- modules::use(paths$path_events_data_transformer)
data_loader <- modules::use(paths$path_data_loader)


raw_events <- data_extracter$extract_raw_price_data()
clean_events <- events_data_transformer$transform_events(raw_events)


data_loader$load_objects(
  list(clean_events, clean_events),
  list(paths$filepath_clean_events_data_main, paths$filepath_clean_events_data_dashboard)
)


rm(list = ls())
