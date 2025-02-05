pacman::p_load(here)


path_paths <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", 
  "high-availability", "globals", "paths.r"
)
paths <- modules::use(path_paths)

firms_selecter <- modules::use(paths$path_firms_selecter)
book_stats_computer <- modules::use(paths$path_book_stats_computer)
returns_stats_computer <- modules::use(paths$path_returns_stats_computer)
wrangler <- modules::use(paths$path_wrangler)
loader <- modules::use(paths$path_loader)


book_firms_ids <- firms_selecter$select_high_availability_book_firms()
book_firms_names <- wrangler$retrieve_names(book_firms_ids)
book_firms_stats <- book_stats_computer$compute_book_statistics(book_firms_ids)

return_firms_ids <- firms_selecter$select_high_availability_returns_firms()
return_firms_names <- wrangler$retrieve_names(return_firms_ids)
return_firms_stats <- returns_stats_computer$compute_returns_statistics(return_firms_ids)


intersection_firms_ids <- intersect(book_firms_ids, return_firms_ids)
intersection_firms_names <- wrangler$retrieve_names(intersection_firms_ids)
intersection_firms_book_stats <- book_stats_computer$compute_book_statistics(intersection_firms_ids)
intersection_firms_return_stats <- returns_stats_computer$compute_returns_statistics(intersection_firms_ids)


loader$load_objects(
  list(
    book_firms_names, book_firms_stats, 
    return_firms_names, return_firms_stats$firm, return_firms_stats$aggregate,
    intersection_firms_names, intersection_firms_book_stats, 
    intersection_firms_return_stats$firm, intersection_firms_return_stats$aggregate
  ), 
  paths$paths
)

rm(list = ls())