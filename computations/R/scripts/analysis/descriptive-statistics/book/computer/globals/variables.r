suppressMessages(modules::import(here))


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "globals", "paths.r"
)
paths <- modules::use(path_paths)

wrangler_local_variables <- modules::use(paths$path_wrangler_local_variables)


modules::export("variables_to_count")
variables_to_count <- c(
  "dates of closed books period available", "AGM date within closed books period"
)

modules::export("variables_to_summarise")
variables_to_summarise <- c(
  wrangler_local_variables$distance_to_AGM_computed_variables, 
  "length of closed books period (# days)", "book value equity", "total assets", 
  "non-current assets", "current assets", "total liabilities", 
  "non-current liabilities", "current liabilities", "total debt", "bank debt", 
  "other debt", "cash", "intangibles/goodwill", "net profit", "ebit (tax/interest)", 
  "income tax", "dividends payment for the year", "depreciation", "interest", 
  "gross profit", "sales", "number of shares outstanding"
)

modules::export("counting_statistics")
counting_statistics <- list(
  n = ~sum(.[. != 0L], na.rm = TRUE)
)

modules::export("summarising_statistics")
summarising_statistics <- append(
  list(n = function(x) { do.call(sum, list(!is.na(x) & x != 0L)) }),
  lapply(
    c(min = "min", max = "max", mean = "mean"), 
    function(stat) function(x) { do.call(stat, list(x[x != 0], na.rm = TRUE)) }
  )
)
