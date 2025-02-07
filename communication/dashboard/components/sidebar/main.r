suppressMessages(import("shinydashboard"))


modules::export("ui")
ui <- function(){
  
  shinydashboard::dashboardSidebar(
    shinydashboard::sidebarMenu(
      id = "tabs",
      shinydashboard::menuItem(
        "Data", tabName = "data",
        shinydashboard::menuItem("Clean", tabName = "data-clean"),
        shinydashboard::menuItem("Corrupts", tabName = "data-corrupts")
      ),
      shinydashboard::menuItem(
        "Stats", tabName = "stats",
        shinydashboard::menuItem("Book", tabName = "stats-book"),
        shinydashboard::menuItem("Returns", tabName = "stats-returns"),
        shinydashboard::menuItem("High availability", tabName = "stats-availables")
      )
    )
  )
}