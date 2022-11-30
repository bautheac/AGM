library(magrittr)

# Defining globals
path <- here::here('data', 'sedol')
col_names <- c(
  "date", "day", "trading", "data available", "price", "spread-low", "spread-high", "event"
  )
col_types <- c("date", rep("text", 7L))

# Get relevant sheet names
names <- readxl::excel_sheets(paste0(path, ".xlsx")) %>%
  purrr::discard(.p=stringr::str_detect, pattern = "template")

# Load data from relevant sheet names
data <- purrr::map_dfr(
  names, 
  function(x) {
    readxl::read_xlsx(
      paste0(path, ".xlsx"), x, 
      range = readxl::cell_limits(c(4L, 1L), c(NA, 8L)),
      col_names = col_names, col_types = col_types
    ) %>% dplyr::mutate(id = x)
  }
) %>% dplyr::select(id, dplyr::everything())

# Export
readr::write_csv(data, paste0(path, ".csv"))