suppressMessages({ modules::import(dplyr); modules::import(here) })


path_corrupts <- here::here(
  "computations", "R", "scripts", "extract-transform-load", "book", "globals", "corrupts.r"
)
corrupts <- modules::use(path_corrupts)


modules::export("filter_out_pending_corrupt_records")
filter_out_pending_corrupt_records <- function(book_data) {
  
  dplyr::anti_join(book_data, corrupts$pending, by = c("id", "date of reporting period end"))
}



