pacman::p_load(modules, tibble)


modules::export("records")
records <- tibble::tribble(
  ~id,       ~`date of reporting period end`,    ~`comment`,
  "BA049",   "1914-08-31",                       "Check all dates.",
  "FO001",   "1912-06-30",                       "Check all dates.",
  "GLC03",   "1909-01-28",                       "Check date of auditing.",
  "OT001",   "1911-03-31",                       "Check last day of closed books.",
  "OT019",   "1912-08-31",                       "Check date of reporting period end date.",
  "OT026",   "1910-10-31",                       "Check all dates.",
  "OT026",   "1911-10-31",                       "Check all dates.",
  "OT026",   "1912-10-31",                       "Check all dates.",
  "OT026",   "1913-10-31",                       "Check all dates.",
  "OT026",   "1914-10-31",                       "Check all dates.",
  "OT029",   "1914-06-30",                       "Check both both first and last day of closed books.",
  "OT041",   "1910-08-31",                       "Check all dates.",
  "OT048",   "1913-04-30",                       "Check all dates.",
  "RL008",   "1913-03-30",                       "Check end of period date.",
  "RL008",   "1914-03-30",                       "Check reporting frequency (set as annual but looks semi-annual).",
  "RL024",   "1912-06-30",                       "Check all dates.",
  "RL045",   "1912-06-30",                       "Check AGM date.",
  "RL049",   "1910-06-30",                       "Check AGM date.",
  "RL074",   "1912-06-30",                       "Check date of auditing.",
  "TR007",   "1913-12-31",                       "Check AGM date.",
)