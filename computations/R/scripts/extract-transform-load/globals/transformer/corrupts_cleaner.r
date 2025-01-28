pacman::p_load(dplyr, modules, rlang)


modules::export("correct_corrupt_records")
correct_corrupt_records <- function(data, corrupts) {
  
  corrected <- data
  for (i in seq_len(nrow(corrupts))) {
    row_i <- corrupts[i, ]
    
    column       <- row_i$column
    condition <- rlang::parse_expr(row_i$condition)
    new_value    <- row_i$new_value
    
    corrected <- dplyr::mutate(
      corrected, !!rlang::sym(column) := dplyr::if_else(eval(condition), new_value, .data[[column]])
    )
  }
  corrected
}