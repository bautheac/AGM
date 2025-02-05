suppressMessages(import(stringr))


export("correct_invalid_characters")
correct_invalid_characters <- function(prices){
  
  pattern_map <- c(
    "¼" = "1/4",
    "½" = "1/2",
    "¾" = "3/4",
    "⅛" = "1/8",
    "⅜" = "3/8",
    "⅝" = "5/8",
    "⅞" = "7/8",
    "\\.\\." = "",
    "TB" = ""
  )
  
  return(stringr::str_replace_all(prices, pattern_map))
}