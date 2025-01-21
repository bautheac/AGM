pacman::p_load(dplyr, modules)

clean_corrupts_event_records <- function(events_data){
  
  dplyr::mutate(
    events_data,
    event = ifelse(id == "BA031" & date == "1913-07-25", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-26", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-27", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-28", "", event),
    event = ifelse(id == "BA031" & date == "1913-07-29", "", event),
  )
}

modules::export("clean_relevant_variables")
clean_relevant_variables <- function(events_data){
  
  clean_corrupts_event_records(events_data) |>
    dplyr::filter(!(is.na(event) | event == ""))
}