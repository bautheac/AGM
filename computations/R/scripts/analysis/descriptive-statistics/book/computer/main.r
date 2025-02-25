suppressMessages({ modules::import(dplyr); modules::import(stats) })


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "book", 
  "computer", "globals", "paths.r"
)
paths <- modules::use(path_paths)

extracter <- modules::use(paths$path_extracter)
wrangler <- modules::use(paths$path_wrangler)
formatter <- modules::use(paths$path_local_formatter)
computer <- modules::use(paths$path_global_computer)
local_variables <- modules::use(paths$path_local_variables)


compute_stats_for_pooled_reporting_periods <- 
  function(data, variables_to_count, variables_to_summarise, counting_statistics, summarising_statistics){

  whole <- dplyr::mutate(data, `reporting frequency` = "all", `reporting period` = NA)
  
  count <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    computer$compute_stats_for_variables(variables_to_count, counting_statistics) |> 
    dplyr::ungroup()
  summary <- dplyr::group_by(whole, `reporting frequency`, year, `reporting period`) |>
    computer$compute_stats_for_variables(variables_to_summarise, summarising_statistics) |> 
    dplyr::ungroup()
  
  dplyr::left_join(count, summary, by = c("reporting frequency", "year", "reporting period"))
}

compute_stats_by_reporting_period <- 
  function(data, variables_to_count, variables_to_summarise, counting_statistics, summarising_statistics){

  count <- dplyr::group_by(data, `reporting frequency`, year, `reporting period`) |>
    computer$compute_stats_for_variables(variables_to_count, counting_statistics) |> 
    dplyr::ungroup()
  summary <- dplyr::group_by(data, `reporting frequency`, year, `reporting period`) |>
    computer$compute_stats_for_variables(variables_to_summarise, summarising_statistics) |> 
    dplyr::ungroup()
  
  dplyr::left_join(count, summary, by = c("reporting frequency", "year", "reporting period"))
}
 

compute_descriptive_statistics <- function(data){
  
  pooled <- compute_stats_for_pooled_reporting_periods(
    data, 
    local_variables$variables_to_count, local_variables$variables_to_summarise, 
    local_variables$counting_statistics, local_variables$summarising_statistics
  )
  
  periods <- compute_stats_by_reporting_period(
      data, 
      local_variables$variables_to_count, local_variables$variables_to_summarise, 
      local_variables$counting_statistics, local_variables$summarising_statistics
    )
  
  dplyr::bind_rows(pooled, periods) |>
    formatter$format_summary_statistics(c("reporting frequency", "year", "reporting period"))
}


modules::export("compute_book_statistics")
compute_book_statistics <- function(firm_ids = "all"){
  
  book_data <- extracter$extract_clean_book_data() |>
    dplyr::filter(firm_ids == "all" | id %in% firm_ids) |>
    wrangler$prepare_dataset_for_descriptive_stats_analysis()
  
  compute_descriptive_statistics(book_data)
}
