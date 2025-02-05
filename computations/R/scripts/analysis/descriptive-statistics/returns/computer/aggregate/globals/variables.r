suppressMessages(import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns",
  "computer", "aggregate", "globals", "paths.r"
)
paths <- modules::use(path_paths)

global_computer <- modules::use(paths$path_global_computer)


summarising_statistics_globals <- global_computer$summarising_statistics

modules::export("summarising_statistics")
summarising_statistics <- summarising_statistics_globals[!names(summarising_statistics_globals) %in% c("n")]

modules::export("count_variable")
count_variable <- "# observations"
