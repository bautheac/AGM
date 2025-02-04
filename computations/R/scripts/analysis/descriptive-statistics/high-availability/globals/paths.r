suppressMessages(import(here))


modules::export("path_firms_selecter")
path_firms_selecter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "firms_selecter.r"
)

modules::export("path_book_stats_computer")
path_book_stats_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "book", "computer", "main.r"
)

modules::export("path_stats_book_paths")
path_stats_book_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "globals", "paths.r"
)

modules::export("path_returns_stats_computer")
path_returns_stats_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "returns", "computer", "main.r"
)

modules::export("path_stats_returns_paths")
path_stats_returns_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "globals", "paths.r"
)

modules::export("path_wrangler")
path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "wrangler.r"
)

modules::export("path_returns_firm_local_variables")
path_returns_firm_local_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "returns", "computer", "firm", "globals", "variables.r"
)

modules::export("path_local_variables")
path_local_variables <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "globals", "variables.r"
)

modules::export("path_local_extracter")
path_local_extracter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "extracter.r"
)

path_descriptive_stats_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "paths.r"
)
descriptive_stats_paths <- modules::use(path_descriptive_stats_paths)


modules::export("path_loader")
path_loader <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "loader.r"
)
modules::export("path_etl_book_local_variables")
path_etl_book_local_variables <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals", 
  "variables.r"
)

modules::export("path_global_extracter")
path_global_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)


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
