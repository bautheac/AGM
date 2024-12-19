################################################################################
# Transform extracted Stock Exchange Daily Official List (sedol) data
################################################################################
################################################################################
# Use 
################################################################################
# To be used from a Shell.
# E.g. Rscript ./scripts/transform_sedol.r sedol-raw
################################################################################
################################################################################
# Args
################################################################################
# Takes one argument: name of the file where data to be processed lives.
# The file name must refer to a .csv file that lives in the data folder
# of the repo where this script is located.
# The file must contain agglomerated sedol time series data laid out as follows:
## Column 1: 'id'; the firm ID.
## Column 2: 'date'.
## Column 3: 'day'; day of the week for the corresponding date (column 2).
## Column 4: 'trading'; whether corresponding date is a trading day or not.
## Column 5: 'data available'; whether there exist sedol records for that date 
## and there exist a photograph of these.
## Column 6: 'price'; corresponding common stock quote prices.
## Column 7: 'spread-low'; corresponding common stock spread low quote.
## Column 8: 'spread-high'; corresponding common stock spread high quote.
## Column 9: 'event'; corresponding firm-date event list.
################################################################################
################################################################################
# Output
################################################################################
# Dataset after transform operations have been carried out; saved as a .csv flat
# file named after the original file name supplied as argument without the 
# '-raw' suffix. 
################################################################################
################################################################################

library(magrittr)

file_name <- commandArgs(trailingOnly = TRUE)[1]


# Define globals
path <- here::here('data', file_name)
col_types <- c("c", "D", rep("c", 7L))


# Load data from file
data <- readr::read_csv(paste0(path, ".csv"), col_types = col_types)

# Transform 'day' and 'trading' columns from text to bool
message("Starting transforming data.")
data <- dplyr::mutate(
  data, 
  dplyr::across(trading:`data available`, ~ ifelse(.x == 'yes', TRUE, FALSE))
  )
message("\nDone transforming data.")

# Export
out <- paste0(stringr::str_extract(path, "\\/.+(?=-raw)"), ".csv")
message(paste0("\nSaving to ", out))
readr::write_csv(data, out)

message("\nDone.")