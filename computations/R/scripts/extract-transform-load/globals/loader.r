pacman::p_load(modules, readr)

export("load_rds")
load_rds <- function(object, path){
  
  readr::write_rds(object, path)
}
