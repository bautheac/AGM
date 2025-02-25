suppressMessages(modules::import(here))


modules::export("path_wrangler")
path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "wrangler", "main.r"
)

modules::export("path_stats_computer_firm")
path_stats_computer_firm <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "firm", "main.r"
)

modules::export("path_stats_computer_aggregate")
path_stats_computer_aggregate <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "computer", "aggregate", "main.r"
)
