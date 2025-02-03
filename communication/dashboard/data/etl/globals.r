suppressMessages(import(here))


path_paths <- here::here("communication", "dashboard", "globals", "paths.r")
paths <- modules::use(path_paths)


modules::export("directories")
directories <- c("datasets", "results")