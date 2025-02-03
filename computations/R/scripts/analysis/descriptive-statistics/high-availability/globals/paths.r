pacman::p_load(here, modules)

path_descriptive_stats_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "paths.r"
)
descriptive_stats_paths <- modules::use(path_descriptive_stats_paths)


directory <- "high-availability"
filenames <- c(
  book_firms_names = "book_firms_names.rds",
  book_firms_stats = "book_firms_stats.rds",
  return_firms_names = "return_firms_names.rds",
  return_firms_stats_firms = "return_firms_stats_firms.rds",
  return_firms_stats_aggregate = "return_firms_stats_aggregate.rds",
  intersection_firms_names = "intersection_firms_names.rds",
  intersection_firms_book_stats = "intersection_firms_book_stats.rds",
  intersection_firms_return_stats_firms = "intersection_firms_return_stats_firms.rds",
  intersection_firms_return_stats_aggregate = "intersection_firms_return_stats_aggregate.rds"
)

modules::export("paths")
paths <- lapply( filenames, function(filename) {
    list(
      main = here::here(
        descriptive_stats_paths$path_descriptive_stats_results_directory_main, directory, 
        filename
      ),
      dashboard = here::here(
        descriptive_stats_paths$path_descriptive_stats_results_directory_dashboard, directory, 
        filename
      )
    )
  }
) |> rlang::set_names(names(filenames))