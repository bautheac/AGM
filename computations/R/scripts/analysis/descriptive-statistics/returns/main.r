pacman::p_load(here, modules)


path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "wrangler.r"
)
wrangler <- modules::use(path_wrangler)
path_staistics_computer <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", 
  "statistics-computer", "main.r"
)
statistics_computer <- modules::use(path_staistics_computer)


dataset <- wrangler$make_dataset()


statistics <- statistics_computer$compute_returns_statistics(dataset)

firm <- statistics$firm
