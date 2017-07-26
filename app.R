source("chapters_source.R")
library(shinydashboard)
library(shiny)


## ui.R ##

ui <- dashboardPage(
  
  dashboardHeader(title = "R-Ladies Dashboard"),
    
  # Sidebar content
    dashboardSidebar(
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
      )
  ),
  
  ## Body content
  dashboardBody(
    fluidRow(
      # A static valueBox
      # valueBox(n_members, "R-Ladies Members", icon = icon("credit-card")),
      valueBox(n_cities, "R-Ladies Cities", icon = icon("map-marker"), color = "purple"),
      valueBox(n_countries, "R-Ladies Countries", icon = icon("map-o"))
      
    ),
    
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard"))
  )
)  
    
  
  

  
server <- function(input, output) { }


shinyApp(ui, server)








