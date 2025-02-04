suppressMessages(import(dplyr))


raw_to_clean_names_map <- c(
  "number"                                    = "No",
  "company name"                              = "CoName",
  "id"                                        = "ID",
  "full year"                                 = "Full year",
  "industry"                                  = "Industry",
  "town of head office"                       = "Town of head office",
  "country basis of operations"               = "Country basis of operations",
  "date of reporting period end"              = "Year end date",
  "date of signing the letter"                = "Date of signing the letter",
  "date of auditing"                          = "Auditing date",
  "dates of closed books period available"    = "Closure of books",
  "first day of closed books"                 = "First day of closed books",
  "last day of closed books"                  = "Last day of closed books",
  "date of AGM"                               = "AGM Date",
  "auditor name"                              = "Auditor name",
  "dividends"                                 = "Dividends",
  "reporting currency gbp"                    = "Reporting Currency GBP",
  "other currency"                            = "Other Currency",
  "book value equity"                         = "BVE",
  "total assets"                              = "Total Assets",
  "non-current assets"                        = "Non-Current Assets",
  "current assets"                            = "Current Assets",
  "total assets valid"                        = "Amount verification...23",
  "total liabilities"                         = "Total Liabilities",
  "non-current liabilities"                   = "Non-current Liabilities",
  "current liabilities"                       = "Current Liabilities",
  "total liabilities valid"                   = "Amount verification...27",
  "total debt"                                = "Total Debt",
  "bank debt"                                 = "Bank Debt",
  "other debt"                                = "Other Debt",
  "cash"                                      = "Cash",
  "intangibles/goodwill"                      = "Intangibles/ Goodwill",
  "net profit"                                = "Net profit",
  "ebit (tax/interest)"                       = "EBIT (tax/int)",
  "income tax"                                = "Income tax",
  "dividends payment for the year"           = "Dividends paymment for the year",
  "depreciation"                              = "Depreciation",
  "interest"                                  = "Interest",
  "gross profit"                              = "Gross Profit",
  "sales"                                     = "Sales",
  "number of shares outstanding"              = "Number of shares outstanding"
)

modules::export("rename_variables")
rename_variables <- function(book_data) {
  dplyr::rename(book_data, !!!raw_to_clean_names_map)
}