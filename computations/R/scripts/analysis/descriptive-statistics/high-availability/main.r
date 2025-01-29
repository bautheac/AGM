pacman::p_load(here, modules)


path_firms_selecter <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "firms_selecter.r"
)
firms_selecter <- modules::use(path_firms_selecter)
path_book_stats_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "book", "computer", "main.r"
)
book_stats_computer <- modules::use(path_book_stats_computer)
path_returns_stats_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "returns", "computer", "main.r"
)
returns_stats_computer <- modules::use(path_returns_stats_computer)


book_firms_ids <- firms_selecter$select_high_availability_book_firms()
book_firms_stats <- book_stats_computer$compute_book_statistics(book_firms_ids)

return_firms_ids <- firms_selecter$select_high_availability_returns_firms()
return_firms_stats <- returns_stats_computer$compute_returns_statistics(return_firms_ids)


intersection_firms_ids <- intersect(book_firms_ids, return_firms_ids)
intersection_firms_book_stats <- book_stats_computer$compute_book_statistics(intersection_firms_ids)
intersection_firms_return_stats <- returns_stats_computer$compute_returns_statistics(intersection_firms_ids)