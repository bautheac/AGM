pacman::p_load(dplyr, lubridate, modules, tibble)


modules::export("clean_corrupts_event_records")
clean_corrupts_event_records <- function(events_data){

  dplyr::mutate(
    events_data,
    date = as.character(date),
    date = ifelse(id == "OT005" & event == "FC" & date == "1913-02-24", "1913-05-24", date),
    date = ifelse(id == "OT010" & event == "AU" & date == "1913-02-11", "1913-02-15", date),
    date = ifelse(id == "OT010" & event == "LD" & date == "1913-02-11", "1913-02-15", date),
    date = ifelse(id == "OT010" & event == "GM" & date == "1913-02-26", "1913-02-27", date),
    event = ifelse(id == "BA031" & date == "1913-07-25", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-26", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-27", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-28", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-29", "", event),
    event = ifelse(id == "OT010" & event == "FC" & date == "1913-02-11", "", event),
    event = ifelse(id == "OT010" & event == "LC" & date == "1913-02-28", "", event),
  )
}

modules::export("add_missing_records")
add_missing_records <- function(events_data){
  
  dplyr::bind_rows(
    events_data,
    tibble::tribble(
      ~id,     ~date,        ~event,
      "OT005", "1913-05-23", "LD",
      "OT005", "1913-05-23", "AU",
    )
  )
}