suppressMessages(modules::import(here))


modules::export("path_book_corrupts")
path_book_corrupts <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals",
  "corrupts.r"
)

modules::export("path_events_corrupts")
path_events_corrupts <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "globals",
  "corrupts.r"
)

modules::export("path_corrupts_cleaner")
path_corrupts_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer",
  "corrupts_cleaner.r"
)

modules::export("path_global_price_transformer")
path_global_price_transformer <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "transformer",
  "prices", "main.r"
)

modules::export("path_variables_cleaner")
path_variables_cleaner <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer",
  "variables_cleaner.r"
)

modules::export("path_variables_selecter")
path_variables_selecter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer",
  "variables_selecter.r"
)

modules::export("path_wrangler")
path_wrangler <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer",
  "wrangler.r"
)

modules::export("path_filter")
path_filter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "events", "transformer",
  "filter.r"
)
