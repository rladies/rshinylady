source("chapters_source.R")
library(shinydashboard)
library(shiny)
library(leaflet)

## ui.R ##

## UI CONFIG

## Header
header <- dashboardHeader(title = "R-Ladies Dashboard")

# Sidebar content
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "R-Ladies", tabName = "R-Ladies", icon = icon("dashboard")),
    menuItem(text = "By Region", tabName = "country", icon = icon("dashboard"))
  )
)

## Body content
body <-   
  dashboardBody(
    tabItems(
      
      # Front Page
      tabItem(
        selected = TRUE, 
        tabName = "R-Ladies", 
        navbarPage(
          title = 'R-Ladies',
          tabPanel(
            'TODAY',
            fluidRow(
              # A static valueBox
              valueBox(dim(rladies_groups)[1], "R-Ladies groups on meetup.com", icon = icon("glyphicon-blackboard"), width = 3),
              valueBox(length(unique(rladies_groups$country)), "R-Ladies Countries", icon = icon("map-o"), width = 3),
              valueBox(length(rladies_groups$city), "R-Ladies Cities", icon = icon("map-marker"), color = "purple", width = 3),
              valueBox(sum(rladies_groups$members), "R-Ladies members on meetup.com", icon = icon("users"), width = 3)
            ),
            leafletOutput('map')
          ))),
      
      # Second TAB
      tabItem(
        tabName = "country",
        navbarPage(
          title = 'R-Ladies',
          tabPanel(
            title = 'USA',
            fluidRow(
              column(
                width = 4,
              # A static valueBox
              valueBox(length(groups_usa), "R-Ladies groups in the US", 
                       icon = icon("glyphicon-blackboard"), width = 18
                       ),
              box("Created at", width = 18, tableOutput("created_usa")
                )
              ),
              column(
                width = 8,
              leafletOutput('map_usa',width = 600)
              )
            )
            
          )
        )
      )))




ui <- dashboardPage(header, sidebar, body)


server <- function(input, output) { 
  
  output$map <- renderLeaflet({
    leaflet(data = rladies_groups) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
    # makeAwesomeIcon(markerColor = "purple")
  })
  output$created_usa <- renderTable(created_usa, rownames = FALSE)
  output$map_usa <- renderLeaflet({
    leaflet(groups_usa) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, label = ~as.character(name)) 
  })
}


shinyApp(ui, server)








