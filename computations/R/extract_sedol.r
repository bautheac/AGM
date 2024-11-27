################################################################################
# Extract Stock Exchange Daily Official List (sedol) data from Excel
################################################################################
################################################################################
# Use 
################################################################################
# To be used from a Shell.
# E.g. Rscript ./scripts/extract_sedol.r sedol.xlsm
################################################################################
################################################################################
# Args
################################################################################
# Takes one argument: name of the file to extract data from with file extension. 
# The file name must refer to an Excel (xlsx/xlsm) file that lives in the "data" 
# folder of the repo where this script is located.
# The file must contain sedol time series data on a firm-sheet basis where each 
# sheet contains data for a particular company referred to by its ID with the 
# sheet named after the firm's ID. 
# The data must be laid out as follows:
# Rowise: data starts at row 4.
# Columnwise: data spans columns 1 to 8. 
## Columns 1 to 4 show dates, and for each date, corresponding week day, whether
## the date is a trading day or not and whether data is available for that day 
## (sedol page exists + photograph of that page is available). 
## Columns 5 to 8 record firm common stock data: price (column 5), spread-low 
## (column 6), spread-high (column 7) and event (column 8).
################################################################################
################################################################################
# Output
################################################################################
# Outputs the extracted data agglomerated in a .csv flat file named after the 
# original file name supplied as argument with the "-raw" suffix. 
# Columns include: firm ID, date, day, trading, data available, spread-low, 
# spread-high, event
################################################################################
################################################################################

library(magrittr)

file_name <- commandArgs(trailingOnly = TRUE)[1]


# Define globals
path <- here::here('data', file_name)
col_names <- c(
  "date", "day", "trading", "data available", "price",
  "spread-low", "spread-high", "event"
  )
col_types <- c("date", rep("text", 7L))
homesheet_name <- "home"


# Define functions
extract_firm_data <- function(id){
  data <- readxl::read_xlsx(
    path, id, range = readxl::cell_limits(c(4L, 1L), c(NA, 8L)),
    col_names = col_names, col_types = col_types
  ) %>% dplyr::mutate(id = id)
  message(paste0("Done ", id, "."))
  data
}


# Get relevant sheet names (firm IDs)
names <- readxl::excel_sheets(path) %>%
  purrr::discard(.p=stringr::str_detect, pattern = homesheet_name)


# Load data from relevant sheet names
message("Starting extracting firms data.\n")
data <- purrr::map_dfr(names, extract_firm_data) %>% 
  dplyr::select(id, dplyr::everything())
message("\nDone extracting firms data.")


# Export
out <- sub("\\.[^.]+$", "", path) %>%paste0("-raw.csv")
message(paste0("\nSaving to ", out))
readr::write_csv(data, out)

message("\nDone.")