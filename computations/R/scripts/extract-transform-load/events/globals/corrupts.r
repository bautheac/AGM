pacman::p_load(modules, tibble)


modules::export("corrupt_records")
corrupt_records <- tibble::tribble(
  ~column,    ~condition,                                              ~new_value,
  "date",     "id == 'OT005' & event == 'FC' & date == '1913-02-24'",  "1913-05-24",
  "date",     "id == 'OT010' & event == 'AU' & date == '1913-02-11'",  "1913-02-15",
  "date",     "id == 'OT010' & event == 'LD' & date == '1913-02-11'",  "1913-02-15",
  "date",     "id == 'OT010' & event == 'GM' & date == '1913-02-26'",  "1913-02-27",
  "event",    "id == 'BA031' & date == '1913-07-25'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-26'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-27'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-28'",                  "",
  "event",    "id == 'BA031' & date == '1913-07-29'",                  "",
  "event",    "id == 'OT010' & event == 'FC' & date == '1913-02-11'",  "",
  "event",    "id == 'OT010' & event == 'LC' & date == '1913-02-28'",  "",
)

modules::export("missing_records")
missing_records <- tibble::tribble(
  ~id,     ~date,        ~event,
  'OT005', '1913-05-23', 'LD',
  'OT005', '1913-05-23', 'AU',
)


