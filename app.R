################################################################################
# Before running this app, install meetupr from lucy's branch
# devtools::install_github("rladies/meetupr", ref = "lucy")

# then get a meetup API key and set it as an environmental variable
# Sys.setenv(MEETUP_KEY = "YOUR_API_KEY_HERE")
################################################################################

source("chapters_source.R")
library(shinydashboard)
library(shiny)
library(leaflet)

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
      valueBox(n_cities, "R-Ladies Cities", icon = icon("map-marker"), color = "purple"),
      valueBox(n_countries, "R-Ladies Countries", icon = icon("map-o"))
      
    ),
    
    fluidRow(
      # A static valueBox
      valueBox(dim(rladies_groups)[1], "R-Ladies groups on meetup.com", icon = icon("glyphicon-blackboard")),
      valueBox(sum(rladies_groups$members), "R-Ladies members on meetup.com", icon = icon("users"))
      
    ),
    
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard", 
              leafletOutput('map'))
    )
  )
)  
    
  
  

  
server <- function(input, output) { 
  
  output$map <- renderLeaflet({
    leaflet(data = rladies_groups) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name))
  })
  
}


shinyApp(ui, server)








