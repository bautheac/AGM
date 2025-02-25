suppressMessages(modules::import(here))


count_events_regardless_of_reporting_frequency <- function(firm_stats){
  
  dplyr::group_by(firm_stats, year, event) |>
    dplyr::summarise(n = dplyr::n()) |> dplyr::ungroup() |>
    dplyr::mutate(`reporting period` = NA)
  
}

count_events_by_reporting_frequency <- function(firm_stats){
  
  dplyr::group_by(firm_stats, `reporting frequency`, year, `reporting period`, event) |>
    dplyr::summarise(n = dplyr::n()) |> dplyr::ungroup()
  
}

modules::export("count_events")
count_events <- function(firm_stats){
  
  all <- count_events_regardless_of_reporting_frequency(firm_stats) |>
    dplyr::mutate(`reporting frequency` = "all")
  
  frequencies <- count_events_by_reporting_frequency(firm_stats)
  
  dplyr::bind_rows(all, frequencies)
}
