suppressMessages({ modules::import(purrr); modules::import(readr)})



export("load_rds")
load_rds <- function(object, path){
  
  readr::write_rds(object, path)
}

export("load_object")
load_object <- function(object, path){
  
  load_rds(object, path)
}

export("load_objects")
load_objects <- function(objects, paths){
  
  purrr::walk2(objects, paths, function(object, path){
    purrr::walk(path, function(x) load_object(object, x))
  })
}
