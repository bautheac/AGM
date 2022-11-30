library(magrittr)

data_availability <- readr::read_csv("wide.csv")

availables <- tidyr::pivot_longer(
  data_availability, cols = c("traded", "price", "spread"), "field", "value"
)
readr::write_csv(availables, "long.csv")

