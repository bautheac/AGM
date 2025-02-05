suppressMessages(import(dplyr))


modules::export("compute_stats_for_variables")
compute_stats_for_variables <- function(data, variables, statistics){
  
  dplyr::summarise(
    data,
    dplyr::across(dplyr::all_of(variables), statistics, .names = "{.col}_{.fn}")
  )
}

modules::export("summarising_statistics")
summarising_statistics <- append(
  list(n = function(x) { do.call(sum, list(!is.na(x) & x != 0L)) }),
  lapply(c(min = "min", max = "max", mean = "mean"), function(stat) function(x) { do.call(stat, list(x[x != 0], na.rm = TRUE)) })
)