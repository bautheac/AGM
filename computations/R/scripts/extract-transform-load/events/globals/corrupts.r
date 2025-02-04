suppressMessages(import(tibble))

modules::export("corrupt_records")
corrupt_records <- tibble::tribble(
  ~column,    ~condition,                                              ~new_value,
  "event",    "id == 'OT005' & date == '1913-02-24'",                  "",
  "event",    "id == 'OT005' & date == '1913-05-24'",                  "FC",
  "event",    "id == 'OT010' & date == '1913-02-11'",                  "",
  "event",    "id == 'OT010' & date == '1913-02-15'",                  "LD AU",
  "event",    "id == 'OT010' & date == '1913-02-26'",                  "",
  "event",    "id == 'OT010' & date == '1913-02-27'",                  "GM",
  "event",    "id == 'OT010' & date == '1913-02-28'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-25'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-26'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-27'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-28'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-29'",                  "",
  "event",    "id == 'OT010' & event == 'FC' & date == '1913-02-11'",  "",
)

modules::export("missing_records")
missing_records <- tibble::tribble(
  ~id,     ~date,        ~event,
  'OT005', '1913-05-23', 'LD',
  'OT005', '1913-05-23', 'AU',
)


