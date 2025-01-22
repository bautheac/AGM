pacman::p_load(here, modules)


path_wrangler <- here::here(
  "computations", "R", "scripts", "analysis", "descriptive-statistics", "returns", "wrangler.r"
)
wrangler <- modules::use(path_wrangler)


dataset <- wrangler$make_dataset()