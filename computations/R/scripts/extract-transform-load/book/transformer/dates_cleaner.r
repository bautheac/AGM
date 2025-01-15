pacman::p_load(dplyr, lubridate, modules, stringr)

correct_unformatted_date_typos <- function(book_data){
  dplyr::mutate(
    book_data, 
    `date of auditing` = ifelse(`date of auditing` == "03/011914", "03/01/1914", `date of auditing`),
    `date of auditing` = ifelse(`date of auditing` == "40924", "4424", `date of auditing`),
    `first day of closed books` = ifelse(`first day of closed books` == "25/05/194", "25/05/1914", `first day of closed books`),
    `first day of closed books` = ifelse(`first day of closed books` == "41249", "4749", `first day of closed books`),
    `first day of closed books` = ifelse(`first day of closed books` == "43659", "3659", `first day of closed books`),
    `first day of closed books` = stringr::str_replace(`first day of closed books`, "-(\\d{2})\\?\\?", "-19\\1") |> stringr::str_replace("-", "\\\\"),
    `last day of closed books` = as.numeric(as.Date(`last day of closed books`) - as.Date("1899-12-30")),
    `last day of closed books` = ifelse(`last day of closed books` == "43680", "3680", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "41262", "4262", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "41262", "4762", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "41171", "4771", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "28326", "4326", `last day of closed books`),
    `date of AGM` = ifelse(`date of AGM` == "43680", "3680", `date of AGM`),
    `date of AGM` = ifelse(`date of AGM` == "40933", "4433", `date of AGM`),
  )
}

correct_formatted_date_typos <- function(book_data){
  dplyr::mutate(
    book_data, 
    `date of signing the letter` = ifelse(id == "FO002" & `date of year end` == "1911-12-31", "1912-02-09", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "OT010" & `date of year end` == "1913-12-31", "1914-02-12", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "RL045" & `date of year end` == "1910-12-31", "1911-01-23", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "RL067" & `date of year end` == "1913-12-31", "1914-02-19", as.character(`date of signing the letter`)),
    `date of auditing` = ifelse(id == "IC011" & `date of year end` == "1913-06-30", "1913-09-15", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "IC023" & `date of year end` == "1912-09-30", "1912-11-13", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "OT010" & `date of year end` == "1913-12-31", "1914-02-11", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "RL059" & `date of year end` == "1912-12-31", "1913-02-12", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "RL067" & `date of year end` == "1913-12-31", "1914-02-19", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "TR008" & `date of year end` == "1911-12-31", "1912-01-23", as.character(`date of auditing`)),
    `last day of closed books` = ifelse(id == "BR004" & `date of year end` == "1910-09-30", "1911-01-04", as.character(`last day of closed books`)),
    `first day of closed books` = ifelse(id == "CN001" & `date of year end` == "1913-06-30", "1913-12-01", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "OT010" & `date of year end` == "1913-12-31", "1914-02-11", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "OT016" & `date of year end` == "1911-04-12", "1911-05-11", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "RL007" & `date of year end` == "1910-12-31", "1911-01-20", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "RL034" & `date of year end` == "1910-06-30", "1910-07-03", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "RL069" & `date of year end` == "1913-06-30", "1913-10-06", as.character(`first day of closed books`)),
    `last day of closed books` = ifelse(id == "OT010" & `date of year end` == "1913-12-31", "1914-02-28", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "OT016" & `date of year end` == "1911-04-12", "1911-05-29", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "OT029" & `date of year end` == "1914-06-30", "1915-01-04", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL001" & `date of year end` == "1910-12-31", "1911-03-18", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL007" & `date of year end` == "1910-12-31", "1911-02-03", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL034" & `date of year end` == "1910-06-30", "1910-07-25", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL069" & `date of year end` == "1913-06-30", "1913-10-22", as.character(`last day of closed books`)),
    `date of AGM` = ifelse(id == "CN002" & `date of year end` == "1912-12-31", "1913-03-14", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "FO003" & `date of year end` == "1912-05-31", "1912-07-17", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "OT010" & `date of year end` == "1913-12-31", "1914-02-26", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "RL028" & `date of year end` == "1913-06-30", "1913-11-12", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "RL059" & `date of year end` == "1912-12-31", "1913-02-20", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "RL067" & `date of year end` == "1913-12-31", "1914-03-05", as.character(`date of AGM`)),
  )
}

convert_to_standard_date_format_from_excel <- function(dates) {
  
  dates <- stringr::str_replace(dates, "^\\d{1}$", NA_character_)
  
  dates <- stringr::str_replace(dates, "^\\*+$", NA_character_)
  
  ifelse(
    # If the column is numeric, 
    !is.na(as.numeric(dates)),
    # convert using Excel origin,
    as.Date(as.numeric(dates), origin = "1899-12-30"),
    # otherwise, attempt to parse string dates.
    lubridate::dmy(dates) # Parse dates in "day/month/year" format
  ) |> as.Date()
}

convert_to_standard_date_format_from_excel <- function(dates) {
  
  dates <- stringr::str_replace(dates, "^\\d{1}$", NA_character_)
  
  dates <- stringr::str_replace(dates, "^\\*+$", NA_character_)
  
  ifelse(
    # If the column is numeric, 
    !is.na(as.numeric(dates)),
    # convert using Excel origin,
    as.Date(as.numeric(dates), origin = "1899-12-30"),
    # otherwise, attempt to parse string dates.
    lubridate::dmy(dates) # Parse dates in "day/month/year" format
  ) |> as.Date() |> as.character()
}

format_dates <- function(book_data, format_function){

  dplyr::mutate(
    book_data, 
    dplyr::across(
      .cols = matches("date|day", ignore.case = TRUE) & !matches("available", ignore.case = TRUE), 
      .fns = format_function
    )
  )
}



modules::export("clean_date_columns")
clean_date_columns <- function(book_data){
  
  correct_unformatted_date_typos(book_data) |>
    format_dates(convert_to_standard_date_format_from_excel) |>
    correct_formatted_date_typos()
}