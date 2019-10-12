library(shiny)
library(DT)
library(leaflet)

region_page_UI <- function(id, title, text){
  ns <- NS(id)
  
  tabPanel(title = title,
           fluidRow(
             column(width = 6,
                    valueBox(nrow(groups_usa), text, 
                             icon = icon("glyphicon-blackboard"), width = 12),
                    fluidRow(
                      column(width = 12,
                             box(width = 12, DT::dataTableOutput(ns("created"))))
                    )),
             column(width = 6,
                    leafletOutput(ns("map")))
           ))
}

region_page <- function(input, output, session, created_df, groups_df, popup){
  
  output$created <- DT::renderDataTable({
    datatable(created_df,
              rownames = FALSE,
              caption = "Created at")
  })
  
  output$map <- renderLeaflet({
    leaflet(groups_df) %>% 
      addTiles() %>%
      addMarkers(~lon, ~lat, popup = popup) 
  })
  
}