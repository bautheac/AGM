pacman::p_load(dplyr, here, modules)


path_computer_globals <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "globals",
  "computer.r"
)
computer_globals <- modules::use(path_computer_globals)

summarising_statistics_globals <- computer_globals$summarising_statistics

modules::export("summarising_statistics")
summarising_statistics <- summarising_statistics_globals[!names(summarising_statistics_globals) %in% c("n")]

modules::export("count_variable")
count_variable <- "# observations"