pacman::p_load(modules)

modules::export("events_of_interest")
events_of_interest <- c("LD", "AU", "FC", "LC", "GM")

modules::export("firm_days_statistics_params")
firm_days_statistics_params <- list(
  `# days available before` = list(break_fun = "is.na", break_n = 5L, direction = "before"),
  `# days available after` = list(break_fun = "is.na", break_n = 5L, direction = "after"),
  `# days available & non-zero before` = list(break_fun = "equals_zero", break_n = 5L, direction = "before"),
  `# days available & non-zero after` = list(break_fun = "equals_zero", break_n = 5L, direction = "after")
)

modules::export("firm_days_statistics_variables")
firm_days_statistics_variables <- c("date", "event", names(firm_days_statistics_params))