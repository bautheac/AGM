pacman::p_load(dplyr, lubridate, modules, stringr)

correct_unformatted_date_typos <- function(book_data){
  dplyr::mutate(
    book_data, 
    `date of reporting period end` = ifelse(`date of reporting period end` == "29/02/1911", "28/02/1911", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "29/02/1913", "28/02/1913", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/06/1910", "30/06/1910", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/09/1909", "30/09/1909", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/09/1910", "30/09/1910", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/09/1911", "30/09/1911", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/09/1912", "30/09/1912", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/09/1913", "30/09/1913", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/09/1914", "30/09/1914", `date of reporting period end`),
    `date of reporting period end` = ifelse(`date of reporting period end` == "31/09/1915", "30/09/1915", `date of reporting period end`),
    `date of signing the letter` = ifelse(`date of signing the letter` == "30/02/1914", "28/02/1914", `date of signing the letter`),
    `date of auditing` = ifelse(`date of auditing` == "03/011914", "03/01/1914", `date of auditing`),
    `date of auditing` = ifelse(`date of auditing` == "1", "", `date of auditing`),
    `date of auditing` = ifelse(`date of auditing` == "40924", "4424", `date of auditing`),
    `first day of closed books` = ifelse(`first day of closed books` == "23-03-11??", "23/03/1911", `first day of closed books`),
    `first day of closed books` = ifelse(`first day of closed books` == "25-03-12??", "25/03/1912", `first day of closed books`),
    `first day of closed books` = ifelse(`first day of closed books` == "25/05/194", "25/05/1914", `first day of closed books`),
    `first day of closed books` = ifelse(`first day of closed books` == "31/11/1913", "30/11/1913", `first day of closed books`),
    `first day of closed books` = ifelse(`first day of closed books` == "41249", "4749", `first day of closed books`),
    `first day of closed books` = ifelse(`first day of closed books` == "43659", "3659", `first day of closed books`),
    `first day of closed books` = stringr::str_replace(`first day of closed books`, "-(\\d{2})\\?\\?", "-19\\1") |> stringr::str_replace("-", "\\\\"),
    `last day of closed books` = as.numeric(as.Date(`last day of closed books`) - as.Date("1899-12-30")),
    `last day of closed books` = ifelse(`last day of closed books` == "43680", "3680", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "41262", "4262", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "41262", "4762", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "41171", "4771", `last day of closed books`),
    `last day of closed books` = ifelse(`last day of closed books` == "28326", "4326", `last day of closed books`),
    `date of AGM` = ifelse(`date of AGM` == "09/02/1911", "4058", `date of AGM`),
    `date of AGM` = ifelse(`date of AGM` == "43680", "3680", `date of AGM`),
    `date of AGM` = ifelse(`date of AGM` == "40933", "4433", `date of AGM`),
  )
}

correct_formatted_date_typos <- function(book_data){
  dplyr::mutate(
    book_data, 
    `date of reporting period end` = ifelse(id == "RL016" & `date of reporting period end` == "1912-12-31", "1913-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL016" & `date of reporting period end` == "1913-12-31", "1914-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL030" & `date of reporting period end` == "1912-12-31", "1913-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL030" & `date of reporting period end` == "1913-12-31", "1914-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL031" & `date of reporting period end` == "1912-12-31", "1913-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL031" & `date of reporting period end` == "1913-12-31", "1914-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL035" & `date of reporting period end` == "1912-12-31", "1913-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL035" & `date of reporting period end` == "1913-12-31", "1914-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL042" & `date of reporting period end` == "1912-12-31", "1913-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL042" & `date of reporting period end` == "1913-12-31", "1914-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL071" & `date of reporting period end` == "1912-12-31", "1913-01-01", as.character(`date of reporting period end`)),
    `date of reporting period end` = ifelse(id == "RL071" & `date of reporting period end` == "1913-12-31", "1914-01-01", as.character(`date of reporting period end`)),
    `date of signing the letter` = ifelse(id == "BA037" & `date of reporting period end` == "1910-12-31", "1911-01-17", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "BA044" & `date of reporting period end` == "1912-06-30", "1912-07-17", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "BA051" & `date of reporting period end` == "1914-10-14", "1914-11-12", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "FO002" & `date of reporting period end` == "1911-12-31", "1912-02-09", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "OT010" & `date of reporting period end` == "1913-12-31", "1914-02-12", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "OT051" & `date of reporting period end` == "1914-03-31", "1914-06-03", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "RL045" & `date of reporting period end` == "1910-12-31", "1911-01-23", as.character(`date of signing the letter`)),
    `date of signing the letter` = ifelse(id == "RL067" & `date of reporting period end` == "1913-12-31", "1914-02-19", as.character(`date of signing the letter`)),
    `date of auditing` = ifelse(id == "BA021" & `date of reporting period end` == "1911-06-30", "1911-07-13", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "BA025" & `date of reporting period end` == "1910-12-31", "1911-01-17", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "BA044" & `date of reporting period end` == "1914-10-14", "1914-11-12", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "GLC03" & `date of reporting period end` == "1909-12-31", "1910-01-28", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "IC011" & `date of reporting period end` == "1913-06-30", "1913-09-15", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "IC023" & `date of reporting period end` == "1912-09-30", "1912-11-13", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "OT010" & `date of reporting period end` == "1913-12-31", "1914-02-11", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "RL024" & `date of reporting period end` == "1914-06-30", "1914-11-18", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "RL047" & `date of reporting period end` == "1913-12-31", "1914-02-13", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "RL059" & `date of reporting period end` == "1912-12-31", "1913-02-12", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "RL067" & `date of reporting period end` == "1913-12-31", "1914-02-19", as.character(`date of auditing`)),
    `date of auditing` = ifelse(id == "TR008" & `date of reporting period end` == "1911-12-31", "1912-01-23", as.character(`date of auditing`)),
    `last day of closed books` = ifelse(id == "BR004" & `date of reporting period end` == "1910-09-30", "1911-01-04", as.character(`last day of closed books`)),
    `first day of closed books` = ifelse(id == "CN001" & `date of reporting period end` == "1913-06-30", "1913-12-01", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "OT010" & `date of reporting period end` == "1913-12-31", "1914-02-11", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "OT016" & `date of reporting period end` == "1911-04-12", "1911-05-11", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "RL007" & `date of reporting period end` == "1910-12-31", "1911-01-20", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "RL034" & `date of reporting period end` == "1910-06-30", "1910-07-03", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "RL064" & `date of reporting period end` == "1914-03-30", "1914-12-17", as.character(`first day of closed books`)),
    `first day of closed books` = ifelse(id == "RL069" & `date of reporting period end` == "1913-06-30", "1913-10-06", as.character(`first day of closed books`)),
    `last day of closed books` = ifelse(id == "BA016" & `date of reporting period end` == "1913-12-31", "1914-01-23", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "OT010" & `date of reporting period end` == "1913-12-31", "1914-02-28", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "OT016" & `date of reporting period end` == "1911-04-12", "1911-05-29", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "OT029" & `date of reporting period end` == "1914-06-30", "1915-01-04", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL001" & `date of reporting period end` == "1910-12-31", "1911-03-18", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL007" & `date of reporting period end` == "1910-12-31", "1911-02-03", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL034" & `date of reporting period end` == "1910-06-30", "1910-07-25", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL064" & `date of reporting period end` == "1914-03-30", "1914-12-31", as.character(`last day of closed books`)),
    `last day of closed books` = ifelse(id == "RL069" & `date of reporting period end` == "1913-06-30", "1913-10-22", as.character(`last day of closed books`)),
    `date of AGM` = ifelse(id == "BA016" & `date of reporting period end` == "1913-12-31", "1914-01-23", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "CN002" & `date of reporting period end` == "1912-12-31", "1913-03-14", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "FO003" & `date of reporting period end` == "1912-05-31", "1912-07-17", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "OT010" & `date of reporting period end` == "1913-12-31", "1914-02-26", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "RL028" & `date of reporting period end` == "1913-06-30", "1913-11-12", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "RL059" & `date of reporting period end` == "1912-12-31", "1913-02-20", as.character(`date of AGM`)),
    `date of AGM` = ifelse(id == "RL067" & `date of reporting period end` == "1913-12-31", "1914-03-05", as.character(`date of AGM`)),
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