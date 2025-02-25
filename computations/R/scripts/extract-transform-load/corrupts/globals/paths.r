suppressMessages(modules::import(here))


modules::export("path_book_corrupts")
path_book_corrupts <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals",
  "corrupts.r"
)

modules::export("path_event_corrupts")
path_event_corrupts <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "globals",
  "corrupts.r"
)

modules::export("path_loader")
path_loader <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
)


path_global_paths <- here::here("computations", "R", "scripts", "globals", "paths.r")
global_paths <- modules::use(path_global_paths)


filenames <- c(
  corrupts_book_unformatted = "corrupts_book_unformatted.rds",
  corrupts_book_formatted = "corrupts_book_formatted.rds",
  corrupts_book_pending = "corrupts_book_pending.rds",
  corrupts_events_records = "corrupts_events_records.rds",
  corrupts_events_missings = "corrupts_events_missings.rds"
)

modules::export("file_paths")
file_paths <- lapply( filenames, function(filename) {
  list(
    main = here::here(global_paths$path_data_directory, filename),
    dashboard = here::here(global_paths$path_dashboard_directory_datasets, filename)
  )
}
) |> rlang::set_names(names(filenames))
