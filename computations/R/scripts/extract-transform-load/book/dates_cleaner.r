pacman::p_load(dplyr, lubridate, stringr)

correct_date_typos <- function(book_data){
  dplyr::mutate(
    book_data, 
    `Auditing date` = ifelse(`Auditing date` == "03/011914", "03/01/1914", `Auditing date`),
    `Auditing date` = ifelse(`Auditing date` == "40924", "4424", `Auditing date`),
    `First day of closed books` = ifelse(`First day of closed books` == "25/05/194", "25/05/1914", `First day of closed books`),
    `First day of closed books` = ifelse(`First day of closed books` == "41249", "4749", `First day of closed books`),
    `First day of closed books` = ifelse(`First day of closed books` == "43659", "3659", `First day of closed books`),
    `First day of closed books` = stringr::str_replace(`First day of closed books`, "-(\\d{2})\\?\\?", "-19\\1") |> stringr::str_replace("-", "\\\\"),
    `Last day of closed books` = as.numeric(as.Date(`Last day of closed books`) - as.Date("1899-12-30")),
    `Last day of closed books` = ifelse(`Last day of closed books` == "43680", "3680", `Last day of closed books`),
    `Last day of closed books` = ifelse(`Last day of closed books` == "41262", "4262", `Last day of closed books`),
    `Last day of closed books` = ifelse(`Last day of closed books` == "41262", "4762", `Last day of closed books`),
    `Last day of closed books` = ifelse(`Last day of closed books` == "41171", "4771", `Last day of closed books`),
    `Last day of closed books` = ifelse(`Last day of closed books` == "28326", "4326", `Last day of closed books`),
    `AGM Date` = ifelse(`AGM Date` == "43680", "3680", `AGM Date`),
    `AGM Date` = ifelse(`AGM Date` == "40933", "4433", `AGM Date`),
  )
}
convert_to_standard_date_format <- function(dates) {
  
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

export("clean_date_columns")
clean_date_columns <- function(book_data){
  
  correct_date_typos(book_data) |>
    dplyr::mutate(dplyr::across(dplyr::matches("date|day"), convert_to_standard_date_format))
}
