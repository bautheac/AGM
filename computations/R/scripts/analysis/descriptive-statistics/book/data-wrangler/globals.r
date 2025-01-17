pacman::p_load(modules)

modules::export("variables_to_compute_distance_to_AGM_for")
variables_to_compute_distance_to_AGM_for <- c(
  "date of reporting period end",
  "date of signing the letter",
  "date of auditing",
  "first day of closed books",
  "last day of closed books"
)

modules::export("distance_to_AGM_variable_prefix")
distance_to_AGM_variable_prefix <- "# days to AGM from"

modules::export("distance_to_AGM_computed_variables")
distance_to_AGM_computed_variables <- paste(
  distance_to_AGM_variable_prefix, variables_to_compute_distance_to_AGM_for
)