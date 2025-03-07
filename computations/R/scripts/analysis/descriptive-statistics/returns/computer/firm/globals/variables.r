modules::export("events_of_interest")
events_of_interest <- c("LD", "AU", "FC", "LC", "GM")

break_n <- 5L

firm_days_available_statistics_params <- list(
  `# days available before` = list(break_fun = "is.na", break_n = break_n, direction = "before"),
  `# days available after` = list(break_fun = "is.na", break_n = break_n, direction = "after")
)

firm_days_available_non_zero_statistics_params <- list(
  `# days available & non-zero before` = list(break_fun = "equals_zero", break_n = break_n, direction = "before"),
  `# days available & non-zero after` = list(break_fun = "equals_zero", break_n = break_n, direction = "after")
)

modules::export("firm_days_statistics_params")
firm_days_statistics_params <- c(
  firm_days_available_statistics_params,
  firm_days_available_non_zero_statistics_params
)


modules::export("firm_days_available_variables")
firm_days_available_variables <- names(firm_days_available_statistics_params)

modules::export("firm_days_available_non_zero_variables")
firm_days_available_non_zero_variables <- 
  names(firm_days_available_non_zero_statistics_params)

modules::export("firm_days_variables")
firm_days_variables <- names(firm_days_statistics_params)

modules::export("firm_days_columns")
firm_days_columns <- c("date", "event", names(firm_days_statistics_params))