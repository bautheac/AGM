suppressMessages(import(dplyr))


raw_to_clean_names_map <- c(
  "date"                                      = "A",
  "day of the week"                           = "B",
  "trading"                                   = "C",
  "data available"                            = "D",
  "price"                                     = "E",
  "low"                                       = "F",
  "high"                                      = "G",
  "event"                                     = "H",
  "id"                                        = "Company"
)

modules::export("rename_variables")
rename_variables <- function(price_data) {
  dplyr::rename(price_data, !!!raw_to_clean_names_map)
}