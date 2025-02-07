suppressMessages({ import(glue); import(shiny) })


modules::export("number_rows_to_display")
number_rows_to_display <- 50L

# modules::export("caption_clean")
# caption_clean <- glue::glue("
# After being extracted from the respective source files the data has been cleaned 
# off corrupts records. The detail of the corrections carried out is available in 
# the '<a id=\"go_to_corrupts\" class=\"action-button\" href=\"#\">corrupts</a>' 
# section. The first {number_rows_to_display} records of the resulting clean datasets 
# are shown below with the full datasets individually available for download. A number 
# of seemingly corrupt records are still pending correction with the detai also 
# available in the 
# '<a id=\"go_to_corrupts\" class=\"action-button\" href=\"#\">corrupts</a>' 
# section. The corresponding firm-date combinations are excluded from the book 
# dataset while the full time series of returns and events for the corresponding 
# firms are excluded from the datasets below. 
# ")

modules::export("caption_clean")
caption_clean <- glue::glue("
This page shows the data used in the study after it's been off corrupts records. 
The detail of the corrections carried out is available in the 'corrupts' section. 
The first {number_rows_to_display} records of the resulting clean datasets are 
shown below with the full datasets individually available for download. A number 
of seemingly corrupt records are still pending correction with the detail also 
available in the 'corrupts' section. The corresponding firm-date combinations are 
excluded from the book dataset while the full time series of returns and events 
for the corresponding firms are excluded from the returns and events datasets below. 
")

modules::export("caption_book")
caption_book <- "Source file: 'H and peck data_Final.xlsx'; tab: 'Dataset'"

modules::export("caption_returns")
caption_returns <- "Source file: 'AGMdata.dta'"

modules::export("caption_events")
caption_events <- "Source file: 'AGMdata.dta'"
