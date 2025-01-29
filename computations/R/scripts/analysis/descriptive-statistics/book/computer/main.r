pacman::p_load(dplyr, modules, stats)

path_extracter <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "globals", "extracter.r"
)
extracter <- modules::use(path_extracter)
path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "wrangler", "main.r"
)
wrangler <- modules::use(path_wrangler)
path_formatter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "formatter.r"
  )
formatter <- modules::use(path_formatter)
path_computer_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals", 
  "computer.r"
  )
computer_globals <- modules::use(path_computer_globals)
path_local_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "globals.r"
  )
local_globals <- modules::use(path_local_globals)
path_book_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "globals.r"
)
book_globals <- modules::use(path_book_globals)



compute_stats_for_pooled_reporting_periods <- 
  function(data, variables_to_count, variables_to_summarise, counting_statistics, summarising_statistics){

  whole <- dplyr::mutate(data, `reporting frequency` = "all", `reporting period` = NA)
  
  count <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    computer_globals$compute_stats_for_variables(variables_to_count, counting_statistics) |> 
    dplyr::ungroup()
  summary <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    computer_globals$compute_stats_for_variables(variables_to_summarise, summarising_statistics) |> 
    dplyr::ungroup()
  
  dplyr::left_join(count, summary, by = c("reporting frequency", "year", "reporting period"))
}

compute_stats_by_reporting_period <- 
  function(data, variables_to_count, variables_to_summarise, counting_statistics, summarising_statistics){

  count <- dplyr::group_by(data, `reporting frequency`, year, `reporting period`) |>
    computer_globals$compute_stats_for_variables(variables_to_count, counting_statistics) |> 
    dplyr::ungroup()
  summary <- dplyr::group_by(data, `reporting frequency`, year, `reporting period`) |>
    computer_globals$compute_stats_for_variables(variables_to_summarise, summarising_statistics) |> 
    dplyr::ungroup()
  
  dplyr::left_join(count, summary, by = c("reporting frequency", "year", "reporting period"))
}
 

compute_descriptive_statistics <- function(data){
  
  pooled <- compute_stats_for_pooled_reporting_periods(
    data, 
    local_globals$variables_to_count, local_globals$variables_to_summarise, 
    local_globals$counting_statistics, computer_globals$summarising_statistics
  )
  
  periods <- compute_stats_by_reporting_period(
      data, 
      local_globals$variables_to_count, local_globals$variables_to_summarise, 
      local_globals$counting_statistics, computer_globals$summarising_statistics
    )
  
  dplyr::bind_rows(pooled, periods) |>
    formatter$format_summary_statistics(c("reporting frequency", "year", "reporting period"))
}


modules::export("compute_book_statistics")
compute_book_statistics <- function(firm_ids = "all"){
  
  book_data <- extracter$extract_rds_data(book_globals$path_book_data_clean) |>
    dplyr::filter(firm_ids == "all" | id %in% firm_ids) |>
    wrangler$prepare_dataset_for_descriptive_stats_analysis()
  
  compute_descriptive_statistics(book_data)
}
