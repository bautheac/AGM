pacman::p_load(modules)


path_variables_selecter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "variables_selecter.r"
)
variables_selecter <- modules::use(path_variables_selecter)


high_availability_book_firms <- variables_selecter$select_high_availability_book_firms()


